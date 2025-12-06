import 'dart:io';
import 'package:flutter/material.dart';

// Packages Externes
import 'package:camera/camera.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

// Services et Modèles
import 'package:macro_vision/services/gemini_service.dart';
import 'package:macro_vision/services/theme_provider.dart';
import 'package:macro_vision/models/nutritional_facts.dart';

// Écrans de l'application
import 'package:macro_vision/screens/home_screen.dart';
import 'package:macro_vision/screens/result_screen.dart';

// Feedback Utilisateur
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/services.dart';

// Base de Données Locale
import 'package:macro_vision/services/database_service.dart';
import 'package:macro_vision/models/nutritional_facts_entry.dart';

// Variable globale pour stocker la liste des caméras disponibles
List<CameraDescription>? cameras;

// =========================================================================
// FONCTION MAIN
// =========================================================================

Future<void> main() async {
  // Garantit que les widgets Flutter sont initialisés
  WidgetsFlutterBinding.ensureInitialized();

  // 1. Charge le fichier .env
  await dotenv.load(fileName: ".env");

  // 2. Initialisation des caméras
  try {
    cameras = await availableCameras();
  } on CameraException catch (e) {
    debugPrint('Erreur lors de l\'obtention des caméras : $e');
  }

  runApp(const MacroVisionApp());
}

// =========================================================================
// WIDGET PRINCIPAL DE L'APPLICATION (Gestion du Thème)
// =========================================================================

class MacroVisionApp extends StatelessWidget {
  const MacroVisionApp({super.key});

  @override
  Widget build(BuildContext context) {
    // 1. Initialiser le ThemeProvider
    return ChangeNotifierProvider(
      create: (context) => ThemeProvider(),
      child: Consumer<ThemeProvider>(
        builder: (context, themeProvider, child) {
          // 2. Déterminer l'écran initial (Caméra ou Erreur)
          Widget cameraOrErrorScreen;

          if (cameras != null && cameras!.isNotEmpty) {
            cameraOrErrorScreen = CameraScreen(camera: cameras!.first);
          } else {
            cameraOrErrorScreen = const ErrorScreen(
              message:
                  "Aucune caméra n'a été trouvée ou les permissions sont manquantes.",
            );
          }

          // 3. Déterminer la couleur primaire (personnalisée si mode custom)
          final MaterialColor primaryColor =
              themeProvider.themeModeOption == ThemeModeOption.custom
              ? themeProvider.customTheme.color
              : Colors.green;

          return MaterialApp(
            title: 'MacroVision AI',
            debugShowCheckedModeBanner: false,
            themeMode: themeProvider.themeMode,
            theme: ThemeData(
              // Thème Clair (pour Light mode)
              primarySwatch: primaryColor,
              brightness: Brightness.light,
              appBarTheme: AppBarTheme(
                backgroundColor: primaryColor,
                foregroundColor: Theme.of(context).colorScheme.onPrimary,
              ),
              colorScheme: ColorScheme.fromSwatch(
                primarySwatch: primaryColor,
                brightness: Brightness.light,
              ),
            ),

            darkTheme: ThemeData(
              // Thème Sombre (pour Dark mode)
              primarySwatch: primaryColor,
              brightness: Brightness.dark,
              appBarTheme: AppBarTheme(
                backgroundColor: primaryColor,
                foregroundColor: Theme.of(context).colorScheme.onPrimary,
              ),
              colorScheme: ColorScheme.fromSwatch(
                backgroundColor: Colors.black,
                primarySwatch: primaryColor,
                brightness: Brightness.dark,
              ),
            ),

            // L'application commence sur le nouvel HomeScreen
            home: HomeScreen(cameraScreen: cameraOrErrorScreen),
          );
        },
      ),
    );
  }
}

// =========================================================================
// WIDGET D'ERREUR
// =========================================================================

class ErrorScreen extends StatelessWidget {
  final String message;
  const ErrorScreen({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Erreur')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Text(
            message,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 18, color: Colors.red),
          ),
        ),
      ),
    );
  }
}

// =========================================================================
// WIDGET D'AFFICHAGE DE LA CAMÉRA (CameraScreen)
// =========================================================================

class CameraScreen extends StatefulWidget {
  final CameraDescription camera;

  const CameraScreen({super.key, required this.camera});

  @override
  State<CameraScreen> createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  bool _isInitialized = false;
  bool _isAnalyzing = false;
  bool _showSuccessAnimation = false;
  bool _isFlashOn = false;

  late CameraController _controller;
  late Future<void> _initializeControllerFuture;
  final GeminiService _geminiService = GeminiService();
  final AudioPlayer _audioPlayer = AudioPlayer();
  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    _initializeCamera();
  }

  // Initialisation de la caméra
  void _initializeCamera() {
    _controller = CameraController(widget.camera, ResolutionPreset.high);

    _initializeControllerFuture = _controller
        .initialize()
        .then((_) {
          if (mounted) {
            setState(() {
              _isInitialized = true;
            });
          }
        })
        .catchError((e) {
          debugPrint("Erreur d'initialisation de la caméra: $e");
        });
  }

  // Basculer le mode Flash
  Future<void> _toggleFlash() async {
    if (!_isInitialized) return; // Sécurité

    // Définir le mode Flash
    try {
      final newFlashMode = _isFlashOn ? FlashMode.off : FlashMode.torch;
      await _controller.setFlashMode(newFlashMode);

      // Mettre à jour l'état et forcer le rafraîchissement de l'icône
      setState(() {
        _isFlashOn = !_isFlashOn;
      });
    } on CameraException catch (e) {
      debugPrint("Erreur lors du basculement du flash : $e");
      // Optionnel : Afficher un Toast ou SnackBar à l'utilisateur
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    // _audioPlayer.dispose();
    // _picker.dispose();
    super.dispose();
  }

  // -----------------------------------------------------------
  // LOGIQUE DE CAPTURE ET D'ANALYSE
  // -----------------------------------------------------------

  // 1. Gère la photo prise via la caméra
  Future<void> _takePhoto() async {
    if (!_isInitialized || _controller.value.isTakingPicture) return;

    setState(() {
      _isAnalyzing = true;
    });

    await _audioPlayer.play(AssetSource('audio/shutter.mp3'));

    try {
      final XFile file = await _controller.takePicture();
      await _analyseImage(file.path);
    } catch (e) {
      debugPrint(e.toString());
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Erreur de capture : ${e.toString()}')),
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

  // 2. Gère la sélection d'une image depuis la galerie
  Future<void> _selectFromGallery() async {
    final XFile? image = await _picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 70,
      maxWidth: 1024,
    );

    if (image != null) {
      await _analyseImage(image.path);
    }
  }

  // 3. Affiche l'icône de succès et attend brièvement
  Future<void> _showSuccessAndNavigate() async {
    setState(() {
      _showSuccessAnimation = true;
    });

    await Future.delayed(const Duration(milliseconds: 500));

    setState(() {
      _showSuccessAnimation = false;
    });
  }

  // 4.Processus d'analyse (commun à la photo ET à la galerie)
  Future<void> _analyseImage(String imagePath) async {
    setState(() {
      _isAnalyzing = true;
    });

    try {
      // 1. Appeler le service Gemini
      final NutritionalFacts initialFacts = await _geminiService.analyzeImage(imagePath);

      // 2. FeedBack de succès
      await _audioPlayer.play(AssetSource('audio/success.mp3'));
      await HapticFeedback.mediumImpact();

      // 3. Montrer l'animation avant la navigation
      await _showSuccessAndNavigate();

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
        _audioPlayer.play(AssetSource('audio/error.mp3'));
        await HapticFeedback.mediumImpact();

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Erreur d\'analyse : ${e.toString()}')),
        );
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
    // Afficher l'écran de chargement si le contrôleur n'est pas prêt
    if (!_isInitialized) {
      return Scaffold(
        appBar: AppBar(title: const Text('Analyse Alimentaire')),
        body: const Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Analyse Alimentaire'),
        // Utilisez la couleur primaire, mais assurez-vous qu'elle soit transparente pour la vue caméra
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      body: FutureBuilder<void>(
        future: _initializeControllerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done &&
              _isInitialized) {
            return Stack(
              alignment: Alignment.center,
              children: [
                // 1. Vue de la Caméra (avec le nouveau Transform.scale)
                Positioned.fill(
                  child: Align(
                    alignment: const Alignment(
                      0.0,
                      0.5,
                    ),
                    child: CameraPreview(_controller),
                  ),
                ),

                // 2. Bouton Flash/Lampe de poche (en haut à droite)
                Positioned(
                  top: 90,
                  right: 20,
                  child: FloatingActionButton(
                    heroTag: 'flashBtn',
                    onPressed: _isAnalyzing ? null : _toggleFlash,
                    backgroundColor: _isFlashOn
                        ? Theme.of(context).colorScheme.primary
                        : Theme.of(context).primaryColorDark,
                    child: Icon(
                      _isFlashOn ? Icons.flash_on : Icons.flash_off,
                      color: _isFlashOn
                          ? Theme.of(context).primaryColorDark
                          : Theme.of(context).primaryColorLight,
                    ),
                  ),
                ),

                // 3. Guide de Cadrage Visuel (texte centré en bas ou en haut)
                Positioned(
                  top: 20,
                  left: 20,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 5,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.black54, // Fond sombre semi-transparent
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Text(
                      "Conseil : Ciblez un aliment à la fois, avec une bonne lumière.",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),

                // 4. Cadre Visuel pour le Cadrage
                Center(
                  child: Container(
                    width:
                        MediaQuery.of(context).size.width *
                        0.8, // 80% de la largeur
                    height:
                        MediaQuery.of(context).size.width * 0.8, // Cadre carré
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.white70, // Couleur du cadre
                        width: 2,
                      ),
                    ),
                  ),
                ),

                // 5. Overlay d'analyse (si _isAnalyzing est true)
                if (_isAnalyzing)
                  Container(
                    color: Colors.black54,
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircularProgressIndicator(
                            color: Theme.of(context).colorScheme.primary,
                          ),
                          const SizedBox(height: 20),
                          const Text(
                            'Analyse en cours par l\'IA...',
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          ),
                        ],
                      ),
                    ),
                  ),

                // 6. Surcouche d'Animation de Succès
                if (_showSuccessAnimation)
                  TweenAnimationBuilder<double>(
                    tween: Tween<double>(begin: 0.0, end: 1.0),
                    duration: const Duration(milliseconds: 300),
                    builder: (context, scale, child) {
                      return Transform.scale(
                        scale: scale,
                        child: Icon(
                          Icons.check_circle,
                          color: Theme.of(
                            context,
                          ).colorScheme.primary, // Utilise la couleur du thème
                          size: 150,
                          shadows: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.5),
                              blurRadius: 10,
                            ),
                          ],
                        ),
                      );
                    },
                  ),
              ],
            );
          } else if (snapshot.hasError) {
            return const Center(
              child: Text("Erreur de chargement de la caméra."),
            );
          } else {
            // Afficher un indicateur de chargement
            return Center(
              child: CircularProgressIndicator(
                color: Theme.of(context).colorScheme.primary,
              ),
            );
          }
        },
      ),

      // Boutons de Galerie et de Capture (Horizontal)
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(left: 20.0, right: 40.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            // 1. Bouton de SÉLECTION/GALERIE
            FloatingActionButton(
              heroTag: 'galleryBtn',
              backgroundColor: Theme.of(context).colorScheme.primary,
              onPressed: _isAnalyzing ? null : _selectFromGallery,
              child: const Icon(Icons.photo_library_rounded),
            ),

            // 2. Bouton de CAPTURE PRINCIPAL
            FloatingActionButton(
              heroTag: 'captureBtn',
              onPressed: _isAnalyzing
                  ? null
                  : _takePhoto, // Déclenche _takePhoto
              backgroundColor: Theme.of(context).colorScheme.primary,
              shape: const CircleBorder(),
              child: const Icon(Icons.camera_enhance_rounded),
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
