import 'package:flutter/material.dart';

// Packages Externes
import 'package:macro_vision/config/app_theme.dart';
import 'package:provider/provider.dart';

// Services et Modèles
import 'package:macro_vision/services/theme_provider.dart';

// Écrans de l'application
import 'package:macro_vision/screens/home_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Lancement de l'application
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
      ],
      child: const MacroVisionApp(), 
    ),
  );
}

class MacroVisionApp extends StatelessWidget {
  const MacroVisionApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        
        // CORRECTION DE L'ERREUR AppPrimaryColor: utiliser l'alias app_theme.
        final MaterialColor selectedSeedColor = 
            themeProvider.themeModeOption == ThemeModeOption.custom
            ? themeProvider.customTheme.color
            : appPrimaryColor; 

        return MaterialApp(
          title: 'MacroVision',
          debugShowCheckedModeBanner: false,
          themeMode: themeProvider.themeMode,
          theme: getLightTheme(selectedSeedColor), 
          darkTheme: getDarkTheme(selectedSeedColor), 
          
          home: const HomeScreen(),
        );
      },
    );
  }
}