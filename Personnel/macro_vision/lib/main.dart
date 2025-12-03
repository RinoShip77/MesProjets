import 'dart:io';

import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:image_picker/image_picker.dart';
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

  // Charge le fichier .env
  await dotenv.load(fileName: ".env");

  // Initialisation des caméras
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

            // GESTION DES THÈMES
            themeMode: themeProvider.themeMode,

            theme: ThemeData(
              // Thème Clair (pour Light mode)
              primarySwatch: primaryColor,
              brightness: Brightness.light,
              appBarTheme: AppBarTheme(
                backgroundColor: primaryColor,
                foregroundColor: Colors.white,
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
                foregroundColor: Colors.white,
              ),
              colorScheme: ColorScheme.fromSwatch(
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
        child: Text(
          message,
          textAlign: TextAlign.center,
          style: const TextStyle(color: Colors.red),
        ),
      ),
    );
  }
}

// =========================================================================
// WIDGET D'AFFICHAGE DE LA CAMÉRA
// =========================================================================

class CameraScreen extends StatefulWidget {
  final CameraDescription camera;

  const CameraScreen({super.key, required this.camera});

  @override
  State<CameraScreen> createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;
  final GeminiService _geminiService = GeminiService();

  bool _isInitialized = false;
  bool _isAnalyzing = false;
  bool _showSuccessAnimation = false;

  final AudioPlayer _audioPlayer = AudioPlayer();
  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    _initializeCamera();
  }

  void _initializeCamera() {
    _controller = CameraController(
      widget.camera,
      ResolutionPreset.medium,
      enableAudio: false,
    );
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

  @override
  void dispose() {
    _controller.dispose();
    _audioPlayer.dispose();
    super.dispose();
  }

  // Gère la photo prise via la caméra
  Future<void> _takePhoto() async {
    if (!_isInitialized || _controller.value.isTakingPicture || _isAnalyzing) {
      return;
    }

    try {
      final XFile file = await _controller.takePicture();
      await _processImage(file.path);
    } catch (e) {
      debugPrint(e.toString());
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Erreur de capture : ${e.toString()}')),
        );
      }
    }
  }

  // Gère la sélection d'une image depuis la galerie
  Future<void> _selectFromGallery() async {
    if (_isAnalyzing) return;

    final XFile? file = await _picker.pickImage(source: ImageSource.gallery);
    if (file != null) {
      await _processImage(file.path);
    }
  }

  // Affiche l'icône de succès et attend brièvement
  Future<void> _showSuccessAndNavigate() async {
    setState(() {
      _showSuccessAnimation = true;
    });

    await Future.delayed(const Duration(milliseconds: 500));

    setState(() {
      _showSuccessAnimation = false;
    });
  }

  // Processus d'analyse (commun à la photo et à la galerie)
  Future<void> _processImage(String imagePath) async {
    if (!mounted) return;

    setState(() {
      _isAnalyzing = true;
    });

    try {
      // 1. Appeler le service Gemini
      final NutritionalFacts results = await _geminiService.analyzeImage(
        File(imagePath),
      );

      // FEEDBACK DE SUCCÈS
      await _audioPlayer.play(AssetSource('audio/success.mp3'));
      await HapticFeedback.mediumImpact();

      // Montrer l'animation avant la navigation
      await _showSuccessAndNavigate();

      // 2. Afficher les résultats
      // Enregistrer le fichier dans un emplacement temporaire pour l'écran de résultats
      final Directory appDocumentsDir = await getTemporaryDirectory();
      final String savedPath = '${appDocumentsDir.path}/temp_macro_vision_${DateTime.now().millisecondsSinceEpoch}.jpg';

      // Copier le fichier original
      await File(imagePath).copy(savedPath);

      // 1. Créer l'entrée d'historique
      final entry = NutritionalFactsEntry.fromAnalysis(results, savedPath);

      // 2. Enregistrer l'entrée dans la BDD
      await DatabaseService().insertEntry(entry);

      // 3. Afficher les résultats (maintenant, on utilise l'Entry)
      if (mounted) {
        await Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => ResultScreen(
              facts: results,
              imagePath: savedPath, // Toujours passer le chemin pour l'affichage immédiat
            ),
          ),
        );
      }
      // }
    } catch (e) {
      if (mounted) {
        // FEEDBACK D'ERREUR
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Analyse Alimentaire'),
        // Utilisez la couleur primaire, mais assurez-vous qu'elle soit transparente pour la vue caméra
        backgroundColor: Theme.of(context).colorScheme.primary,
        elevation: 0,
      ),
      extendBodyBehindAppBar: true, // Pour que l'image s'étende sous l'AppBar
      body: FutureBuilder<void>(
        future: _initializeControllerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done &&
              _isInitialized) {
            final size = MediaQuery.of(context).size;
            final scale =
                (size.aspectRatio * _controller.value.aspectRatio) * 1.5;

            return Stack(
              alignment: Alignment.center,
              children: [
                // 1. Vue de la Caméra (avec le nouveau Transform.scale)
                SizedBox.expand(
                  // <--- S'ASSURER QUE LA TAILLE EST MAXIMALE
                  child: Transform.scale(
                    scale: scale, // Utilise le nouveau calcul 'scale'
                    alignment: Alignment
                        .topCenter, // Centre l'image verticalement dans la zone visible
                    child: Center(child: CameraPreview(_controller)),
                  ),
                ),

                // 2. Surcouche d'Animation de Succès
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
                          ).primaryColor, // Utilise la couleur du thème
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
                color: Theme.of(context).primaryColor,
              ),
            );
          }
        },
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
              backgroundColor: Theme.of(context).colorScheme.primary,
              onPressed: _isAnalyzing ? null : _selectFromGallery,
              child: const Icon(Icons.photo_library),
            ),

            // 2. Bouton de CAPTURE PRINCIPAL
            FloatingActionButton(
              heroTag: 'captureBtn',
              onPressed: _isAnalyzing
                  ? null
                  : _takePhoto, // Déclenche _takePhoto
              backgroundColor: Theme.of(context).colorScheme.primary,
              shape: const CircleBorder(),
              child: _isAnalyzing
                  ? const CircularProgressIndicator(color: Colors.white)
                  : const Icon(Icons.camera_alt, size: 30),
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
