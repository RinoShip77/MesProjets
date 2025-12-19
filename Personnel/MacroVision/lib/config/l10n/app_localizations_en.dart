// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String appDialogTitle(String target) {
    String _temp0 = intl.Intl.selectLogic(target, {
      'legalWarning': 'Avertissement légale',
      'userGuide': 'Guide de l\'utilisateur',
      'other': 'Langue non supportée',
    });
    return '$_temp0';
  }

  @override
  String appLanguageName(String target) {
    String _temp0 = intl.Intl.selectLogic(target, {
      'fr': 'French',
      'en': 'English',
      'other': 'Unsupported language',
    });
    return '$_temp0';
  }

  @override
  String get appLoadingLbl => 'Initialisation...';

  @override
  String appSaveBtn(String context) {
    return 'Sauvegarder $context';
  }

  @override
  String get appSeeHistoryBtn => 'Voir l\'historique';

  @override
  String get dashboardScreenTitle => 'Dashboard';

  @override
  String get errorDelete => 'Erreur de suppression';

  @override
  String get errorForm => 'Form error. Please check your entries';

  @override
  String get errorGlobal => 'An error occurred';

  @override
  String get errorLoadingAssets => 'Error: Unable to load file';

  @override
  String get errorLoadingContent => 'Error loading data';

  @override
  String errorReadFile(String context) {
    String _temp0 = intl.Intl.selectLogic(context, {
      'legalWarning': 'Erreur: Impossible de lire l\'avertissement légale',
      'userGuide': 'Erreur: Impossible de lire le guide utilisateur',
      'other': 'Erreur: Impossible de lire le fichier',
    });
    return '$_temp0';
  }

  @override
  String get feedbackScreenTitle => 'Feedback';

  @override
  String homeScreenDailyAnalisisLbl(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Analyses ($count)',
      one: 'Analysis (1)',
      zero: 'No analysis',
    );
    return '$_temp0';
  }

  @override
  String historyScreenDeleteSuccessLbl(String date) {
    return 'L\'entrée du $date a été supprimée de l\'historique';
  }

  @override
  String get historyScreenTitle => 'Historique';

  @override
  String get homeScreenDailySummaryLbl => 'Daily Summary';

  @override
  String homeScreenDailySummaryStatLbl(int stat) {
    return 'sur $stat g';
  }

  @override
  String homeScreenDailySummaryMacroCardLbl(String field) {
    String _temp0 = intl.Intl.selectLogic(field, {
      'carbohydrate': 'Glu',
      'protein': 'Pro',
      'fat': 'Lip',
      'other': 'Stat',
    });
    return '$_temp0';
  }

  @override
  String get homeScreenStartAnalysisBtn => 'Analyser un repas';

  @override
  String get homeScreenTitle => 'Home';

  @override
  String get homeScreenWelcomeLbl => 'Bienvenue sur MacroVision';

  @override
  String initializationScreenDialogDefaultLbl(String target) {
    String _temp0 = intl.Intl.selectLogic(target, {
      'legalWarning': 'Chargement de l\'avertissement légale...',
      'userGuide': 'Chargement des instructions...',
      'other': 'Chargement du contenu...',
    });
    return '$_temp0';
  }

  @override
  String get profileScreenActivityLevelLbl => 'Niveau d\'activité physique';

  @override
  String profileScreenActivityLevelOption(String target) {
    String _temp0 = intl.Intl.selectLogic(target, {
      'sedentary': 'Sédentaire (peu ou pas d\'exercice)',
      'lightly': 'Légèrement actif (1-3 jours/semaine)',
      'moderate': 'Modérément actif (3-5 jours/semaine)',
      'very': 'Très actif (6-7 jours/semaine)',
      'extra': 'Extrêmement actif (2x/jour)',
      'other': 'Aucun',
    });
    return '$_temp0';
  }

  @override
  String get profileScreenGenderLbl => 'Sexe';

  @override
  String profileScreenGenderOption(String target) {
    String _temp0 = intl.Intl.selectLogic(target, {
      'male': 'Homme',
      'female': 'Femme',
      'other': 'Autre',
    });
    return '$_temp0';
  }

  @override
  String get profileScreenGoalLbl => 'Objectif principal';

  @override
  String profileScreenGoalOption(String target) {
    String _temp0 = intl.Intl.selectLogic(target, {
      'weightLoss': 'Weight Loss',
      'muscleGain': 'Muscle Gain',
      'maintain': 'Maintenance',
      'other': 'None',
    });
    return '$_temp0';
  }

  @override
  String profileScreenHeightLbl(String unit) {
    return 'Height ($unit)';
  }

  @override
  String profileScreenInpLbl(String target, String unit) {
    String _temp0 = intl.Intl.selectLogic(target, {
      'weight': 'Weight ($unit)',
      'height': 'Height ($unit)',
      'other': '$unit',
    });
    return '$_temp0';
  }

  @override
  String get profileScreenNameLbl => 'Username';

  @override
  String get profileScreenTitle => 'Profile';

  @override
  String profileScreenUnitOption(String unit) {
    String _temp0 = intl.Intl.selectLogic(unit, {
      'metric': 'Metric',
      'imperial': 'Imperial',
      'other': 'None',
    });
    return '$_temp0';
  }

  @override
  String get profileScreenUnitSystemLbl => 'Unit System';

  @override
  String profileScreenWeightLbl(String unit) {
    return 'Weight ($unit)';
  }

  @override
  String resultScreenEstimatedWeightLbl(String weight, String unit) {
    return 'Portion estimé par l\'IA : $weight $unit';
  }

  @override
  String resultScreenAnalysisOutputLbl(String context) {
    String _temp0 = intl.Intl.selectLogic(context, {
      'energy': 'Énergie',
      'calories': 'Calories',
      'totalFat': 'Lipides',
      'saturatedFat': 'Saturés',
      'transFat': 'Trans',
      'cholesterol': 'Cholestérol',
      'sodium': 'Sodium',
      'potassium': 'Potassium',
      'totalCarbohydrate': 'Glucides',
      'dietaryFiber': 'Fibres',
      'sugar': 'Sucres',
      'protein': 'Protéines',
      'other': 'Nutriments',
    });
    return '$_temp0';
  }

  @override
  String resultScreenAnalysisSummaryLbl(String weight, String unit) {
    return 'Analyse nutrionnelle pour $weight $unit';
  }

  @override
  String get resultScreenNewAnalysisBtn => 'Analyser une nouvelle photo';

  @override
  String resultScreenPortionLbl(String unit) {
    return 'Poid réel ($unit)';
  }

  @override
  String get resultScreenRefineAnalysisBtn => 'Ajuster l\'analyse';

  @override
  String resultScreenRefineAnalysisLbl(String weight, String unit) {
    return 'Analyse ajustée pour $weight ($unit)';
  }

  @override
  String resultScreenSwitchLbl(String unit) {
    String _temp0 = intl.Intl.selectLogic(unit, {
      'kJ': 'Afficher en kcal/cal',
      'cal': 'Afficher en kJ',
      'other': 'changer d\'unitée',
    });
    return '$_temp0';
  }

  @override
  String get resultScreenTitle => 'Résultat';

  @override
  String settingsScreenCustomThemeOption(String color) {
    String _temp0 = intl.Intl.selectLogic(color, {
      'mint': 'Mint',
      'ocean': 'Ocean',
      'passion': 'Passion',
      'neon': 'Neon',
      'platinum': 'Platinum',
      'merlot': 'Merlot',
      'lemon': 'Lemon',
      'lime': 'Lime',
      'peacock': 'Peacock',
      'azure': 'Azure',
      'candy': 'Candy',
      'pumpkin': 'Pumpkin',
      'lapis': 'Lapis',
      'scarlet': 'Scarlet',
      'other': 'Color',
    });
    return '$_temp0';
  }

  @override
  String get settingsScreenLanguageSelectLbl => 'Language';

  @override
  String settingsScreenLuminosityOption(String target) {
    String _temp0 = intl.Intl.selectLogic(target, {
      'default': 'System Default',
      'light': 'Light Mode',
      'dark': 'Dark Mode',
      'other': 'None',
    });
    return '$_temp0';
  }

  @override
  String settingsScreenSectionLbl(String target) {
    String _temp0 = intl.Intl.selectLogic(target, {
      'language': 'App Language',
      'luminosity': 'App Brightness',
      'color': 'Custom Colors',
      'other': 'Settings',
    });
    return '$_temp0';
  }

  @override
  String get settingsScreenTitle => 'Settings';

  @override
  String statsCalorie(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Calories: $count',
      one: 'Calorie: 1',
      zero: 'Calorie: 0',
    );
    return '$_temp0';
  }

  @override
  String successUpdate(String context) {
    return '$context has been successfully updated';
  }

  @override
  String tooltipSwitch(String option1, String option2) {
    return '$option1 or $option2';
  }

  @override
  String get warningEmptyData => 'No data';

  @override
  String warningFormValidation(String target) {
    String _temp0 = intl.Intl.selectLogic(target, {
      'weight': 'Enter a valid weight',
      'height': 'Enter a valid height',
      'age': 'Enter a valid age',
      'other': 'Invalid input',
    });
    return '$_temp0';
  }
}
