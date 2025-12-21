import 'dart:io';
import 'package:flutter/material.dart';

// Packages Externes
import 'package:camera/camera.dart';
import 'package:image_picker/image_picker.dart';
import 'package:macro_vision/helpers/helpers.dart';
import 'package:macro_vision/models/nutritional_facts_entry.dart';
import 'package:macro_vision/services/database_service.dart';
import 'package:macro_vision/utils/l10n_extension.dart';

// Services et Modèles
import 'package:macro_vision/services/gemini_service.dart';
import 'package:macro_vision/models/nutritional_facts.dart';
import 'package:macro_vision/screens/result_screen.dart';

// Feedback Utilisateur
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/services.dart';
import 'package:macro_vision/widgets/custom_app_bar.dart';
import 'package:path_provider/path_provider.dart';

class CameraScreen extends StatefulWidget {
  const CameraScreen({super.key});

  @override
  State<CameraScreen> createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  // Le contrôleur est maintenant optionnel car l'initialisation peut échouer
  CameraController? _controller;
  final ImagePicker _picker = ImagePicker();
  final GeminiService _geminiService =
      GeminiService(); // Assurez-vous d'importer le service
  bool _isLoading = true;
  bool _hasCamera = false;
  bool _isAnalyzing = false;
  bool _showSuccessAnimation = false;
  bool _isFlashOn = false;

  // Contrôleurs pour le dialogue de confirmation
  final TextEditingController _calController = TextEditingController();
  final TextEditingController _protController = TextEditingController();
  final TextEditingController _carbsController = TextEditingController();
  final TextEditingController _fatController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _initializeCamera();
  }

  // Initialisation de la caméra
  Future<void> _initializeCamera() async {
    try {
      // 1. Recherche des caméras disponibles (logique déplacée ici)
      final List<CameraDescription> cameras = await availableCameras();

      if (cameras.isEmpty) {
        // Aucune caméra trouvée
        _hasCamera = false;
        _controller = null;
      } else {
        // Caméra trouvée, initialisation du contrôleur
        _controller = CameraController(
          cameras.first, // Utilise la première caméra trouvée
          ResolutionPreset.medium,
          enableAudio: false,
        );

        await _controller!.initialize();
        await _controller!.setFlashMode(FlashMode.off);
        _hasCamera = true;
      }
    } on CameraException {
      _hasCamera = false;
      if (mounted) {
        showSnackBar(
          context,
          context.l10n.cameraScreenErrors('initialization'),
          true,
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  void dispose() {
    _controller?.dispose();
    // Toujours nettoyer les contrôleurs
    _calController.dispose();
    _protController.dispose();
    _carbsController.dispose();
    _fatController.dispose();
    super.dispose();
  }

  // -----------------------------------------------------------
  // LOGIQUE DE CAPTURE ET D'ANALYSE
  // -----------------------------------------------------------
  Future<void> _toggleFlash() async {
    if (_controller == null || _isAnalyzing) {
      return;
    } else {
      try {
        final newFlashMode = _isFlashOn ? FlashMode.off : FlashMode.torch;
        await _controller!.setFlashMode(newFlashMode);

        // Mettre à jour l'état et forcer le rafraîchissement de l'icône
        setState(() {
          _isFlashOn = !_isFlashOn;
        });
      } on CameraException {
        if (mounted) {
          showSnackBar(context, context.l10n.cameraScreenErrors('flash'), true);
        }
      }
    }
  }

  void _onScanLabelPressed() async {
    if (_controller == null ||
        !_controller!.value.isInitialized ||
        _isAnalyzing)
      return;

    setState(() => _isAnalyzing = true);

    try {
      // Capture directement depuis le flux caméra existant
      final XFile image = await _controller!.takePicture();
      final bytes = await image.readAsBytes();

      showLoadingDialog(context);

      // Analyse via votre nouveau prompt Gemini
      final data = await _geminiService.analyzeNutritionTable(
        bytes,
        Localizations.localeOf(context).languageCode,
      );

      if (mounted) Navigator.pop(context); // Fermer le loader

      if (data != null) {
        // Pré-remplissage des contrôleurs pour le dialogue
        _calController.text = data['calories']?.toString() ?? "0";
        _protController.text = data['proteins']?.toString() ?? "0";
        _carbsController.text = data['carbs']?.toString() ?? "0";
        _fatController.text = data['fat']?.toString() ?? "0";

        _showConfirmationDialog(data);
      }
    } catch (e) {
      debugPrint("Erreur lors du scan : $e");
    } finally {
      if (mounted) setState(() => _isAnalyzing = false);
    }
  }

  // 1. Gère la photo prise via la caméra
  Future<void> _takePhoto() async {
    if (_controller == null ||
        _isAnalyzing ||
        _controller!.value.isTakingPicture) {
      return;
    } else {
      setState(() {
        _isAnalyzing = true;
      });

      final player = AudioPlayer();
      await player.play(AssetSource('audio/shutter.mp3'));

      try {
        final XFile file = await _controller!.takePicture();
        await _analyseImage(file.path, origin: runtimeType.toString());
      } catch (e) {
        if (mounted) {
          showSnackBar(
            context,
            context.l10n.cameraScreenErrors('capture'),
            true,
          );
        }
      } finally {
        // Remettre l'état d'analyse à false (sauf si une navigation a eu lieu)
        if (mounted) {
          setState(() {
            _isAnalyzing = false;
          });
        }
      }
    }
  }

  // 2. Gère la sélection d'une image depuis la galerie
  Future<void> _selectFromGallery() async {
    if (_isAnalyzing) {
      return;
    } else {
      final XFile? image = await _picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 70,
        maxWidth: 1024,
      );

      if (image != null) {
        await _analyseImage(image.path, origin: runtimeType.toString());
      }
    }
  }

  // 3. Affiche l'icône de succès et attend brièvement
  Future<void> _showSuccess() async {
    setState(() {
      _showSuccessAnimation = true;
    });

    await Future.delayed(const Duration(milliseconds: 500));

    setState(() {
      _showSuccessAnimation = false;
    });
  }

  void _saveEntryToDatabase() async {
    // 1. Récupération des valeurs textuelles converties en nombres
    final double calories = double.tryParse(_calController.text) ?? 0;
    final double proteins = double.tryParse(_protController.text) ?? 0;
    final double carbs = double.tryParse(_carbsController.text) ?? 0;
    final double fat = double.tryParse(_fatController.text) ?? 0;

    // 2. Création de l'objet NutritionalFactsEntry
    // Note : On peut laisser le chemin d'image vide ou mettre une icône par défaut pour les scans d'étiquettes
    final entry = NutritionalFactsEntry(
      timestamp: DateTime.now().millisecondsSinceEpoch,
      imagePath: "", // Ou le chemin de la photo du scan si vous souhaitez la garder
      foodName: "Scan Étiquette",
      portionInGrams: 0,
      calories: calories,
      totalFat: fat,
      saturatedFat: 0,
      transFat: 0,
      cholesterol: 0,
      sodium: 0,
      potassium: 0,
      totalCarbohydrates: carbs,
      sugar: 0,
      dietaryFiber: 0,
      protein: proteins,
    );

    try {
      // 3. Appel de l'insertion
      await DatabaseService().insertEntry(entry);

      if (mounted) {
        showSnackBar(context, "Données enregistrées avec succès !", false);
      }
    } catch (e) {
        showSnackBar(context, "Erreur lors de l'enregistrement", true);
      debugPrint("Erreur lors de l'enregistrement : $e");
    }
  }

  // 4.Processus d'analyse (commun à la photo ET à la galerie)
  Future<void> _analyseImage(String imagePath, {required String origin}) async {
    setState(() {
      _isAnalyzing = true;
    });

    try {
      // 1. Appeler le service Gemini
      final NutritionalFacts initialFacts = await _geminiService.analyzeImage(
        imagePath,
        Localizations.localeOf(
          context,
        ).languageCode, // ✅ Récupère 'fr', 'en', etc.
      );

      // 2. FeedBack de succès
      final player = AudioPlayer();
      await player.play(AssetSource('audio/success.mp3'));
      await HapticFeedback.lightImpact();

      // 3. Montrer l'animation avant la navigation
      await _showSuccess();

      // 2. Préparation du chemin d'enregistrement
      final Directory appDocumentsDir = await getTemporaryDirectory();
      final String savedPath =
          '${appDocumentsDir.path}/temp_macro_vision_${DateTime.now().millisecondsSinceEpoch}.jpg';
      await File(imagePath).copy(savedPath);

      // 3. Créer et insérer l'entrée initiale pour obtenir un ID
      final entry = NutritionalFactsEntry.fromAnalysis(initialFacts, savedPath);
      final entryId = await DatabaseService().insertEntry(entry);

      // 4. Afficher les résultats et attendre l'ajustement utilisateur
      if (mounted) {
        final NutritionalFacts? refinedFacts = await Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => ResultScreen(
              initialFacts: initialFacts, // Passage de l'objet initial de l'IA
              imagePath: savedPath,
              origin: origin,
            ),
          ),
        );

        // 5. Mise à jour de la base de données si l'utilisateur a ajusté l'analyse
        if (refinedFacts != null) {
          // Créer une nouvelle entrée (avec l'ID existant) basée sur les faits ajustés
          final updatedEntry = NutritionalFactsEntry.fromAnalysis(
            refinedFacts,
            savedPath,
            id: entryId, // Utilise l'ID pour forcer la mise à jour (via ConflictAlgorithm.replace)
          );

          // Mettre à jour l'entrée dans la base de données
          await DatabaseService().insertEntry(updatedEntry);
        }
      }
    } catch (e) {
      if (mounted) {
        // 6. FeedBack d'erreur
        final player = AudioPlayer();
        await player.play(AssetSource('audio/error.mp3'));
        await HapticFeedback.heavyImpact();

        if (mounted) {
          showSnackBar(
            context,
            context.l10n.cameraScreenErrors('analysis'),
            true,
          );
        }
      }
    } finally {
      if (mounted) {
        setState(() {
          _isAnalyzing = false;
        });
      }
    }
  }

  void _showConfirmationDialog(Map<String, dynamic> data) {
    // Utilisez des TextEditingController pré-remplis avec data['calories'], etc.
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          context.l10n.cameraScreenConfirmFactsLbl,
        ), // Ajoutez cette clé dans vos .arb
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _calController,
              decoration: InputDecoration(labelText: 'Calories'),
            ),
            TextField(
              controller: _protController,
              decoration: InputDecoration(labelText: 'Protéines (g)'),
            ),
            TextField(
              controller: _carbsController,
              decoration: InputDecoration(labelText: 'Glucides (g)'),
            ),
            TextField(
              controller: _fatController,
              decoration: InputDecoration(labelText: 'Lipides (g)'),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Annuler'),
          ),
          ElevatedButton(
            onPressed: () {
              // Sauvegarder dans votre DatabaseService
              _saveEntryToDatabase();
              Navigator.pop(context);
            },
            child: Text('Enregistrer'),
          ),
        ],
      ),
    );
  }

  void showLoadingDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const Center(child: CircularProgressIndicator()),
    );
  }

  Widget _buildCameraOverlay() {
    return Stack(
      children: [
        // Fond assombri avec un trou au milieu (ClipPath)
        ColorFiltered(
          colorFilter: ColorFilter.mode(
            Colors.black.withOpacity(0.5),
            BlendMode.srcOut,
          ),
          child: Stack(
            children: [
              Container(
                decoration: const BoxDecoration(
                  color: Colors.black,
                  backgroundBlendMode: BlendMode.dstOut,
                ),
              ),
              // Le rectangle "vide" pour le scan
              Align(
                alignment: Alignment.center,
                child: Container(
                  height: 250,
                  width: 300,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ],
          ),
        ),
        // Bordure visuelle du rectangle
        Align(
          alignment: Alignment.center,
          child: Container(
            height: 250,
            width: 300,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.green, width: 2),
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
      ],
    );
  }

  // -----------------------------------------------------------
  // WIDGET DE CONSTRUCTION
  // -----------------------------------------------------------

  @override
  Widget build(BuildContext context) {
    // 1. Affichage de l'état de chargement
    if (_isLoading) {
      return Scaffold(
        appBar: CustomAppBar(
          title: context.l10n.cameraScreenTitle,
          backButton: true,
        ),
        body: const Center(child: CircularProgressIndicator()),
      );
    }

    // 2. Affichage de l'état d'erreur ou d'absence de caméra
    if (!_hasCamera ||
        _controller == null ||
        !_controller!.value.isInitialized) {
      return Scaffold(
        appBar: CustomAppBar(
          title: context.l10n.cameraScreenTitle,
          backButton: true,
        ),
        body: Center(
          child: Padding(
            padding: EdgeInsets.all(32.0),
            child: Text(
              context.l10n.cameraScreenErrors('permissions'),
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18,
                color: Theme.of(context).colorScheme.error,
              ),
            ),
          ),
        ),
      );
    }

    return Scaffold(
      appBar: CustomAppBar(
        title: context.l10n.cameraScreenTitle,
        backButton: true,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      extendBodyBehindAppBar: !_isAnalyzing ? true : false,
      body: Padding(
        padding: EdgeInsets.only(top: !_isAnalyzing ? kToolbarHeight + 55 : 0),
        child: Stack(
          alignment: Alignment.center,
          children: [
            // 1. Vue de la Caméra
            Positioned.fill(
              child: Align(
                alignment: const Alignment(0.0, -1.0),
                child: Padding(
                  padding: EdgeInsetsGeometry.only(top: 50.0),
                  child: CameraPreview(_controller!),
                ),
              ),
            ),

            // // 💡 AJOUT : L'overlay de guidage pour le scan
            // _buildCameraOverlay(),

            // 2. Bouton Flash/Lampe de poche (en haut à droite)
            Positioned(
              top: 60,
              right: 20,
              child: FloatingActionButton(
                heroTag: 'flashBtn',
                tooltip: context.l10n.cameraScreenBtn('flash'),
                onPressed: _isAnalyzing ? null : _toggleFlash,
                // backgroundColor: _isFlashOn
                //     ? Theme.of(context).colorScheme.primary
                //     : Colors.black87,
                child: Icon(
                  _isFlashOn ? Icons.flash_on_sharp : Icons.flash_off_sharp,
                  // color: _isFlashOn
                  //     ? Colors.black87
                  //     : Theme.of(context).colorScheme.primary,
                ),
              ),
            ),

            // 3. Guide de Cadrage Visuel (texte centré en bas ou en haut)
            Positioned(
              left: 10,
              right: 10,
              top: 10,
              child: Container(
                padding: const EdgeInsets.all(5.0),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  context.l10n.cameraScreenVisualHintLbl,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: Theme.of(context).colorScheme.onPrimary,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),

            // 4. Overlay d'analyse (si _isAnalyzing est true)
            if (_isAnalyzing)
              Container(
                decoration: BoxDecoration(
                  color: Theme.of(
                    context,
                  ).colorScheme.surfaceDim.withAlpha(150),
                  borderRadius: BorderRadius.circular(20), // Rounds the corners
                ),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircularProgressIndicator(),
                      const SizedBox(height: 20),
                      Text(
                        context.l10n.cameraScreenAnalysisInProgressLbl,
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

            // 5. Surcouche d'Animation de Succès
            if (_showSuccessAnimation)
              TweenAnimationBuilder<double>(
                tween: Tween<double>(begin: 0.0, end: 1.0),
                duration: const Duration(milliseconds: 300),
                builder: (context, scale, child) {
                  return Transform.scale(
                    scale: scale,
                    child: Icon(
                      Icons.check_circle,
                      color: Theme.of(context).colorScheme.primary,
                      size: 150,
                      shadows: [
                        BoxShadow(
                          color: Theme.of(context).colorScheme.primary,
                          blurRadius: 10,
                        ),
                      ],
                    ),
                  );
                },
              ),
          ],
        ),
      ),

      // Boutons de Galerie et de Capture (Horizontal)
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(left: 20.0, right: 20.0, bottom: 20.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            // 1. Bouton de SÉLECTION/GALERIE
            FloatingActionButton(
              heroTag: 'galleryBtn',
              tooltip: context.l10n.cameraScreenBtn('gallery'),
              onPressed: _isAnalyzing ? null : _selectFromGallery,
              child: const Icon(Icons.photo_library_rounded),
            ),

            // 💡 NOUVEAU : Bouton SCAN ÉTIQUETTE (Milieu)
            FloatingActionButton(
              heroTag: 'scanBtn',
              tooltip: "Scanner une étiquette",
              backgroundColor: Colors.green, // Couleur distincte
              onPressed: _isAnalyzing ? null : _onScanLabelPressed,
              child: const Icon(Icons.document_scanner_rounded),
            ),

            // 2. Bouton de CAPTURE PRINCIPAL
            FloatingActionButton(
              heroTag: 'captureBtn',
              tooltip: context.l10n.cameraScreenBtn('camera'),
              onPressed: _isAnalyzing
                  ? null
                  : _takePhoto, // Déclenche _takePhoto
              child: const Icon(Icons.camera_alt_rounded),
            ),
          ],
        ),
      ),
    );
  }
}
