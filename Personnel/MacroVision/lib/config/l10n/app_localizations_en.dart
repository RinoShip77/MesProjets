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
      'legalWarning': 'Legal Warning',
      'userGuide': 'User Guide',
      'other': 'Unsupported Language',
    });
    return '$_temp0';
  }

  @override
  String get appError => 'An error occurred';

  @override
  String get appErrorDelete => 'Deletion error';

  @override
  String get appErrorForm => 'Form error. Please check your inputs';

  @override
  String get appErrorLoadingAssets => 'Error: Unable to load file';

  @override
  String get appErrorLoadingContent => 'Error loading data';

  @override
  String appErrorReadFile(String context) {
    String _temp0 = intl.Intl.selectLogic(context, {
      'legalWarning': 'Error: Unable to read legal warning',
      'userGuide': 'Error: Unable to read user guide',
      'other': 'Error: Unable to read file',
    });
    return '$_temp0';
  }

  @override
  String appLanguageName(String target) {
    String _temp0 = intl.Intl.selectLogic(target, {
      'fr': 'French',
      'en': 'English',
      'es': 'Spanish',
      'fil': 'Filipino',
      'hi': 'Hindi',
      'ja': 'Japanese',
      'sv': 'Swedish',
      'uk': 'Ukrainian',
      'zh': 'Chinese',
      'other': 'Unsupported Language',
    });
    return '$_temp0';
  }

  @override
  String get appLoadingLbl => 'Initializing...';

  @override
  String get appRefreshDataLbl => 'Refresh data';

  @override
  String get appSeeHistoryBtn => 'See history';

  @override
  String appSuccessUpdate(String context) {
    String _temp0 = intl.Intl.selectLogic(context, {
      'profile': 'Profile successfully updated',
      'history': 'History successfully updated',
      'other': 'Update successful',
    });
    return '$_temp0';
  }

  @override
  String appSummaryLbl(String duration) {
    String _temp0 = intl.Intl.selectLogic(duration, {
      'daily': 'Daily Summary',
      'weekly': 'Weekly Summary',
      'other': '',
    });
    return '$_temp0';
  }

  @override
  String get appUserNameInpLbl => 'Username';

  @override
  String get appWarningEmptyData => 'No data';

  @override
  String appWarningFormValidation(String target) {
    String _temp0 = intl.Intl.selectLogic(target, {
      'weight': 'Enter a valid weight',
      'height': 'Enter a valid height',
      'age': 'Enter a valid age',
      'comment': 'Please enter your comment',
      'other': 'Invalid input',
    });
    return '$_temp0';
  }

  @override
  String btnSaveLbl(String context) {
    return 'Save $context';
  }

  @override
  String get btnSeeHistoryLbl => 'See history';

  @override
  String get cameraScreenAnalysisInProgressLbl => 'AI Analysis in progress...';

  @override
  String cameraScreenBtn(String context) {
    String _temp0 = intl.Intl.selectLogic(context, {
      'flash': 'Toggle flash',
      'gallery': 'Select image from gallery',
      'camera': 'Take a photo',
      'other': 'Camera',
    });
    return '$_temp0';
  }

  @override
  String cameraScreenErrors(String type) {
    String _temp0 = intl.Intl.selectLogic(type, {
      'initialization': 'Camera initialization error',
      'flash': 'Error toggling flash',
      'capture': 'Capture error',
      'analysis': 'Analysis error',
      'permissions': 'Unable to access camera. Check app permissions',
      'other': 'Camera error',
    });
    return '$_temp0';
  }

  @override
  String get cameraScreenTitle => 'Food Analysis';

  @override
  String get cameraScreenVisualHintLbl =>
      'Tip: Target one food item at a time, with good lighting';

  @override
  String dashboardScreenChartTypeOption(String type) {
    String _temp0 = intl.Intl.selectLogic(type, {
      'bars': 'Bars',
      'lines': 'Lines',
      'other': 'Chart',
    });
    return '$_temp0';
  }

  @override
  String dashboardScreenDailyObjectiveLbl(String target) {
    String _temp0 = intl.Intl.selectLogic(target, {
      'calories': 'Calories',
      'protein': 'Protein',
      'totalFat': 'Fat',
      'totalCarbohydrate': 'Carbs',
      'other': 'Nutrients',
    });
    return '$_temp0';
  }

  @override
  String get dashboardScreenDailyObjectivesLbl => 'Today\'s objectives';

  @override
  String get dashboardScreenNotEnoughDataLbl =>
      'Insufficient history for the chart';

  @override
  String get dashboardScreenSelectChartTypeLbl =>
      'Show data in bar or line charts';

  @override
  String get dashboardScreenTitle => 'Dashboard';

  @override
  String get dashboardScreenWeeklySummaryLbl => 'Weekly Summary (Calories)';

  @override
  String get errorForm => 'Form error. Please check your inputs';

  @override
  String get errorGlobal => 'An error occurred';

  @override
  String get errorLoadingAssets => 'Error: Unable to load file';

  @override
  String get errorLoadingContent => 'Error loading data';

  @override
  String get errorReadUserGuide => 'Error: Unable to read user guide';

  @override
  String get errorScreenDetailsLbl => 'Details (visible in Debug mode):';

  @override
  String errorScreenGoToBtn(String target) {
    String _temp0 = intl.Intl.selectLogic(target, {
      'comment': 'Submit a comment',
      'home': 'Return to home',
      'other': '',
    });
    return '$_temp0';
  }

  @override
  String get errorScreenTitle => 'Error';

  @override
  String get feedbackScreenCommentHintLbl =>
      'Describe your experience, report a bug, or suggest an idea...';

  @override
  String get feedbackScreenCommentPaceholderLbl => 'Your message...';

  @override
  String get feedbackScreenEncouragingMessageLbl =>
      'I appreciate your feedback! Help me improve MacroVision';

  @override
  String get feedbackScreenNoEmailClientLbl => 'Unable to open email app';

  @override
  String get feedbackScreenNoRecipientEmailLbl =>
      'Feedback email address is missing';

  @override
  String get feedbackScreenOpeningEmailLbl => 'Opening email app';

  @override
  String feedbackScreenSendBtn(String state) {
    String _temp0 = intl.Intl.selectLogic(state, {
      'true': 'Sending...',
      'false': 'Send feedback',
      'other': '',
    });
    return '$_temp0';
  }

  @override
  String get feedbackScreenSendToClipboard => 'Send my message to clipboard';

  @override
  String get feedbackScreenSendTooltip => 'Send feedback';

  @override
  String feedbackScreenSendedToClipboard(String context) {
    String _temp0 = intl.Intl.selectLogic(context, {
      'comment': 'Comment sent to clipboard',
      'email': 'Email address sent to clipboard',
      'other': 'Sent to clipboard',
    });
    return '$_temp0';
  }

  @override
  String get feedbackScreenSendingError => 'Error sending feedback';

  @override
  String get feedbackScreenTitle => 'Comment';

  @override
  String historyScreenDeleteSuccessLbl(String date) {
    return 'Entry for $date was deleted from history';
  }

  @override
  String get historyScreenTitle => 'History';

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
  String homeScreenDailySummaryMacroCardLbl(String field) {
    String _temp0 = intl.Intl.selectLogic(field, {
      'carbohydrate': 'Carbs',
      'protein': 'Pro',
      'fat': 'Fat',
      'other': 'Stat',
    });
    return '$_temp0';
  }

  @override
  String homeScreenDailySummaryStatLbl(int stat) {
    return 'out of $stat g';
  }

  @override
  String get homeScreenStartAnalysisBtn => 'Analyze a meal';

  @override
  String get homeScreenTitle => 'Home';

  @override
  String get homeScreenWelcomeLbl => 'Welcome to MacroVision';

  @override
  String initializationScreenDialogDefaultLbl(String target) {
    String _temp0 = intl.Intl.selectLogic(target, {
      'legalWarning': 'Loading legal warning...',
      'userGuide': 'Loading instructions...',
      'other': 'Loading content...',
    });
    return '$_temp0';
  }

  @override
  String get profileScreenActivityLevelInpLbl => 'Physical activity level';

  @override
  String profileScreenActivityLevelOption(String target) {
    String _temp0 = intl.Intl.selectLogic(target, {
      'sedentary': 'Sedentary (little or no exercise)',
      'lightly': 'Lightly active (1-3 days/week)',
      'moderate': 'Moderately active (3-5 days/week)',
      'very': 'Very active (6-7 days/week)',
      'extra': 'Extremely active (2x/day)',
      'other': 'None',
    });
    return '$_temp0';
  }

  @override
  String get profileScreenGenderInpLbl => 'Gender';

  @override
  String profileScreenGenderOption(String target) {
    String _temp0 = intl.Intl.selectLogic(target, {
      'male': 'Male',
      'female': 'Female',
      'other': 'Other',
    });
    return '$_temp0';
  }

  @override
  String get profileScreenGoalInpLbl => 'Main goal';

  @override
  String profileScreenGoalOption(String target) {
    String _temp0 = intl.Intl.selectLogic(target, {
      'weightLoss': 'Weight loss',
      'muscleGain': 'Muscle gain',
      'maintain': 'Maintenance',
      'other': 'None',
    });
    return '$_temp0';
  }

  @override
  String profileScreenInpLbl(String target, String unit) {
    String _temp0 = intl.Intl.selectLogic(target, {
      'weight': 'Weight ($unit)',
      'height': 'Height ($unit)',
      'other': 'Age',
    });
    return '$_temp0';
  }

  @override
  String get profileScreenSaveBtn => 'Save profile';

  @override
  String get profileScreenTitle => 'Profile';

  @override
  String get profileScreenUnitSystemSwitch =>
      'Metric (kg, cm) or Imperial (lb, in)';

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
  String get profileScreenUnitSystemLbl => 'Unit system';

  @override
  String resultScreenAnalysisOutputLbl(String context) {
    String _temp0 = intl.Intl.selectLogic(context, {
      'energy': 'Energy',
      'calories': 'Calories',
      'totalFat': 'Fat',
      'saturatedFat': 'Saturated',
      'transFat': 'Trans',
      'cholesterol': 'Cholesterol',
      'sodium': 'Sodium',
      'potassium': 'Potassium',
      'carbohydrate': 'Carbohydrates',
      'fiber': 'Fiber',
      'sugar': 'Sugars',
      'protein': 'Protein',
      'other': 'Nutrients',
    });
    return '$_temp0';
  }

  @override
  String resultScreenAnalysisSummaryLbl(String weight, String unit) {
    return 'Nutritional analysis for $weight $unit';
  }

  @override
  String resultScreenEstimatedWeightLbl(String weight, String unit) {
    return 'Portion estimated by AI: $weight $unit';
  }

  @override
  String get resultScreenNewAnalysisBtn => 'Analyze a new photo';

  @override
  String resultScreenPortionLbl(String unit) {
    return 'Real weight ($unit)';
  }

  @override
  String get resultScreenRefineAnalysisBtn => 'Adjust analysis';

  @override
  String resultScreenRefineAnalysisLbl(String weight, String unit) {
    return 'Adjusted analysis for $weight ($unit)';
  }

  @override
  String resultScreenSwitchLbl(String unit) {
    String _temp0 = intl.Intl.selectLogic(unit, {
      'kJ': 'Show in kcal/cal',
      'cal': 'Show in kJ',
      'other': 'change unit',
    });
    return '$_temp0';
  }

  @override
  String get resultScreenTitle => 'Result';

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
      'default': 'System default',
      'light': 'Light mode',
      'dark': 'Dark mode',
      'other': 'None',
    });
    return '$_temp0';
  }

  @override
  String settingsScreenSectionLbl(String target) {
    String _temp0 = intl.Intl.selectLogic(target, {
      'language': 'App language',
      'luminosity': 'App brightness',
      'color': 'Custom colors',
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
