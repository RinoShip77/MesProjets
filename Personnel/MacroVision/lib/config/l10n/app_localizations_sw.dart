// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Swahili (`sw`).
class AppLocalizationsSw extends AppLocalizations {
  AppLocalizationsSw([String locale = 'sw']) : super(locale);

  @override
  String appDialogTitle(String target) {
    String _temp0 = intl.Intl.selectLogic(target, {
      'legalWarning': 'Onyo la kisheria',
      'userGuide': 'Mwongozo wa mtumiaji',
      'other': 'Lugha haitumiki',
    });
    return '$_temp0';
  }

  @override
  String get appError => 'Hitilafu imetokea';

  @override
  String get appErrorDelete => 'Hitilafu wakati wa kufuta';

  @override
  String get appErrorForm =>
      'Hitilafu katika fomu. Tafadhali kagua maelezo yako';

  @override
  String get appErrorLoadingAssets => 'Hitilafu: Haiwezekani kupakia faili';

  @override
  String get appErrorLoadingContent => 'Hitilafu ya kupakia data';

  @override
  String appErrorReadFile(String context) {
    String _temp0 = intl.Intl.selectLogic(context, {
      'legalWarning': 'Hitilafu: Haiwezekani kusoma onyo la kisheria',
      'userGuide': 'Hitilafu: Haiwezekani kusoma mwongozo wa mtumiaji',
      'other': 'Hitilafu: Haiwezekani kusoma faili',
    });
    return '$_temp0';
  }

  @override
  String appLanguageName(String target) {
    String _temp0 = intl.Intl.selectLogic(target, {
      'fr': 'Kifaransa',
      'en': 'Kiingereza',
      'es': 'Spanish',
      'fil': 'Filipino',
      'hi': 'Kihindi',
      'ja': 'Japanese',
      'sv': 'Swedish',
      'uk': 'Ukrainian',
      'zh': 'Kichina',
      'sw': 'Kiswahili',
      'other': 'Lugha haitumiki',
    });
    return '$_temp0';
  }

  @override
  String get appLoadingLbl => 'Inapakia...';

  @override
  String get appRefreshDataLbl => 'Refresh data';

  @override
  String get appSeeHistoryBtn => 'Angalia historia';

  @override
  String appSuccessUpdate(String context) {
    String _temp0 = intl.Intl.selectLogic(context, {
      'profile': 'Wasifu umesasishwa kwa mafanikio',
      'history': 'Historia imesasishwa kwa mafanikio',
      'other': 'Usasishaji umefanikiwa',
    });
    return '$_temp0';
  }

  @override
  String appSummaryLbl(String duration) {
    String _temp0 = intl.Intl.selectLogic(duration, {
      'daily': 'Muhtasari wa kila siku',
      'weekly': 'Muhtasari wa kila wiki',
      'other': '',
    });
    return '$_temp0';
  }

  @override
  String get appUserNameInpLbl => 'Jina la mtumiaji';

  @override
  String get appWarningEmptyData => 'Hakuna data';

  @override
  String appWarningFormValidation(String target) {
    String _temp0 = intl.Intl.selectLogic(target, {
      'weight': 'Ingiza uzito sahihi',
      'height': 'Ingiza kimo sahihi',
      'age': 'Ingiza umri sahihi',
      'comment': 'Tafadhali ingiza maoni yako',
      'other': 'Ingizo si sahihi',
    });
    return '$_temp0';
  }

  @override
  String btnSaveLbl(String context) {
    return 'Hifadhi $context';
  }

  @override
  String get btnSeeHistoryLbl => 'Angalia historia';

  @override
  String get cameraScreenAnalysisInProgressLbl =>
      'Uchambuzi unaendelea kupitia AI...';

  @override
  String cameraScreenBtn(String context) {
    String _temp0 = intl.Intl.selectLogic(context, {
      'flash': 'Washa/Zima flash',
      'gallery': 'Chagua picha kutoka kwenye galari',
      'camera': 'Piga picha',
      'other': 'Kamera',
    });
    return '$_temp0';
  }

  @override
  String cameraScreenErrors(String type) {
    String _temp0 = intl.Intl.selectLogic(type, {
      'initialization': 'Hitilafu ya kuanzisha kamera',
      'flash': 'Hitilafu wakati wa kuwasha/zima flash',
      'capture': 'Hitilafu ya kupiga picha',
      'analysis': 'Hitilafu ya uchambuzi',
      'permissions': 'Imeshindikana kufikia kamera. Angalia ruhusa za programu',
      'other': 'Hitilafu ya kamera',
    });
    return '$_temp0';
  }

  @override
  String get cameraScreenTitle => 'Uchambuzi wa chakula';

  @override
  String get cameraScreenVisualHintLbl =>
      'Kidokezo: Lenga chakula kimoja kwa wakati mmoja, kikiwa na mwanga mzuri';

  @override
  String dashboardScreenChartTypeOption(String type) {
    String _temp0 = intl.Intl.selectLogic(type, {
      'bars': 'Pau',
      'lines': 'Mistari',
      'other': 'Grafu',
    });
    return '$_temp0';
  }

  @override
  String dashboardScreenDailyObjectiveLbl(String target) {
    String _temp0 = intl.Intl.selectLogic(target, {
      'calories': 'Kalori',
      'protein': 'Protini',
      'totalFat': 'Mafuta',
      'totalCarbohydrate': 'Wanga',
      'other': 'Virutubisho',
    });
    return '$_temp0';
  }

  @override
  String get dashboardScreenDailyObjectivesLbl => 'Malengo ya leo';

  @override
  String get dashboardScreenNotEnoughDataLbl =>
      'Historia haitoshi kwa ajili ya grafu';

  @override
  String get dashboardScreenSelectChartTypeLbl =>
      'Onyesha data katika grafu ya pau au mistari';

  @override
  String get dashboardScreenTitle => 'Dashibodi';

  @override
  String get dashboardScreenWeeklySummaryLbl => 'Muhtasari wa wiki (Kalori)';

  @override
  String get errorForm => 'Hitilafu katika fomu. Tafadhali kagua maelezo yako';

  @override
  String get errorGlobal => 'Hitilafu imetokea';

  @override
  String get errorLoadingAssets => 'Hitilafu: Haiwezekani kupakia faili';

  @override
  String get errorLoadingContent => 'Hitilafu ya kupakia data';

  @override
  String get errorReadUserGuide =>
      'Hitilafu: Haiwezekani kusoma mwongozo wa mtumiaji';

  @override
  String get errorScreenDetailsLbl =>
      'Maelezo (yanaonekana katika hali ya Debug):';

  @override
  String errorScreenGoToBtn(String target) {
    String _temp0 = intl.Intl.selectLogic(target, {
      'comment': 'Tuma maoni',
      'home': 'Rudi nyumbani',
      'other': '',
    });
    return '$_temp0';
  }

  @override
  String get errorScreenTitle => 'Hitilafu';

  @override
  String get feedbackScreenCommentHintLbl =>
      'Elezea uzoefu wako, ripoti hitilafu au pendekeza wazo...';

  @override
  String get feedbackScreenCommentPaceholderLbl => 'Ujumbe wako...';

  @override
  String get feedbackScreenEncouragingMessageLbl =>
      'Nashukuru kwa maoni yako! Nisaidie kuboresha MacroVision';

  @override
  String get feedbackScreenNoEmailClientLbl =>
      'Imeshindikana kufungua programu ya barua pepe';

  @override
  String get feedbackScreenNoRecipientEmailLbl =>
      'Anwani ya barua pepe ya maoni haipo';

  @override
  String get feedbackScreenOpeningEmailLbl =>
      'Inafungua programu ya barua pepe';

  @override
  String feedbackScreenSendBtn(String state) {
    String _temp0 = intl.Intl.selectLogic(state, {
      'true': 'Inatuma...',
      'false': 'Tuma maoni',
      'other': '',
    });
    return '$_temp0';
  }

  @override
  String get feedbackScreenSendToClipboard =>
      'Tuma ujumbe wangu kwenye ubao wa kunakili (clipboard)';

  @override
  String get feedbackScreenSendTooltip => 'Tuma maoni';

  @override
  String feedbackScreenSendedToClipboard(String context) {
    String _temp0 = intl.Intl.selectLogic(context, {
      'comment': 'Maoni yametumwa kwenye ubao wa kunakili',
      'email': 'Anwani ya barua pepe imetumwa kwenye ubao wa kunakili',
      'other': 'Imetumwa kwenye ubao wa kunakili',
    });
    return '$_temp0';
  }

  @override
  String get feedbackScreenSendingError => 'Hitilafu wakati wa kutuma maoni';

  @override
  String get feedbackScreenTitle => 'Maoni';

  @override
  String historyScreenDeleteSuccessLbl(String date) {
    return 'Ingizo la tarehe $date limefutwa kwenye historia';
  }

  @override
  String get historyScreenTitle => 'Historia';

  @override
  String homeScreenDailyAnalisisLbl(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Uchambuzi ($count)',
      one: 'Uchambuzi (1)',
      zero: 'Hakuna uchambuzi',
    );
    return '$_temp0';
  }

  @override
  String homeScreenDailySummaryMacroCardLbl(String field) {
    String _temp0 = intl.Intl.selectLogic(field, {
      'carbohydrate': 'Wanga',
      'protein': 'Protini',
      'fat': 'Mafuta',
      'other': 'Takwimu',
    });
    return '$_temp0';
  }

  @override
  String homeScreenDailySummaryStatLbl(int stat) {
    return 'kati ya $stat g';
  }

  @override
  String get homeScreenStartAnalysisBtn => 'Chambua mlo';

  @override
  String get homeScreenTitle => 'Nyumbani';

  @override
  String get homeScreenWelcomeLbl => 'Karibu kwenye MacroVision';

  @override
  String initializationScreenDialogDefaultLbl(String target) {
    String _temp0 = intl.Intl.selectLogic(target, {
      'legalWarning': 'Inapakia onyo la kisheria...',
      'userGuide': 'Inapakia maelekezo...',
      'other': 'Inapakia maudhui...',
    });
    return '$_temp0';
  }

  @override
  String get profileScreenActivityLevelInpLbl => 'Kiwango cha mazoezi';

  @override
  String profileScreenActivityLevelOption(String target) {
    String _temp0 = intl.Intl.selectLogic(target, {
      'sedentary': 'Hafanyi mazoezi (kidogo au hakuna)',
      'lightly': 'Mazoezi kidogo (siku 1-3/wiki)',
      'moderate': 'Mazoezi ya wastani (siku 3-5/wiki)',
      'very': 'Mazoezi mengi (siku 6-7/wiki)',
      'extra': 'Mazoezi makubwa (2x/siku)',
      'other': 'Hakuna',
    });
    return '$_temp0';
  }

  @override
  String get profileScreenGenderInpLbl => 'Jinsia';

  @override
  String profileScreenGenderOption(String target) {
    String _temp0 = intl.Intl.selectLogic(target, {
      'male': 'Mwanaume',
      'female': 'Mwanamke',
      'other': 'Nyingine',
    });
    return '$_temp0';
  }

  @override
  String get profileScreenGoalInpLbl => 'Lengo kuu';

  @override
  String profileScreenGoalOption(String target) {
    String _temp0 = intl.Intl.selectLogic(target, {
      'weightLoss': 'Kupunguza uzito',
      'muscleGain': 'Kuongeza misuli',
      'maintain': 'Kudumisha uzito',
      'other': 'Hakuna',
    });
    return '$_temp0';
  }

  @override
  String profileScreenInpLbl(String target, String unit) {
    String _temp0 = intl.Intl.selectLogic(target, {
      'weight': 'Uzito ($unit)',
      'height': 'Kimo ($unit)',
      'other': 'Umri',
    });
    return '$_temp0';
  }

  @override
  String get profileScreenSaveBtn => 'Hifadhi wasifu';

  @override
  String get profileScreenTitle => 'Wasifu';

  @override
  String get profileScreenUnitSystemSwitch =>
      'Metriki (kg, cm) au Impirio (lb, in)';

  @override
  String profileScreenUnitOption(String unit) {
    String _temp0 = intl.Intl.selectLogic(unit, {
      'metric': 'Metriki',
      'imperial': 'Impirio',
      'other': 'Hakuna',
    });
    return '$_temp0';
  }

  @override
  String get profileScreenUnitSystemLbl => 'Mfumo wa vipimo';

  @override
  String resultScreenAnalysisOutputLbl(String context) {
    String _temp0 = intl.Intl.selectLogic(context, {
      'energy': 'Nishati',
      'calories': 'Kalori',
      'totalFat': 'mafuta',
      'saturatedFat': 'Yaliyokwama',
      'transFat': 'Trans',
      'cholesterol': 'Kolesteroli',
      'sodium': 'Sodiamu',
      'potassium': 'Potasiamu',
      'carbohydrate': 'Wanga',
      'fiber': 'Nyuzi',
      'sugar': 'Sukari',
      'protein': 'Protini',
      'other': 'Virutubisho',
    });
    return '$_temp0';
  }

  @override
  String resultScreenAnalysisSummaryLbl(String weight, String unit) {
    return 'Uchambuzi wa lishe kwa $weight $unit';
  }

  @override
  String resultScreenEstimatedWeightLbl(String weight, String unit) {
    return 'Sehemu iliyokadiriwa na AI: $weight $unit';
  }

  @override
  String get resultScreenNewAnalysisBtn => 'Chambua picha mpya';

  @override
  String resultScreenPortionLbl(String unit) {
    return 'Uzito halisi ($unit)';
  }

  @override
  String get resultScreenRefineAnalysisBtn => 'Rekebisha uchambuzi';

  @override
  String resultScreenRefineAnalysisLbl(String weight, String unit) {
    return 'Uchambuzi uliorekebishwa kwa $weight ($unit)';
  }

  @override
  String resultScreenSwitchLbl(String unit) {
    String _temp0 = intl.Intl.selectLogic(unit, {
      'kJ': 'Onyesha katika kcal/cal',
      'cal': 'Onyesha katika kJ',
      'other': 'badili kipimo',
    });
    return '$_temp0';
  }

  @override
  String get resultScreenTitle => 'Matokeo';

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
      'other': 'Rangi',
    });
    return '$_temp0';
  }

  @override
  String get settingsScreenLanguageSelectLbl => 'Lugha';

  @override
  String settingsScreenLuminosityOption(String target) {
    String _temp0 = intl.Intl.selectLogic(target, {
      'default': 'Mfumo chaguo-msingi',
      'light': 'Hali ya mwanga',
      'dark': 'Hali ya giza',
      'other': 'Hakuna',
    });
    return '$_temp0';
  }

  @override
  String settingsScreenSectionLbl(String target) {
    String _temp0 = intl.Intl.selectLogic(target, {
      'language': 'Lugha ya programu',
      'luminosity': 'Mwanga wa programu',
      'color': 'Rangi maalum',
      'other': 'Mipangilio',
    });
    return '$_temp0';
  }

  @override
  String get settingsScreenTitle => 'Mipangilio';

  @override
  String statsCalorie(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Kalori : $count',
      one: 'Kalori : 1',
      zero: 'Kalori : 0',
    );
    return '$_temp0';
  }

  @override
  String get warningEmptyData => 'Hakuna data';

  @override
  String warningFormValidation(String target) {
    String _temp0 = intl.Intl.selectLogic(target, {
      'weight': 'Ingiza uzito sahihi',
      'height': 'Ingiza kimo sahihi',
      'age': 'Ingiza umri sahihi',
      'other': 'Ingizo si sahihi',
    });
    return '$_temp0';
  }
}
