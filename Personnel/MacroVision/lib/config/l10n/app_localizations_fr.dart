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
  String get appError => 'Une erreur s\'est produite';

  @override
  String get appErrorDelete => 'Erreur de suppression';

  @override
  String get appErrorForm =>
      'Erreur dans le formulaire. Veuillez vérifier vos entrées';

  @override
  String get appErrorLoadingAssets =>
      'Erreur: Impossible de charger le fichier';

  @override
  String get appErrorLoadingContent => 'Erreur de chargement des données';

  @override
  String appErrorReadFile(String context) {
    String _temp0 = intl.Intl.selectLogic(context, {
      'legalWarning': 'Erreur: Impossible de lire l\'avertissement légale',
      'userGuide': 'Erreur: Impossible de lire le guide utilisateur',
      'other': 'Erreur: Impossible de lire le fichier',
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
  String get appRefreshDataLbl => 'Rafraîchir les données';

  @override
  String get appSeeHistoryBtn => 'Voir l\'historique';

  @override
  String appSuccessUpdate(String context) {
    String _temp0 = intl.Intl.selectLogic(context, {
      'profile': 'Le profile a été mis à jour avec succès',
      'history': 'L\'historique a été mis à jour avec succès',
      'other': 'Mise à jour réussie',
    });
    return '$_temp0';
  }

  @override
  String appSummaryLbl(String duration) {
    String _temp0 = intl.Intl.selectLogic(duration, {
      'daily': 'Résumé quotidion',
      'weekly': 'Résumé hebdomadaire',
      'other': '',
    });
    return '$_temp0';
  }

  @override
  String get appUserNameInpLbl => 'Nom d\'utilisateur';

  @override
  String get appWarningEmptyData => 'Aucune données';

  @override
  String appWarningFormValidation(String target) {
    String _temp0 = intl.Intl.selectLogic(target, {
      'age': 'Entrez un âge valide',
      'weight': 'Entrez un poids valide',
      'height': 'Entrez une grandeur valide',
      'comment': 'Veuillez saisir votre commentaire',
      'other': 'Entrée invalide',
    });
    return '$_temp0';
  }

  @override
  String btnSaveLbl(String context) {
    return 'Sauvegarder $context';
  }

  @override
  String get btnSeeHistoryLbl => 'Voir l\'historique';

  @override
  String get cameraScreenAnalysisInProgressLbl =>
      'Analyse en cours par l\'IA...';

  @override
  String cameraScreenBtn(String context) {
    String _temp0 = intl.Intl.selectLogic(context, {
      'flash': 'Basculement du flash',
      'gallery': 'Sélectionner une image depuis la galerie',
      'camera': 'Prendre une photo',
      'other': 'Caméra',
    });
    return '$_temp0';
  }

  @override
  String get cameraScreenConfirmFactsLbl => 'Confirmer les valeurs';

  @override
  String cameraScreenErrors(String type) {
    String _temp0 = intl.Intl.selectLogic(type, {
      'initialization': 'Erreur d\'initialisation de la caméra',
      'flash': 'Erreur lors du basculement du flash',
      'capture': 'Erreur de capture',
      'analysis': 'Erreur d\'analyse',
      'permissions':
          'Impossible d\'accéder à la caméra. Vérifiez les permissions de l\'application',
      'other': 'Erreur dde caméra',
    });
    return '$_temp0';
  }

  @override
  String get cameraScreenTitle => 'Analyse alimentaire';

  @override
  String get cameraScreenVisualHintLbl =>
      'Conseil : Ciblez un aliment à la fois, avec une bonne lumière';

  @override
  String dashboardScreenChartTypeOption(String type) {
    String _temp0 = intl.Intl.selectLogic(type, {
      'bars': 'Barres',
      'lines': 'Lignes',
      'other': 'Graphique',
    });
    return '$_temp0';
  }

  @override
  String get dashboardScreenDailyMealLogsLbl => 'Journal des repas';

  @override
  String get dashboardScreenDailyObjectivesLbl => 'Objectifs';

  @override
  String dashboardScreenDailyObjectiveLbl(String target) {
    String _temp0 = intl.Intl.selectLogic(target, {
      'calories': 'Calories',
      'protein': 'Protéines',
      'totalFat': 'Lipides',
      'totalCarbohydrate': 'Glucides',
      'other': 'Nutriments',
    });
    return '$_temp0';
  }

  @override
  String get dashboardScreenNotEnoughDataLbl =>
      'Historique insuffisant pour le graphique';

  @override
  String get dashboardScreenSelectChartTypeLbl =>
      'Afficher les données dans un graphiques à barres ou à lignes';

  @override
  String get dashboardScreenTitle => 'Tableau de bord';

  @override
  String dashboardScreenDailyWaterIntakeDialogAction(String target) {
    String _temp0 = intl.Intl.selectLogic(target, {
      'cancel': 'Annuler',
      'add': 'Ajouter',
      'other': 'Action',
    });
    return '$_temp0';
  }

  @override
  String get dashboardScreenDailyWaterIntakeDialogInpLbl => 'Millilitres (ml)';

  @override
  String get dashboardScreenDailyWaterIntakeDialogTitle =>
      'Quantité personnalisée';

  @override
  String get dashboardScreenDailyWaterIntakeLbl => 'Eau';

  @override
  String get dashboardScreenDailyWaterLogsLbl => 'Hydratation';

  @override
  String get dashboardScreenWeeklySummaryLbl =>
      'Résumé hebdomadaire (Calories)';

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
  String get errorReadUserGuide =>
      'Erreur: Impossible de lire le guide utilisateur';

  @override
  String get errorScreenDetailsLbl => 'Détails (visible en mode Débogage) :';

  @override
  String errorScreenGoToBtn(String target) {
    String _temp0 = intl.Intl.selectLogic(target, {
      'comment': 'Soumettre un commentaire',
      'restart': 'Redémarrer l\'application',
      'other': '',
    });
    return '$_temp0';
  }

  @override
  String get errorScreenTitle => 'Erreur';

  @override
  String get feedbackScreenCommentHintLbl =>
      'Décrivez votre expérience, signalez un bug ou proposez une idée...';

  @override
  String get feedbackScreenCommentPaceholderLbl => 'Votre message ...';

  @override
  String get feedbackScreenEncouragingMessageLbl =>
      'J\'apprécie vos retours ! Aidez-moi à améliorer MacroVision';

  @override
  String get feedbackScreenNoEmailClientLbl =>
      'Impossible d\'ouvrir l\'application d\'e-mail';

  @override
  String get feedbackScreenNoRecipientEmailLbl =>
      'L\'adresse e-mail de feedback est manquante';

  @override
  String get feedbackScreenOpeningEmailLbl =>
      'Ouverture de l\'application de messagerie';

  @override
  String feedbackScreenSendBtn(String state) {
    String _temp0 = intl.Intl.selectLogic(state, {
      'true': 'Envoi en cours...',
      'false': 'Envoyer la rétroaction',
      'other': '',
    });
    return '$_temp0';
  }

  @override
  String get feedbackScreenSendToClipboard =>
      'Envoyer mon message vers le presse-papiers';

  @override
  String get feedbackScreenSendTooltip => 'Envoyer la rétroaction';

  @override
  String feedbackScreenSendedToClipboard(String context) {
    String _temp0 = intl.Intl.selectLogic(context, {
      'comment': 'Commentaire envoyé dans le presse-papiers',
      'email': 'Adresse courriel envoyé dans le presse-papiers',
      'other': 'Envoyé dans le presse-papiers',
    });
    return '$_temp0';
  }

  @override
  String get feedbackScreenSendingError =>
      'Erreur lors de l\'envoi du feedback';

  @override
  String get feedbackScreenTitle => 'Commentaire';

  @override
  String historyScreenDeleteSuccessLbl(String date) {
    return 'L\'entrée du $date a été supprimée de l\'historique';
  }

  @override
  String get historyScreenTitle => 'Historique';

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
  String homeScreenDailySummaryMacroCardLbl(String field) {
    String _temp0 = intl.Intl.selectLogic(field, {
      'carbohydrate': 'Glucides',
      'protein': 'Protéines',
      'fat': 'Lipides',
      'other': 'Nutriments',
    });
    return '$_temp0';
  }

  @override
  String homeScreenDailySummaryStatLbl(int stat) {
    return 'sur $stat g';
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
  String profileScreenDietaryPreferencesOption(String target) {
    String _temp0 = intl.Intl.selectLogic(target, {
      'vegetarian': 'Vegetarian',
      'vegan': 'Vegan',
      'glutenFree': 'Gluten free',
      'keto': 'Keto',
      'lactoseFree': 'Lactose free',
      'other': 'None',
    });
    return '$_temp0';
  }

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
  String profileScreenInpLbl(String target) {
    String _temp0 = intl.Intl.selectLogic(target, {
      'age': 'Âge',
      'weight': 'Poids',
      'height': 'Grandeur',
      'bodyFat': 'Pourcentage de gras (Optionnel)',
      'activityLevel': 'Niveau d\'activité physique',
      'waterGoal': 'Objectif d\'hydration',
      'gender': 'Genre',
      'goal': 'Objectif principal',
      'weeklyPace': 'Rythme hebdomadaire',
      'dietaryPreferences': 'Préférences diététiques',
      'other': 'Autre',
    });
    return '$_temp0';
  }

  @override
  String get profileScreenSaveBtn => 'Sauvegarder le profil';

  @override
  String get profileScreenTitle => 'Profil';

  @override
  String profileScreenWaterGoalCalculationResult(String target) {
    return 'Objectif ajusté selon votre poids: $target L';
  }

  @override
  String get profileScreenWaterGoalLabel => 'Calculer (35 ml/kg)';

  @override
  String profileScreenWeelyPaceLabel(String unit) {
    return '$unit / sem';
  }

  @override
  String profileScreenWeelyPaceOption(String target) {
    String _temp0 = intl.Intl.selectLogic(target, {
      'slow': 'Lant & Durable',
      'moderate': 'Recommandé (Standard',
      'intense': 'Intense (Difficile)',
      'other': 'Autre',
    });
    return '$_temp0';
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
      'carbohydrate': 'Glucides',
      'fiber': 'Fibres',
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
  String resultScreenEstimatedWeightLbl(String weight, String unit) {
    return 'Portion estimé par l\'IA : $weight $unit';
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
      'amber': 'Ambre',
      'amethyst': 'Améthyste',
      'beryl': 'Béryl',
      'bubblegum': 'Rose bonbon',
      'crimson': 'Cramoisi',
      'emerald': 'Émeraude',
      'espresso': 'Expresso',
      'fern': 'Fougère',
      'graphite': 'Graphite',
      'honey': 'Miel',
      'orchid': 'Orchidée',
      'sapphire': 'Saphir',
      'sky': 'Céleste',
      'slate': 'Ardoise',
      'solar': 'Solaire',
      'turquoise': 'Turquoise',
      'ultramarine': 'Outremer',
      'vermilion': 'Vermillon',
      'volt': 'Volte',
      'other': 'Couleur non supportée',
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
