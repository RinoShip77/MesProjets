import 'dart:io';
import 'package:flutter/material.dart';

// Packages Externes
import 'package:camera/camera.dart';
import 'package:google_mlkit_barcode_scanning/google_mlkit_barcode_scanning.dart';
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

enum CameraMode {
  mealAnalysis, // Photo + Galerie
  labelScanner, // OCR Tableau nutritionnel
  barcodeScanner, // ML Kit Code-barres
}

class CameraScreen extends StatefulWidget {
  final CameraMode mode; // Ajout du mode

  const CameraScreen({
    super.key,
    this.mode = CameraMode.mealAnalysis, // Mode par défaut
  });

  @override
  State<CameraScreen> createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  // Le contrôleur est maintenant optionnel car l'initialisation peut échouer
  CameraController? _controller;
  final ImagePicker _picker = ImagePicker();
  final GeminiService _geminiService =
      GeminiService(); // Assurez-vous d'importer le service
  final BarcodeScanner _barcodeScanner = BarcodeScanner();
  bool _isLoading = true;
  bool _hasCamera = false;
  bool _isAnalyzing = false;
  bool _showSuccessAnimation = false;
  bool _isFlashOn = false;
  bool _isScanningBarcode = false;
  bool _isProcessingBarcode = false; // Verrou de sécurité
  double _currentZoom = 1.0;
  late CameraMode _currentMode;
  ScaffoldMessengerState? _messenger;

  // Contrôleurs pour le dialogue de confirmation
  final TextEditingController _calController = TextEditingController();
  final TextEditingController _protController = TextEditingController();
  final TextEditingController _carbsController = TextEditingController();
  final TextEditingController _fatController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _initializeCamera();
    _currentMode = widget.mode;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Save a reference to the ScaffoldMessenger while we have access to it
    _messenger = ScaffoldMessenger.of(context);
  }

  @override
  void dispose() {
    // Use the saved reference to clear bars.
    // This works even if the widget is already unmounted.
    _messenger?.clearSnackBars();
    _controller?.dispose();
    // Toujours nettoyer les contrôleurs
    _calController.dispose();
    _protController.dispose();
    _carbsController.dispose();
    _fatController.dispose();
    _barcodeScanner.close(); // Important pour libérer la mémoire
    super.dispose();
  }

  // Initialisation de la caméra
  Future<void> _initializeCamera() async {
    try {
      final List<CameraDescription> cameras = await availableCameras();

      if (cameras.isEmpty) {
        _hasCamera = false;
        _controller = null;
      } else {
        // 1. Choix de la résolution dynamique
        // final resolution = (widget.mode == CameraMode.barcodeScanner)
        //     ? ResolutionPreset.high
        //     : ResolutionPreset.medium;

        // 1. Choix de la résolution dynamique
        // 1. Choix de la résolution dynamique (Switch Expression)
        final resolution = switch (widget.mode) {
          // Barcode: High is fast and sharp enough for 1D codes
          CameraMode.barcodeScanner => ResolutionPreset.high,

          // Label: CRITICAL. Must be VeryHigh/Max to read tiny text on crinkled bags
          CameraMode.labelScanner => ResolutionPreset.veryHigh,

          // Meal: Medium is faster for sending to API and sufficient for recognizing food
          CameraMode.mealAnalysis => ResolutionPreset.medium,
        };

        _controller = CameraController(
          cameras.first,
          resolution,
          enableAudio: false,
          // 2. Format universel par plateforme pour ML Kit
          imageFormatGroup: Platform.isAndroid
              ? ImageFormatGroup.yuv420
              : ImageFormatGroup.bgra8888,
        );

        await _controller!.initialize();

        // 3. Activation du focus continu pour la détection de précision
        if (widget.mode != CameraMode.mealAnalysis) {
          try {
            await _controller!.setFocusMode(FocusMode.auto);
          } catch (e) {
            debugPrint(
              "Le focus continu n'est pas supporté sur cet appareil: $e",
            );
          }
        }

        _hasCamera = true;

        // 4. Lancement automatique du flux pour le code-barres
        if (widget.mode == CameraMode.barcodeScanner) {
          _controller?.startImageStream((image) => _scanBarcode(image));
        }

        // 5. Auto-turn on flash (torch mode) only for Label Scanning to reduce shadows/blur
        if (widget.mode == CameraMode.labelScanner) {
          // Give the camera a moment to initialize before turning on the light
          Future.delayed(const Duration(milliseconds: 500), () {
            if (mounted) {
              _controller?.setFlashMode(FlashMode.auto);
              // _toggleFlash();
            }
          });
        }
      }
    } on CameraException catch (e) {
      _hasCamera = false;
      debugPrint("Erreur caméra: ${e.description}");
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  InputImage? _inputImageFromCameraImage(CameraImage image) {
    if (_controller == null) return null;

    final camera = _controller!.description;
    final sensorOrientation = camera.sensorOrientation;
    final InputImageRotation? rotation = InputImageRotationValue.fromRawValue(
      sensorOrientation,
    );
    if (rotation == null) return null;

    if (Platform.isAndroid && image.format.raw != 35) return null;

    final width = image.width;
    final height = image.height;

    // Allocation du buffer exact : Y (width*height) + UV (width*height/2)
    final Uint8List bytes = Uint8List(width * height * 3 ~/ 2);
    int offset = 0;

    // Plan Y (Luminance)
    final Plane yPlane = image.planes[0];
    final int yStride = yPlane.bytesPerRow;
    final Uint8List yBuffer = yPlane.bytes;

    for (int y = 0; y < height; y++) {
      bytes.setRange(
        offset,
        offset + width,
        yBuffer.sublist(y * yStride, y * yStride + width),
      );
      offset += width;
    }

    // Plans U et V (Chrominance)
    final Plane uPlane = image.planes[1];
    final Plane vPlane = image.planes[2];
    final Uint8List uBuffer = uPlane.bytes;
    final Uint8List vBuffer = vPlane.bytes;
    final int uvStride = uPlane.bytesPerRow;
    // ✅ CORRECTION : Utilisation de bytesPerPixel au lieu de pixelStride
    final int uvPixelStride = uPlane.bytesPerPixel ?? 1;

    for (int y = 0; y < height ~/ 2; y++) {
      for (int x = 0; x < width ~/ 2; x++) {
        final int uvIndex = y * uvStride + x * uvPixelStride;
        bytes[offset++] = vBuffer[uvIndex];
        bytes[offset++] = uBuffer[uvIndex];
      }
    }

    return InputImage.fromBytes(
      bytes: bytes,
      metadata: InputImageMetadata(
        size: Size(width.toDouble(), height.toDouble()),
        rotation: rotation,
        format: InputImageFormat
            .nv21, // ML Kit préfère NV21 sur Android après reconstruction
        bytesPerRow: width,
      ),
    );
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

  Future<void> _toggleZoom() async {
    if (_controller == null || !_controller!.value.isInitialized) return;

    try {
      // On alterne entre 1.0x et 2.0x
      final newZoom = _currentZoom == 1.0 ? 2.0 : 1.0;

      // On vérifie les limites de l'appareil par sécurité
      final maxZoom = await _controller!.getMaxZoomLevel();
      final minZoom = await _controller!.getMinZoomLevel();

      final targetZoom = newZoom.clamp(minZoom, maxZoom);

      await _controller!.setZoomLevel(targetZoom);
      setState(() {
        _currentZoom = targetZoom;
      });

      HapticFeedback.selectionClick(); // Petit retour tactile
    } catch (e) {
      debugPrint("Erreur Zoom: $e");
    }
  }

  Future<void> _scanBarcode(CameraImage image) async {
    // 1. Barrière de sécurité
    if (_isProcessingBarcode || _isAnalyzing || !mounted) return;

    final inputImage = _inputImageFromCameraImage(image);
    if (inputImage == null) return;

    try {
      final List<Barcode> barcodes = await _barcodeScanner.processImage(
        inputImage,
      );

      if (barcodes.isNotEmpty && !_isProcessingBarcode) {
        final String? code = barcodes.first.rawValue;

        if (code != null) {
          // 2. Verrouillage et Arrêt immédiat
          _isProcessingBarcode = true;
          await _controller?.stopImageStream();

          // 3. Feedbacks Utilisateur (Son + Vibration + Animation)
          final player = AudioPlayer();
          await player.play(AssetSource('audio/success.mp3'));
          await HapticFeedback.mediumImpact();
          _showSuccess(); // Déclenche votre icône check-circle

          setState(() => _isAnalyzing = true);

          // 4. Appel à l'API Gemini
          final data = await _geminiService.analyseBarcode(
            code,
            Localizations.localeOf(context).languageCode,
          );

          if (data != null) {
            // Clear any previous "Error" snackbars before showing success
            if (mounted) ScaffoldMessenger.of(context).clearSnackBars();

            // 5. Conversion et Enregistrement
            final facts = NutritionalFacts.fromJson(data);

            // On crée l'entrée avec un chemin d'image vide pour le code-barres
            final entry = NutritionalFactsEntry.fromAnalysis(facts, "");
            final entryId = await DatabaseService().insertEntry(entry);

            if (mounted) {
              // 6. Navigation vers l'écran de résultat
              final NutritionalFacts? refinedFacts = await Navigator.of(context)
                  .push(
                    MaterialPageRoute(
                      builder: (context) => ResultScreen(
                        initialFacts: facts,
                        imagePath: "",
                        origin: "barcode",
                      ),
                    ),
                  );

              // 7. Mise à jour si l'utilisateur a ajusté les valeurs
              if (refinedFacts != null) {
                final updatedEntry = NutritionalFactsEntry.fromAnalysis(
                  refinedFacts,
                  "",
                  id: entryId, // Utilisation de l'ID existant pour l'UPDATE
                );
                await DatabaseService().insertEntry(updatedEntry);
              }
            }
          } else {
            if (mounted) {
              // FAILURE: OpenFoodFacts didn't know it.
              ScaffoldMessenger.of(context).clearSnackBars();
              _currentMode = CameraMode.mealAnalysis;
              showSnackBar(
                context,
                'Unknown barcode. Try a photo scan?',
                false,
                action: SnackBarAction(
                  label: 'TAKE PHOTO',
                  onPressed: () {
                    // 1. Kill the SnackBar instantly
                    ScaffoldMessenger.of(context).clearSnackBars();
                    // 2. Perform your actions
                    _isProcessingBarcode = false;
                    _scanPhoto();
                  },
                ),
              );
            }
          }
        }
      }
    } catch (e) {
      debugPrint('Error Scan/API: $e');
      _resetScanner();
    } finally {
      if (mounted) setState(() => _isAnalyzing = false);
    }
  }

  // Fonction utilitaire pour relancer le scan après un échec ou un retour
  void _resetScanner() {
    if (mounted && widget.mode == CameraMode.barcodeScanner) {
      setState(() {
        _isProcessingBarcode = false;
        _isAnalyzing = false;
      });
      _controller?.startImageStream((image) => _scanBarcode(image));
    }
  }

  Future<void> _scanLabel() async {
    if (_controller == null ||
        !_controller!.value.isInitialized ||
        _isAnalyzing)
      return;

    try {
      setState(() => _isAnalyzing = true);

      // 1. Prise de la photo (Haute qualité pour que Gemini lise bien le texte)
      // Note: Pour une étiquette, on veut la meilleure résolution possible.
      final XFile image = await _controller!.takePicture();

      // --- FEEDBACK CAPTURE ---
      final player = AudioPlayer();
      await player.play(AssetSource('audio/shutter.mp3'));

      final bytes = await image.readAsBytes();

      // Analyse via votre nouveau prompt Gemini
      final data = await _geminiService.analyzeLabel(
        bytes,
        Localizations.localeOf(context).languageCode,
      );

      if (data != null) {
        // --- FEEDBACK SUCCÈS ---
        await player.play(AssetSource('audio/success.mp3'));
        await HapticFeedback.mediumImpact();
        await _showSuccess(); // Votre animation de succès existante

        // ✅ UTILISATION DE VOTRE FACTORY
        final facts = NutritionalFacts.fromJson(data);

        // Sauvegarde de l'image temporaire pour l'affichage
        final Directory appDocumentsDir = await getTemporaryDirectory();
        final String savedPath =
            '${appDocumentsDir.path}/label_scan_${DateTime.now().millisecondsSinceEpoch}.jpg';
        await File(image.path).copy(savedPath);

        // 1. Créer l'entrée initiale pour obtenir un ID
        final entry = NutritionalFactsEntry.fromAnalysis(facts, savedPath);

        // 2. Insérer en base de données
        final entryId = await DatabaseService().insertEntry(entry);

        if (mounted) {
          await Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => ResultScreen(
                initialFacts: facts,
                imagePath: savedPath,
                origin: "label_ocr",
              ),
            ),
          );
        }
      }
    } catch (e) {
      debugPrint("Erreur scan du label : $e");
      // Feedback d'erreur existant
      final player = AudioPlayer();
      await player.play(AssetSource('audio/error.mp3'));
      await HapticFeedback.heavyImpact();
    } finally {
      if (mounted) setState(() => _isAnalyzing = false);
    }
  }

  // 1. Gère la photo prise via la caméra
  Future<void> _scanPhoto() async {
    if (_controller == null ||
        _isAnalyzing ||
        _controller!.value.isTakingPicture) {
      return;
    } else {
      setState(() => _isAnalyzing = true);
      final player = AudioPlayer();
      await player.play(AssetSource('audio/shutter.mp3'));

      try {
        // Capture directement depuis le flux caméra existant
        final XFile file = await _controller!.takePicture();
        await _processImage(file.path, origin: runtimeType.toString());
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
  Future<void> _selectInGallery() async {
    if (_isAnalyzing) {
      return;
    } else {
      final XFile? image = await _picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 70,
        maxWidth: 1024,
      );

      if (image != null) {
        await _processImage(image.path, origin: runtimeType.toString());
      }
    }
  }

  // 4.Processus d'analyse (commun à la photo ET à la galerie)
  Future<void> _processImage(String imagePath, {required String origin}) async {
    setState(() {
      _isAnalyzing = true;
    });

    try {
      // 1. Appeler le service Gemini
      final NutritionalFacts? initialFacts = await _geminiService.analyzeImage(
        imagePath,
        Localizations.localeOf(
          context,
        ).languageCode, // ✅ Récupère 'fr', 'en', etc.
      );

      // --- GUARDRAIL: Check for "Not Food" ---
      // If the AI followed our prompt and found no food, it returns this specific name.
      if (initialFacts != null && initialFacts.foodName.toLowerCase().contains('not food detected')) {
        
        // 1. Play Error Sound
        final player = AudioPlayer();
        await player.play(AssetSource('audio/error.mp3'));
        await HapticFeedback.heavyImpact();

        // 2. Show UI Warning
        if (mounted) {
          ScaffoldMessenger.of(context).clearSnackBars();
          showSnackBar(
            context,
            'No food detected. Please try a clearer photo.', // Or use l10n
            true, // isError = true (Red color)
          );
        }
        
        // 3. STOP EVERYTHING. Do not save to DB. Do not navigate.
        return; 
      }

      // 2. FeedBack de succès
      final player = AudioPlayer();
      await player.play(AssetSource('audio/success.mp3'));
      await HapticFeedback.mediumImpact();

      // 3. Montrer l'animation avant la navigation
      await _showSuccess();

      // 2. Préparation du chemin d'enregistrement
      final Directory appDocumentsDir = await getTemporaryDirectory();
      final String savedPath =
          '${appDocumentsDir.path}/temp_macro_vision_${DateTime.now().millisecondsSinceEpoch}.jpg';
      await File(imagePath).copy(savedPath);

      // 3. Créer et insérer l'entrée initiale pour obtenir un ID
      final entry = NutritionalFactsEntry.fromAnalysis(
        initialFacts!,
        savedPath,
      );
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
              border: Border.all(
                color: _isScanningBarcode
                    ? Colors.red
                    : Colors.green, // Rouge si on scanne activement
                width: _isScanningBarcode ? 3 : 2,
              ),
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildContextualActionButton() {
    switch (widget.mode) {
      case CameraMode.mealAnalysis:
        return FloatingActionButton(
          heroTag: 'captureBtn',
          tooltip: context.l10n.cameraScreenBtn('camera'),
          onPressed: _isAnalyzing ? null : _scanPhoto, // Déclenche _takePhoto,
          child: const Icon(Icons.camera_alt_rounded),
        );

      case CameraMode.labelScanner:
        return Tooltip(
          message: "Scanner une étiquette",
          child: ElevatedButton.icon(
            label: const Text("Scanner l'étiquette"),
            onPressed: _isAnalyzing ? null : _scanLabel,
            icon: const Icon(Icons.document_scanner_rounded),
          ),
        );

      case CameraMode.barcodeScanner:
        // 💡 PLUS DE BOUTON CLIQUABLE : Juste une indication visuelle
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          decoration: BoxDecoration(
            color: Colors.black54,
            borderRadius: BorderRadius.circular(20),
          ),
          child: const Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.qr_code_scanner, color: Colors.white),
              SizedBox(width: 10),
              Text(
                "Centrez le code-barres",
                style: TextStyle(color: Colors.white),
              ),
            ],
          ),
        );
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
      body: Stack(
        alignment: Alignment.center,
        children: [
          // 1. Vue de la Caméra
          Positioned.fill(
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(30.0), // Adjust radius as needed
                topRight: Radius.circular(30.0),
              ),
              child: AspectRatio(
                aspectRatio: _controller!.value.aspectRatio,
                child: CameraPreview(_controller!),
              ),
            ),
          ),

          // 2. : L'overlay de guidage pour le scan
          if (_currentMode == CameraMode.barcodeScanner) _buildCameraOverlay(),

          // 3. Guide de Cadrage Visuel (texte centré en bas ou en haut)
          Positioned(
            left: 10,
            right: 10,
            top: 10,
            child: Container(
              padding: const EdgeInsets.all(5.0),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                textAlign: TextAlign.center,
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

          // 2. Bouton Flash/Lampe de poche (en haut à droite)
          Positioned(
            top: 60,
            right: 20,
            child: FloatingActionButton(
              heroTag: 'flashBtn',
              tooltip: context.l10n.cameraScreenBtn('flash'),
              onPressed: _isAnalyzing ? null : _toggleFlash,
              child: Icon(
                _isFlashOn ? Icons.flash_on_sharp : Icons.flash_off_sharp,
              ),
            ),
          ),

          // 2. Bouton Flash/Lampe de poche (en haut à droite)
          // Dans votre Stack, à côté du bouton Flash
          Positioned(
            top: 130, // Un peu plus bas que le bouton Flash
            right: 20,
            child: FloatingActionButton(
              heroTag: 'zoomBtn',
              mini: true, // Plus petit pour ne pas encombrer
              onPressed: _isAnalyzing ? null : _toggleZoom,
              backgroundColor: Colors.black54,
              child: Text(
                "${_currentZoom.toInt()}x",
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),

          // 4. Overlay d'analyse (si _isAnalyzing est true)
          if (_isAnalyzing)
            Container(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surfaceDim.withAlpha(150),
                borderRadius: BorderRadius.circular(20), // Rounds the corners
              ),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const CircularProgressIndicator(),
                    const SizedBox(height: 20),
                    Text(
                      context.l10n.cameraScreenAnalysisInProgressLbl,
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                  ],
                  // ],
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

      // Boutons de Galerie et de Capture (Horizontal)
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          if (widget.mode ==
              CameraMode.mealAnalysis) // Galerie uniquement pour les repas
            FloatingActionButton(
              heroTag: 'galleryBtn',
              tooltip: context.l10n.cameraScreenBtn('gallery'),
              onPressed: _isAnalyzing ? null : _selectInGallery,
              child: const Icon(Icons.photo_library_rounded),
            ),

          _buildContextualActionButton(),
        ],
      ),
    );
  }
}
