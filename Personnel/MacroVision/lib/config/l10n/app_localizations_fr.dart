// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for French (`fr`).
class AppLocalizationsFr extends AppLocalizations {
  AppLocalizationsFr([String locale = 'fr']) : super(locale);

  @override
  String get nameLanguage => 'Français';

  @override
  String get titleLanguageSelect => 'Langue';

  @override
  String get titleUserGuide => 'Guide d\'utilisation';

  @override
  String successUpdate(String context) {
    return 'Le $context a été mis à jour avec succès';
  }

  @override
  String get warningEmptyData => 'Aucune données';

  @override
  String get errorGlobal => 'Une erreur s\'est produite';

  @override
  String get errorReadUserGuide =>
      'Erreur: Impossible de lire le guide utilisateur';

  @override
  String get errorLoadingAssets => 'Erreur: Impossible de charger le fichier';

  @override
  String get errorForm =>
      'Erreur dans le formulaire. Veuillez vérifier vos entrées';

  @override
  String get errorLoadingContent => 'Erreur de chargement des données';

  @override
  String titleSettingsSections(String target) {
    String _temp0 = intl.Intl.selectLogic(target, {
      'language': 'Langue de l\'application',
      'luminosity': 'Luminosité de l\'application',
      'color': 'Couleurs personnalisées',
      'other': 'Paramètres',
    });
    return '$_temp0';
  }

  @override
  String titleDailyAnalisis(int count) {
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
  String get titleSettings => 'Paramètres';

  @override
  String get titleHistory => 'Historique';

  @override
  String get titleDashboard => 'Tableau de bord';

  @override
  String get titleHome => 'Accueil';

  @override
  String get titleCamera => 'Caméra';

  @override
  String get titleFeedback => 'Commentaire';

  @override
  String get titleDailySummary => 'Résumé quotidien';

  @override
  String get titleBtnSeeHistory => 'Voir l\'historique';

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
  String get titleProfile => 'Profil';

  @override
  String get titleProfileUnitSystem => 'Système d\'unité';

  @override
  String tooltipSwitch(String option1, String option2) {
    return '$option1 ou $option2';
  }

  @override
  String titleBtnSave(String context) {
    return 'Sauvegarder $context';
  }

  @override
  String titleSettingsLuminosity(String target) {
    String _temp0 = intl.Intl.selectLogic(target, {
      'default': 'Défaut du système',
      'light': 'Mode clair',
      'dark': 'Mode sombre',
      'other': 'Aucun',
    });
    return '$_temp0';
  }

  @override
  String get titleProfileName => 'Nom';

  @override
  String titleProfileGoal(String target) {
    String _temp0 = intl.Intl.selectLogic(target, {
      'weightLoss': 'Perte de poids',
      'muscleGain': 'Gain musculaire',
      'maintain': 'Maintien',
      'other': 'Maintien',
    });
    return '$_temp0';
  }
}
