// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get nameLanguage => 'English';

  @override
  String get titleLanguageSelect => 'Language';

  @override
  String get titleUserGuide => 'User Guide';

  @override
  String successUpdate(String context) {
    return '$context has been successfully updated';
  }

  @override
  String get warningEmptyData => 'No data available';

  @override
  String get errorGlobal => 'An error occurred';

  @override
  String get errorReadUserGuide => 'Error: Unable to read user guide';

  @override
  String get errorLoadingAssets => 'Error: Unable to load file';

  @override
  String get errorForm => 'Form error. Please check your entries';

  @override
  String get errorLoadingContent => 'Error loading data';

  @override
  String titleSettingsSections(String target) {
    String _temp0 = intl.Intl.selectLogic(target, {
      'language': 'App Language',
      'luminosity': 'App Brightness',
      'color': 'Custom Colors',
      'other': 'Settings',
    });
    return '$_temp0';
  }

  @override
  String titleDailyAnalisis(int count) {
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
  String get titleSettings => 'Settings';

  @override
  String get titleHistory => 'History';

  @override
  String get titleDashboard => 'Dashboard';

  @override
  String get titleHome => 'Home';

  @override
  String get titleCamera => 'Camera';

  @override
  String get titleFeedback => 'Feedback';

  @override
  String get titleDailySummary => 'Daily Summary';

  @override
  String get titleBtnSeeHistory => 'View History';

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
  String get titleProfile => 'Profile';

  @override
  String get titleProfileUnitSystem => 'Unit System';

  @override
  String tooltipSwitch(String option1, String option2) {
    return '$option1 or $option2';
  }

  @override
  String titleBtnSave(String context) {
    return 'Save $context';
  }

  @override
  String titleSettingsLuminosity(String target) {
    String _temp0 = intl.Intl.selectLogic(target, {
      'default': 'System Default',
      'light': 'Light Mode',
      'dark': 'Dark Mode',
      'other': 'None',
    });
    return '$_temp0';
  }

  @override
  String get titleProfileName => 'Name';

  @override
  String titleProfileGoal(String target) {
    String _temp0 = intl.Intl.selectLogic(target, {
      'weightLoss': 'Weight Loss',
      'muscleGain': 'Muscle Gain',
      'maintain': 'Maintenance',
      'other': 'None',
    });
    return '$_temp0';
  }
}
