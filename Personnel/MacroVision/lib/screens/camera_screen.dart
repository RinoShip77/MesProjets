import 'dart:io';
import 'package:flutter/material.dart';

// Packages Externes
import 'package:camera/camera.dart';
import 'package:image_picker/image_picker.dart';
import 'package:macro_vision/models/nutritional_facts_entry.dart';
import 'package:macro_vision/services/database_service.dart';

// Services et Modèles
import 'package:macro_vision/services/gemini_service.dart';
import 'package:macro_vision/models/nutritional_facts.dart';
import 'package:macro_vision/screens/result_screen.dart';

// Feedback Utilisateur
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';

// =========================================================================
// WIDGET D'AFFICHAGE DE LA CAMÉRA (CameraScreen)
// =========================================================================

class CameraScreen extends StatefulWidget {
  const CameraScreen({super.key});

  @override
  State<CameraScreen> createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  // Le contrôleur est maintenant optionnel car l'initialisation peut échouer
  CameraController? _controller;
  bool _isLoading = true;
  bool _hasCamera = false;
  bool _isAnalyzing = false;
  bool _showSuccessAnimation = false;
  bool _isFlashOn = false;

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
    } on CameraException catch (e) {
      _hasCamera = false;
      if (mounted) {
        // TODO: Envoyer cette fonction de un fichier "helpers.dart"
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Erreur lors du basculement du flash : ${e.toString()}',
              style: const TextStyle(color: Colors.white),
            ),
            backgroundColor: Colors.red,
          ),
        );
      }
      debugPrint("Erreur d'initialisation de la caméra: $e");
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
      } on CameraException catch (e) {
        if (mounted) {
          // TODO: Envoyer cette fonction de un fichier "helpers.dart"
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                'Erreur lors du basculement du flash : ${e.toString()}',
                style: const TextStyle(color: Colors.white),
              ),
              backgroundColor: Colors.red,
            ),
          );
        }
      }
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
          // TODO: Envoyer cette fonction de un fichier "helpers.dart"
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                'Erreur de capture : ${e.toString()}',
                style: const TextStyle(color: Colors.white),
              ),
              backgroundColor: Colors.red,
            ),
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
      final ImagePicker picker = ImagePicker();
      final XFile? image = await picker.pickImage(
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

  // 4.Processus d'analyse (commun à la photo ET à la galerie)
  Future<void> _analyseImage(String imagePath, {required String origin}) async {
    setState(() {
      _isAnalyzing = true;
    });

    try {
      // 1. Appeler le service Gemini
      final NutritionalFacts initialFacts = await GeminiService().analyzeImage(
        imagePath,
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
          // TODO: Envoyer cette fonction de un fichier "helpers.dart"
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                'Erreur d\'analyse : ${e.toString()}',
                style: const TextStyle(color: Colors.white),
              ),
              backgroundColor: Colors.red,
            ),
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

  // -----------------------------------------------------------
  // WIDGET DE CONSTRUCTION
  // -----------------------------------------------------------

  @override
  Widget build(BuildContext context) {
    // 1. Affichage de l'état de chargement
    if (_isLoading) {
      return Scaffold(
        appBar: AppBar(title: const Text('Caméra')),
        body: const Center(child: CircularProgressIndicator()),
      );
    }

    // 2. Affichage de l'état d'erreur ou d'absence de caméra
    if (!_hasCamera ||
        _controller == null ||
        !_controller!.value.isInitialized) {
      return Scaffold(
        appBar: AppBar(title: const Text('Caméra')),
        body: const Center(
          child: Padding(
            padding: EdgeInsets.all(32.0),
            child: Text(
              "Impossible d'accéder à la caméra. Vérifiez les permissions de l'application.",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18, color: Colors.red),
            ),
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Analyse alimentaire')),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: Stack(
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

          // 2. Bouton Flash/Lampe de poche (en haut à droite)
          Positioned(
            top: 60,
            right: 20,
            child: FloatingActionButton(
              heroTag: 'flashBtn',
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
            top: 10,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                "Conseil : Ciblez un aliment à la fois, avec une bonne lumière.",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Theme.of(context).colorScheme.onPrimary,
                ),
              ),
            ),
          ),

          // 4. Overlay d'analyse (si _isAnalyzing est true)
          if (_isAnalyzing)
            Container(
              color: Colors.black54,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(),
                    const SizedBox(height: 20),
                    Text(
                      'Analyse en cours par l\'IA...',
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
                        color: Colors.black.withAlpha(50),
                        blurRadius: 10,
                      ),
                    ],
                  ),
                );
              },
            ),
        ],
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
              onPressed: _isAnalyzing ? null : _selectFromGallery,
              child: const Icon(Icons.photo_library_rounded),
            ),

            // 2. Bouton de CAPTURE PRINCIPAL
            FloatingActionButton(
              heroTag: 'captureBtn',
              onPressed: _isAnalyzing
                  ? null
                  : _takePhoto, // Déclenche _takePhoto
              child: const Icon(Icons.camera_enhance_rounded),
            ),
          ],
        ),
      ),
    );
  }
}
