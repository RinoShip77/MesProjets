// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Filipino Pilipino (`fil`).
class AppLocalizationsFil extends AppLocalizations {
  AppLocalizationsFil([String locale = 'fil']) : super(locale);

  @override
  String appDialogTitle(String target) {
    String _temp0 = intl.Intl.selectLogic(target, {
      'legalWarning': 'Babala sa batas',
      'userGuide': 'Gabay ng Gumagamit',
      'other': 'Hindi suportadong wika',
    });
    return '$_temp0';
  }

  @override
  String get appError => 'May naganap na error';

  @override
  String get appErrorDelete => 'Error sa pagtanggal';

  @override
  String get appErrorForm => 'Error sa form. Pakisuri ang iyong mga input';

  @override
  String get appErrorLoadingAssets => 'Error: Hindi ma-load ang file';

  @override
  String get appErrorLoadingContent => 'Error sa pag-load ng data';

  @override
  String appErrorReadFile(String context) {
    String _temp0 = intl.Intl.selectLogic(context, {
      'legalWarning': 'Error: Hindi mabasa ang babala sa batas',
      'userGuide': 'Error: Hindi mabasa ang gabay ng gumagamit',
      'other': 'Error: Hindi mabasa ang file',
    });
    return '$_temp0';
  }

  @override
  String appLanguageName(String target) {
    String _temp0 = intl.Intl.selectLogic(target, {
      'fr': 'Pranses',
      'en': 'Ingles',
      'es': 'Spanish',
      'fil': 'Filipino',
      'hi': 'Hindi',
      'ja': 'Japanese',
      'sv': 'Swedish',
      'uk': 'Ukrainian',
      'zh': 'Chinese',
      'sw': 'Swahili',
      'other': 'Hindi suportadong wika',
    });
    return '$_temp0';
  }

  @override
  String get appLoadingLbl => 'Ina-initialize...';

  @override
  String get appRefreshDataLbl => 'I-refresh ang data';

  @override
  String get appSeeHistoryBtn => 'Tingnan ang kasaysayan';

  @override
  String appSuccessUpdate(String context) {
    String _temp0 = intl.Intl.selectLogic(context, {
      'profile': 'Matagumpay na na-update ang profile',
      'history': 'Matagumpay na na-update ang kasaysayan',
      'other': 'Matagumpay ang pag-update',
    });
    return '$_temp0';
  }

  @override
  String appSummaryLbl(String duration) {
    String _temp0 = intl.Intl.selectLogic(duration, {
      'daily': 'Araw-araw na Buod',
      'weekly': 'Lingguhang Buod',
      'other': '',
    });
    return '$_temp0';
  }

  @override
  String get appUserNameInpLbl => 'Pangalan ng gumagamit';

  @override
  String get appWarningEmptyData => 'Walang data';

  @override
  String appWarningFormValidation(String target) {
    String _temp0 = intl.Intl.selectLogic(target, {
      'weight': 'Maglagay ng wastong timbang',
      'height': 'Maglagay ng wastong taas',
      'age': 'Maglagay ng wastong edad',
      'comment': 'Mangyaring ilagay ang iyong komento',
      'other': 'Hindi wastong input',
    });
    return '$_temp0';
  }

  @override
  String btnSaveLbl(String context) {
    return 'I-save ang $context';
  }

  @override
  String get btnSeeHistoryLbl => 'Tingnan ang kasaysayan';

  @override
  String get cameraScreenAnalysisInProgressLbl =>
      'Kasalukuyang sinusuri ng IA...';

  @override
  String cameraScreenBtn(String context) {
    String _temp0 = intl.Intl.selectLogic(context, {
      'flash': 'I-toggle ang flash',
      'gallery': 'Pumili ng imahe mula sa gallery',
      'camera': 'Kumuha ng larawan',
      'other': 'Camera',
    });
    return '$_temp0';
  }

  @override
  String get cameraScreenConfirmFactsLbl => 'Confirmer les valeurs';

  @override
  String cameraScreenErrors(String type) {
    String _temp0 = intl.Intl.selectLogic(type, {
      'initialization': 'Error sa pag-initialize ng camera',
      'flash': 'Error habang tina-toggle ang flash',
      'capture': 'Error sa pagkuha',
      'analysis': 'Error sa pagsusuri',
      'permissions':
          'Hindi ma-access ang camera. Suriin ang mga pahintulot ng application',
      'other': 'Error sa camera',
    });
    return '$_temp0';
  }

  @override
  String get cameraScreenTitle => 'Pagsusuri ng pagkain';

  @override
  String get cameraScreenVisualHintLbl =>
      'Tip: Mag-target ng isang pagkain sa bawat pagkakataon, na may magandang liwanag';

  @override
  String dashboardScreenChartTypeOption(String type) {
    String _temp0 = intl.Intl.selectLogic(type, {
      'bars': 'Mga Bar',
      'lines': 'Mga Linya',
      'other': 'Graph',
    });
    return '$_temp0';
  }

  @override
  String dashboardScreenDailyObjectiveLbl(String target) {
    String _temp0 = intl.Intl.selectLogic(target, {
      'calories': 'Calories',
      'protein': 'Protina',
      'totalFat': 'Taba',
      'totalCarbohydrate': 'Carbohydrates',
      'other': 'Nutrisyon',
    });
    return '$_temp0';
  }

  @override
  String get dashboardScreenDailyObjectivesLbl =>
      'Mga layunin para sa araw na ito';

  @override
  String get dashboardScreenNotEnoughDataLbl =>
      'Hindi sapat na kasaysayan para sa graph';

  @override
  String get dashboardScreenSelectChartTypeLbl =>
      'Ipakita ang data sa bar chart o line chart';

  @override
  String get dashboardScreenTitle => 'Dashboard';

  @override
  String get dashboardScreenWeeklySummaryLbl => 'Lingguhang buod (Calories)';

  @override
  String get errorForm => 'Error sa form. Pakisuri ang iyong mga input';

  @override
  String get errorGlobal => 'May naganap na error';

  @override
  String get errorLoadingAssets => 'Error: Hindi ma-load ang file';

  @override
  String get errorLoadingContent => 'Error sa pag-load ng data';

  @override
  String get errorReadUserGuide => 'Error: Hindi mabasa ang gabay ng gumagamit';

  @override
  String get errorScreenDetailsLbl => 'Mga detalye (nakikita sa Debug mode):';

  @override
  String errorScreenGoToBtn(String target) {
    String _temp0 = intl.Intl.selectLogic(target, {
      'comment': 'Magsumite ng komento',
      'home': 'Bumalik sa home',
      'other': '',
    });
    return '$_temp0';
  }

  @override
  String get errorScreenTitle => 'Error';

  @override
  String get feedbackScreenCommentHintLbl =>
      'Ilarawan ang iyong karanasan, mag-ulat ng bug o magmungkahi ng ideya...';

  @override
  String get feedbackScreenCommentPaceholderLbl => 'Ang iyong mensahe...';

  @override
  String get feedbackScreenEncouragingMessageLbl =>
      'Pinahahalagahan ko ang iyong feedback! Tulungan akong mapabuti ang MacroVision';

  @override
  String get feedbackScreenNoEmailClientLbl =>
      'Hindi mabuksan ang email application';

  @override
  String get feedbackScreenNoRecipientEmailLbl =>
      'Nawawala ang feedback email address';

  @override
  String get feedbackScreenOpeningEmailLbl =>
      'Binubuksan ang messaging application';

  @override
  String feedbackScreenSendBtn(String state) {
    String _temp0 = intl.Intl.selectLogic(state, {
      'true': 'Ipinapadala...',
      'false': 'Ipadala ang feedback',
      'other': '',
    });
    return '$_temp0';
  }

  @override
  String get feedbackScreenSendToClipboard =>
      'Ipadala ang aking mensahe sa clipboard';

  @override
  String get feedbackScreenSendTooltip => 'Ipadala ang feedback';

  @override
  String feedbackScreenSendedToClipboard(String context) {
    String _temp0 = intl.Intl.selectLogic(context, {
      'comment': 'Komento naipadala sa clipboard',
      'email': 'Email address naipadala sa clipboard',
      'other': 'Naipadala sa clipboard',
    });
    return '$_temp0';
  }

  @override
  String get feedbackScreenSendingError =>
      'Error habang ipinapadala ang feedback';

  @override
  String get feedbackScreenTitle => 'Komento';

  @override
  String historyScreenDeleteSuccessLbl(String date) {
    return 'Ang entry para sa $date ay tinanggal mula sa kasaysayan';
  }

  @override
  String get historyScreenTitle => 'Kasaysayan';

  @override
  String homeScreenDailyAnalisisLbl(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Mga Pagsusuri ($count)',
      one: 'Pagsusuri (1)',
      zero: 'Walang pagsusuri',
    );
    return '$_temp0';
  }

  @override
  String homeScreenDailySummaryMacroCardLbl(String field) {
    String _temp0 = intl.Intl.selectLogic(field, {
      'carbohydrate': 'Karbohidrat',
      'protein': 'Protina',
      'fat': 'Taba',
      'other': 'Pagkaing nakapagpalusog',
    });
    return '$_temp0';
  }

  @override
  String homeScreenDailySummaryStatLbl(int stat) {
    return 'mula sa $stat g';
  }

  @override
  String get homeScreenStartAnalysisBtn => 'Suriin ang isang pagkain';

  @override
  String get homeScreenTitle => 'Home';

  @override
  String get homeScreenWelcomeLbl => 'Maligayang pagdating sa MacroVision';

  @override
  String initializationScreenDialogDefaultLbl(String target) {
    String _temp0 = intl.Intl.selectLogic(target, {
      'legalWarning': 'Naglo-load ng babala sa batas...',
      'userGuide': 'Naglo-load ng mga tagubilin...',
      'other': 'Naglo-load ng nilalaman...',
    });
    return '$_temp0';
  }

  @override
  String get profileScreenActivityLevelInpLbl =>
      'Antas ng pisikal na aktibidad';

  @override
  String profileScreenActivityLevelOption(String target) {
    String _temp0 = intl.Intl.selectLogic(target, {
      'sedentary': 'Sedentary (kaunti o walang ehersisyo)',
      'lightly': 'Bahagyang aktibo (1-3 araw/linggo)',
      'moderate': 'Katamtamang aktibo (3-5 araw/linggo)',
      'very': 'Sadyang aktibo (6-7 araw/linggo)',
      'extra': 'Lubos na aktibo (2 beses/araw)',
      'other': 'Wala',
    });
    return '$_temp0';
  }

  @override
  String get profileScreenGenderInpLbl => 'Kasarian';

  @override
  String profileScreenGenderOption(String target) {
    String _temp0 = intl.Intl.selectLogic(target, {
      'male': 'Lalaki',
      'female': 'Babae',
      'other': 'Iba pa',
    });
    return '$_temp0';
  }

  @override
  String get profileScreenGoalInpLbl => 'Pangunahing layunin';

  @override
  String profileScreenGoalOption(String target) {
    String _temp0 = intl.Intl.selectLogic(target, {
      'weightLoss': 'Pagbabawas ng timbang',
      'muscleGain': 'Pagpapalaki ng kalamnan',
      'maintain': 'Pagpapanatili',
      'other': 'Wala',
    });
    return '$_temp0';
  }

  @override
  String profileScreenInpLbl(String target, String unit) {
    String _temp0 = intl.Intl.selectLogic(target, {
      'weight': 'Timbang ($unit)',
      'height': 'Taas ($unit)',
      'other': 'Edad',
    });
    return '$_temp0';
  }

  @override
  String get profileScreenSaveBtn => 'I-save ang profile';

  @override
  String get profileScreenTitle => 'Profile';

  @override
  String get profileScreenUnitSystemSwitch =>
      'Metric (kg, cm) o Imperial (lb, in)';

  @override
  String profileScreenUnitOption(String unit) {
    String _temp0 = intl.Intl.selectLogic(unit, {
      'metric': 'Metric',
      'imperial': 'Imperial',
      'other': 'Wala',
    });
    return '$_temp0';
  }

  @override
  String get profileScreenUnitSystemLbl => 'Sistema ng yunit';

  @override
  String resultScreenAnalysisOutputLbl(String context) {
    String _temp0 = intl.Intl.selectLogic(context, {
      'energy': 'Enerhiya',
      'calories': 'Calories',
      'totalFat': 'Taba',
      'saturatedFat': 'Saturated',
      'transFat': 'Trans',
      'cholesterol': 'Cholesterol',
      'sodium': 'Sodium',
      'potassium': 'Potassium',
      'carbohydrate': 'Carbohydrates',
      'fiber': 'Fiber',
      'sugar': 'Asukal',
      'protein': 'Protina',
      'other': 'Nutrisyon',
    });
    return '$_temp0';
  }

  @override
  String resultScreenAnalysisSummaryLbl(String weight, String unit) {
    return 'Nutrisyonal na pagsusuri para sa $weight $unit';
  }

  @override
  String resultScreenEstimatedWeightLbl(String weight, String unit) {
    return 'Bahaging tinantya ng IA: $weight $unit';
  }

  @override
  String get resultScreenNewAnalysisBtn => 'Suriin ang bagong larawan';

  @override
  String resultScreenPortionLbl(String unit) {
    return 'Tunay na timbang ($unit)';
  }

  @override
  String get resultScreenRefineAnalysisBtn => 'I-adjust ang pagsusuri';

  @override
  String resultScreenRefineAnalysisLbl(String weight, String unit) {
    return 'In-adjust na pagsusuri para sa $weight ($unit)';
  }

  @override
  String resultScreenSwitchLbl(String unit) {
    String _temp0 = intl.Intl.selectLogic(unit, {
      'kJ': 'Ipakita sa kcal/cal',
      'cal': 'Ipakita sa kJ',
      'other': 'palitan ang yunit',
    });
    return '$_temp0';
  }

  @override
  String get resultScreenTitle => 'Resulta';

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
      'other': 'Kulay',
    });
    return '$_temp0';
  }

  @override
  String get settingsScreenLanguageSelectLbl => 'Wika';

  @override
  String settingsScreenLuminosityOption(String target) {
    String _temp0 = intl.Intl.selectLogic(target, {
      'default': 'Default ng system',
      'light': 'Light mode',
      'dark': 'Dark mode',
      'other': 'Wala',
    });
    return '$_temp0';
  }

  @override
  String settingsScreenSectionLbl(String target) {
    String _temp0 = intl.Intl.selectLogic(target, {
      'language': 'Wika ng application',
      'luminosity': 'Liwanag ng application',
      'color': 'Pasadyang mga kulay',
      'other': 'Mga Setting',
    });
    return '$_temp0';
  }

  @override
  String get settingsScreenTitle => 'Mga Setting';

  @override
  String statsCalorie(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Mga Calorie: $count',
      one: 'Calorie: 1',
      zero: 'Calorie: 0',
    );
    return '$_temp0';
  }

  @override
  String get warningEmptyData => 'Walang data';

  @override
  String warningFormValidation(String target) {
    String _temp0 = intl.Intl.selectLogic(target, {
      'weight': 'Maglagay ng wastong timbang',
      'height': 'Maglagay ng wastong taas',
      'age': 'Maglagay ng wastong edad',
      'other': 'Hindi wastong input',
    });
    return '$_temp0';
  }
}
