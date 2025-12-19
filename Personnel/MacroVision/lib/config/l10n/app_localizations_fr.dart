// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for French (`fr`).
class AppLocalizationsFr extends AppLocalizations {
  AppLocalizationsFr([String locale = 'fr']) : super(locale);

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
      'fr': 'Français',
      'en': 'Anglais',
      'other': 'Langue non supportée',
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
  String get dashboardScreenTitle => 'Tableau de bord';

  @override
  String get errorDelete => 'Erreur de suppression';

  @override
  String get errorForm =>
      'Erreur dans le formulaire. Veuillez vérifier vos entrées';

  @override
  String get errorGlobal => 'Une erreur s\'est produite';

  @override
  String get errorLoadingAssets => 'Erreur: Impossible de charger le fichier';

  @override
  String get errorLoadingContent => 'Erreur de chargement des données';

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
  String get feedbackScreenTitle => 'Commentaire';

  @override
  String homeScreenDailyAnalisisLbl(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Analyses ($count)',
      one: 'Analyse (1)',
      zero: 'Aucune analyse',
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
  String get homeScreenDailySummaryLbl => 'Résumé quotidien';

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
  String get homeScreenTitle => 'Accueil';

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
      'weightLoss': 'Perte de poids',
      'muscleGain': 'Gain musculaire',
      'maintain': 'Maintien',
      'other': 'Aucun',
    });
    return '$_temp0';
  }

  @override
  String profileScreenHeightLbl(String unit) {
    return 'Grandeur ($unit)';
  }

  @override
  String profileScreenInpLbl(String target, String unit) {
    String _temp0 = intl.Intl.selectLogic(target, {
      'weight': 'Poids ($unit)',
      'height': 'Grandeur ($unit)',
      'other': '$unit',
    });
    return '$_temp0';
  }

  @override
  String get profileScreenNameLbl => 'Nom d\'utilisateur';

  @override
  String get profileScreenTitle => 'Profil';

  @override
  String profileScreenUnitOption(String unit) {
    String _temp0 = intl.Intl.selectLogic(unit, {
      'metric': 'Métrique',
      'imperial': 'Impérial',
      'other': 'Aucun',
    });
    return '$_temp0';
  }

  @override
  String get profileScreenUnitSystemLbl => 'Système d\'unité';

  @override
  String profileScreenWeightLbl(String unit) {
    return 'Poids ($unit)';
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
      'mint': 'Menthe',
      'ocean': 'Océan',
      'passion': 'Passion',
      'neon': 'Néon',
      'platinum': 'Platine',
      'merlot': 'Merlot',
      'lemon': 'Citron',
      'lime': 'Lime',
      'peacock': 'Paon',
      'azure': 'Azure',
      'candy': 'Bonbon',
      'pumpkin': 'Citrouille',
      'lapis': 'Lapis',
      'scarlet': 'Écarlate',
      'other': 'Couleur',
    });
    return '$_temp0';
  }

  @override
  String get settingsScreenLanguageSelectLbl => 'Langue';

  @override
  String settingsScreenLuminosityOption(String target) {
    String _temp0 = intl.Intl.selectLogic(target, {
      'default': 'Défaut du système',
      'light': 'Mode clair',
      'dark': 'Mode sombre',
      'other': 'Aucun',
    });
    return '$_temp0';
  }

  @override
  String settingsScreenSectionLbl(String target) {
    String _temp0 = intl.Intl.selectLogic(target, {
      'language': 'Langue de l\'application',
      'luminosity': 'Luminosité de l\'application',
      'color': 'Couleurs personnalisées',
      'other': 'Paramètres',
    });
    return '$_temp0';
  }

  @override
  String get settingsScreenTitle => 'Paramètres';

  @override
  String statsCalorie(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Calories : $count',
      one: 'Calorie : 1',
      zero: 'Calorie : 0',
    );
    return '$_temp0';
  }

  @override
  String successUpdate(String context) {
    String _temp0 = intl.Intl.selectLogic(context, {
      'profile': 'Le profile a été mis à jour avec succès',
      'history': 'L\'historique a été mis à jour avec succès',
      'other': 'Mise à jour réussie',
    });
    return '$_temp0';
  }

  @override
  String tooltipSwitch(String option1, String option2) {
    return '$option1 ou $option2';
  }

  @override
  String get warningEmptyData => 'Aucune données';

  @override
  String warningFormValidation(String target) {
    String _temp0 = intl.Intl.selectLogic(target, {
      'weight': 'Entrez un poids valide',
      'height': 'Entrez une grandeur valide',
      'age': 'Entrez un âge valide',
      'other': 'Entrée invalide',
    });
    return '$_temp0';
  }
}
