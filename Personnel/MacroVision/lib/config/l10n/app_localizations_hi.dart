// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Hindi (`hi`).
class AppLocalizationsHi extends AppLocalizations {
  AppLocalizationsHi([String locale = 'hi']) : super(locale);

  @override
  String appDialogTitle(String target) {
    String _temp0 = intl.Intl.selectLogic(target, {
      'legalWarning': 'कानूनी चेतावनी',
      'userGuide': 'उपयोगकर्ता मार्गदर्शिका',
      'other': 'असमर्थित भाषा',
    });
    return '$_temp0';
  }

  @override
  String get appError => 'एक त्रुटि हुई';

  @override
  String get appErrorDelete => 'हटाने में त्रुटि';

  @override
  String get appErrorForm =>
      'फ़ॉर्म में त्रुटि। कृपया अपनी प्रविष्टियों की जाँच करें';

  @override
  String get appErrorLoadingAssets => 'त्रुटि: फ़ाइल लोड करने में असमर्थ';

  @override
  String get appErrorLoadingContent => 'डेटा लोड करने में त्रुटि';

  @override
  String appErrorReadFile(String context) {
    String _temp0 = intl.Intl.selectLogic(context, {
      'legalWarning': 'त्रुटि: कानूनी चेतावनी पढ़ने में असमर्थ',
      'userGuide': 'त्रुटि: उपयोगकर्ता मार्गदर्शिका पढ़ने में असमर्थ',
      'other': 'त्रुटि: फ़ाइल पढ़ने में असमर्थ',
    });
    return '$_temp0';
  }

  @override
  String appLanguageName(String target) {
    String _temp0 = intl.Intl.selectLogic(target, {
      'fr': 'फ्रेंच',
      'en': 'अंग्रेजी',
      'es': 'स्पेनिश',
      'fil': 'फिलिपिनो',
      'hi': 'हिंदी',
      'ja': 'जापानी',
      'sv': 'स्वीडिश',
      'uk': 'यूक्रेनी',
      'zh': 'चीनी',
      'other': 'असमर्थित भाषा',
    });
    return '$_temp0';
  }

  @override
  String get appLoadingLbl => 'प्रारंभ हो रहा है...';

  @override
  String get appRefreshDataLbl => 'डेटा रिफ्रेश करें';

  @override
  String get appSeeHistoryBtn => 'इतिहास देखें';

  @override
  String appSuccessUpdate(String context) {
    String _temp0 = intl.Intl.selectLogic(context, {
      'profile': 'प्रोफ़ाइल सफलतापूर्वक अपडेट की गई',
      'history': 'इतिहास सफलतापूर्वक अपडेट किया गया',
      'other': 'अपडेट सफल',
    });
    return '$_temp0';
  }

  @override
  String appSummaryLbl(String duration) {
    String _temp0 = intl.Intl.selectLogic(duration, {
      'daily': 'दैनिक सारांश',
      'weekly': 'साप्ताहिक सारांश',
      'other': '',
    });
    return '$_temp0';
  }

  @override
  String get appUserNameInpLbl => 'उपयोगकर्ता नाम';

  @override
  String get appWarningEmptyData => 'कोई डेटा नहीं';

  @override
  String appWarningFormValidation(String target) {
    String _temp0 = intl.Intl.selectLogic(target, {
      'weight': 'एक मान्य वजन दर्ज करें',
      'height': 'एक मान्य ऊंचाई दर्ज करें',
      'age': 'एक मान्य आयु दर्ज करें',
      'comment': 'कृपया अपनी टिप्पणी दर्ज करें',
      'other': 'अमान्य प्रविष्टि',
    });
    return '$_temp0';
  }

  @override
  String btnSaveLbl(String context) {
    return '$context सहेजें';
  }

  @override
  String get btnSeeHistoryLbl => 'इतिहास देखें';

  @override
  String get cameraScreenAnalysisInProgressLbl =>
      'AI द्वारा विश्लेषण जारी है...';

  @override
  String cameraScreenBtn(String context) {
    String _temp0 = intl.Intl.selectLogic(context, {
      'flash': 'फ्लैश टॉगल करें',
      'gallery': 'गैलरी से छवि चुनें',
      'camera': 'फोटो लें',
      'other': 'कैमरा',
    });
    return '$_temp0';
  }

  @override
  String cameraScreenErrors(String type) {
    String _temp0 = intl.Intl.selectLogic(type, {
      'initialization': 'कैमरा प्रारंभ त्रुटि',
      'flash': 'फ्लैश टॉगल करते समय त्रुटि',
      'capture': 'कैप्चर त्रुटि',
      'analysis': 'विश्लेषण त्रुटि',
      'permissions': 'कैमरा एक्सेस करने में असमर्थ। अनुमति की जाँच करें',
      'other': 'कैमरा त्रुटि',
    });
    return '$_temp0';
  }

  @override
  String get cameraScreenTitle => 'खाद्य विश्लेषण';

  @override
  String get cameraScreenVisualHintLbl =>
      'सुझाव: अच्छी रोशनी में एक बार में एक खाद्य पदार्थ को लक्षित करें';

  @override
  String dashboardScreenChartTypeOption(String type) {
    String _temp0 = intl.Intl.selectLogic(type, {
      'bars': 'बार',
      'lines': 'लाइन',
      'other': 'ग्राफ',
    });
    return '$_temp0';
  }

  @override
  String dashboardScreenDailyObjectiveLbl(String target) {
    String _temp0 = intl.Intl.selectLogic(target, {
      'calories': 'कैलोरी',
      'protein': 'प्रोटीन',
      'totalFat': 'वसा',
      'totalCarbohydrate': 'कार्ब्स',
      'other': 'पोषक तत्व',
    });
    return '$_temp0';
  }

  @override
  String get dashboardScreenDailyObjectivesLbl => 'आज के लक्ष्य';

  @override
  String get dashboardScreenNotEnoughDataLbl => 'चार्ट के लिए अपर्याप्त इतिहास';

  @override
  String get dashboardScreenSelectChartTypeLbl =>
      'डेटा को बार या लाइन चार्ट में दिखाएं';

  @override
  String get dashboardScreenTitle => 'डैशबोर्ड';

  @override
  String get dashboardScreenWeeklySummaryLbl => 'साप्ताहिक सारांश (कैलोरी)';

  @override
  String get errorForm =>
      'फ़ॉर्म में त्रुटि। कृपया अपनी प्रविष्टियों की जाँच करें';

  @override
  String get errorGlobal => 'एक त्रुटि हुई';

  @override
  String get errorLoadingAssets => 'त्रुटि: फ़ाइल लोड करने में असमर्थ';

  @override
  String get errorLoadingContent => 'डेटा लोड करने में त्रुटि';

  @override
  String get errorReadUserGuide =>
      'त्रुटि: उपयोगकर्ता मार्गदर्शिका पढ़ने में असमर्थ';

  @override
  String get errorScreenDetailsLbl => 'विवरण (डीबग मोड में दृश्यमान):';

  @override
  String errorScreenGoToBtn(String target) {
    String _temp0 = intl.Intl.selectLogic(target, {
      'comment': 'टिप्पणी भेजें',
      'home': 'होम पर वापस जाएं',
      'other': '',
    });
    return '$_temp0';
  }

  @override
  String get errorScreenTitle => 'त्रुटि';

  @override
  String get feedbackScreenCommentHintLbl =>
      'अपने अनुभव का वर्णन करें, बग की रिपोर्ट करें या विचार सुझाएं...';

  @override
  String get feedbackScreenCommentPaceholderLbl => 'आपका संदेश...';

  @override
  String get feedbackScreenEncouragingMessageLbl =>
      'मैं आपकी प्रतिक्रिया की सराहना करता हूँ! मैक्रोविज़न को बेहतर बनाने में मेरी मदद करें';

  @override
  String get feedbackScreenNoEmailClientLbl =>
      'ईमेल एप्लिकेशन खोलने में असमर्थ';

  @override
  String get feedbackScreenNoRecipientEmailLbl =>
      'प्रतिक्रिया ईमेल पता गायब है';

  @override
  String get feedbackScreenOpeningEmailLbl => 'ईमेल एप्लिकेशन खोल रहा है';

  @override
  String feedbackScreenSendBtn(String state) {
    String _temp0 = intl.Intl.selectLogic(state, {
      'true': 'भेजा जा रहा है...',
      'false': 'प्रतिक्रिया भेजें',
      'other': '',
    });
    return '$_temp0';
  }

  @override
  String get feedbackScreenSendToClipboard => 'मेरा संदेश क्लिपबोर्ड पर भेजें';

  @override
  String get feedbackScreenSendTooltip => 'प्रतिक्रिया भेजें';

  @override
  String feedbackScreenSendedToClipboard(String context) {
    String _temp0 = intl.Intl.selectLogic(context, {
      'comment': 'टिप्पणी क्लिपबोर्ड पर भेजी गई',
      'email': 'ईमेल पता क्लिपबोर्ड पर भेजा गया',
      'other': 'क्लिपबोर्ड पर भेजा गया',
    });
    return '$_temp0';
  }

  @override
  String get feedbackScreenSendingError => 'प्रतिक्रिया भेजते समय त्रुटि';

  @override
  String get feedbackScreenTitle => 'टिप्पणी';

  @override
  String historyScreenDeleteSuccessLbl(String date) {
    return '$date की प्रविष्टि इतिहास से हटा दी गई';
  }

  @override
  String get historyScreenTitle => 'इतिहास';

  @override
  String homeScreenDailyAnalisisLbl(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'विश्लेषण ($count)',
      one: 'विश्लेषण (1)',
      zero: 'कोई विश्लेषण नहीं',
    );
    return '$_temp0';
  }

  @override
  String homeScreenDailySummaryMacroCardLbl(String field) {
    String _temp0 = intl.Intl.selectLogic(field, {
      'carbohydrate': 'कार्ब्स',
      'protein': 'प्रोटीन',
      'fat': 'वसा',
      'other': 'आंकड़े',
    });
    return '$_temp0';
  }

  @override
  String homeScreenDailySummaryStatLbl(int stat) {
    return '$stat ग्राम में से';
  }

  @override
  String get homeScreenStartAnalysisBtn => 'भोजन का विश्लेषण करें';

  @override
  String get homeScreenTitle => 'होम';

  @override
  String get homeScreenWelcomeLbl => 'मैक्रोविज़न में आपका स्वागत है';

  @override
  String initializationScreenDialogDefaultLbl(String target) {
    String _temp0 = intl.Intl.selectLogic(target, {
      'legalWarning': 'कानूनी चेतावनी लोड हो रही है...',
      'userGuide': 'निर्देश लोड हो रहे हैं...',
      'other': 'सामग्री लोड हो रही है...',
    });
    return '$_temp0';
  }

  @override
  String get profileScreenActivityLevelInpLbl => 'शारीरिक गतिविधि स्तर';

  @override
  String profileScreenActivityLevelOption(String target) {
    String _temp0 = intl.Intl.selectLogic(target, {
      'sedentary': 'गतिहीन (कम या कोई व्यायाम नहीं)',
      'lightly': 'थोड़ा सक्रिय (सप्ताह में 1-3 दिन)',
      'moderate': 'मध्यम सक्रिय (सप्ताह में 3-5 दिन)',
      'very': 'बहुत सक्रिय (सप्ताह में 6-7 दिन)',
      'extra': 'अत्यधिक सक्रिय (दिन में 2 बार)',
      'other': 'कोई नहीं',
    });
    return '$_temp0';
  }

  @override
  String get profileScreenGenderInpLbl => 'लिंग';

  @override
  String profileScreenGenderOption(String target) {
    String _temp0 = intl.Intl.selectLogic(target, {
      'male': 'पुरुष',
      'female': 'महिला',
      'other': 'अन्य',
    });
    return '$_temp0';
  }

  @override
  String get profileScreenGoalInpLbl => 'मुख्य लक्ष्य';

  @override
  String profileScreenGoalOption(String target) {
    String _temp0 = intl.Intl.selectLogic(target, {
      'weightLoss': 'वजन घटाना',
      'muscleGain': 'मांसपेशियों का लाभ',
      'maintain': 'रखरखाव',
      'other': 'कोई नहीं',
    });
    return '$_temp0';
  }

  @override
  String profileScreenInpLbl(String target, String unit) {
    String _temp0 = intl.Intl.selectLogic(target, {
      'weight': 'वजन ($unit)',
      'height': 'ऊंचाई ($unit)',
      'other': 'आयु',
    });
    return '$_temp0';
  }

  @override
  String get profileScreenSaveBtn => 'प्रोफ़ाइल सहेजें';

  @override
  String get profileScreenTitle => 'प्रोफ़ाइल';

  @override
  String get profileScreenUnitSystemSwitch =>
      'मीट्रिक (kg, cm) या इंपीरियल (lb, in)';

  @override
  String profileScreenUnitOption(String unit) {
    String _temp0 = intl.Intl.selectLogic(unit, {
      'metric': 'मीट्रिक',
      'imperial': 'इंपीरियल',
      'other': 'कोई नहीं',
    });
    return '$_temp0';
  }

  @override
  String get profileScreenUnitSystemLbl => 'इकाई प्रणाली';

  @override
  String resultScreenAnalysisOutputLbl(String context) {
    String _temp0 = intl.Intl.selectLogic(context, {
      'energy': 'ऊर्जा',
      'calories': 'कैलोरी',
      'totalFat': 'वसा',
      'saturatedFat': 'संतृप्त',
      'transFat': 'ट्रांस',
      'cholesterol': 'कोलेस्ट्रॉल',
      'sodium': 'सोडियम',
      'potassium': 'पोटेशियम',
      'carbohydrate': 'कार्बोहाइड्रेट',
      'fiber': 'फाइबर',
      'sugar': 'चीनी',
      'protein': 'प्रोटीन',
      'other': 'पोषक तत्व',
    });
    return '$_temp0';
  }

  @override
  String resultScreenAnalysisSummaryLbl(String weight, String unit) {
    return '$weight $unit के लिए पोषण संबंधी विश्लेषण';
  }

  @override
  String resultScreenEstimatedWeightLbl(String weight, String unit) {
    return 'AI द्वारा अनुमानित हिस्सा: $weight $unit';
  }

  @override
  String get resultScreenNewAnalysisBtn => 'एक नई फोटो का विश्लेषण करें';

  @override
  String resultScreenPortionLbl(String unit) {
    return 'वास्तविक वजन ($unit)';
  }

  @override
  String get resultScreenRefineAnalysisBtn => 'विश्लेषण समायोजित करें';

  @override
  String resultScreenRefineAnalysisLbl(String weight, String unit) {
    return '$weight ($unit) के लिए समायोजित विश्लेषण';
  }

  @override
  String resultScreenSwitchLbl(String unit) {
    String _temp0 = intl.Intl.selectLogic(unit, {
      'kJ': 'kcal/cal में दिखाएं',
      'cal': 'kJ में दिखाएं',
      'other': 'इकाई बदलें',
    });
    return '$_temp0';
  }

  @override
  String get resultScreenTitle => 'परिणाम';

  @override
  String settingsScreenCustomThemeOption(String color) {
    String _temp0 = intl.Intl.selectLogic(color, {
      'mint': 'पुदीना',
      'ocean': 'महासागर',
      'passion': 'जुनून',
      'neon': 'नियॉन',
      'platinum': 'प्लैटिनम',
      'merlot': 'मर्लोट',
      'lemon': 'नींबू',
      'lime': 'लाइम',
      'peacock': 'मयूर',
      'azure': 'आसमानी',
      'candy': 'कैंडी',
      'pumpkin': 'कद्दू',
      'lapis': 'लापिस',
      'scarlet': 'सिंदूरी',
      'other': 'रंग',
    });
    return '$_temp0';
  }

  @override
  String get settingsScreenLanguageSelectLbl => 'भाषा';

  @override
  String settingsScreenLuminosityOption(String target) {
    String _temp0 = intl.Intl.selectLogic(target, {
      'default': 'सिस्टम डिफ़ॉल्ट',
      'light': 'लाइट मोड',
      'dark': 'डार्क मोड',
      'other': 'कोई नहीं',
    });
    return '$_temp0';
  }

  @override
  String settingsScreenSectionLbl(String target) {
    String _temp0 = intl.Intl.selectLogic(target, {
      'language': 'एप्लिकेशन भाषा',
      'luminosity': 'एप्लिकेशन चमक',
      'color': 'कस्टम रंग',
      'other': 'सेटिंग्स',
    });
    return '$_temp0';
  }

  @override
  String get settingsScreenTitle => 'सेटिंग्स';

  @override
  String statsCalorie(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'कैलोरी: $count',
      one: 'कैलोरी: 1',
      zero: 'कैलोरी: 0',
    );
    return '$_temp0';
  }

  @override
  String get warningEmptyData => 'कोई डेटा नहीं';

  @override
  String warningFormValidation(String target) {
    String _temp0 = intl.Intl.selectLogic(target, {
      'weight': 'एक मान्य वजन दर्ज करें',
      'height': 'एक मान्य ऊंचाई दर्ज करें',
      'age': 'एक मान्य आयु दर्ज करें',
      'other': 'अमान्य प्रविष्टि',
    });
    return '$_temp0';
  }
}
