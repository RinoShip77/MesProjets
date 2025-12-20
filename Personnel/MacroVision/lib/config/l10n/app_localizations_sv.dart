// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Swedish (`sv`).
class AppLocalizationsSv extends AppLocalizations {
  AppLocalizationsSv([String locale = 'sv']) : super(locale);

  @override
  String appDialogTitle(String target) {
    String _temp0 = intl.Intl.selectLogic(target, {
      'legalWarning': 'Rättslig varning',
      'userGuide': 'Användarhandbok',
      'other': 'Språk stöds inte',
    });
    return '$_temp0';
  }

  @override
  String get appError => 'Ett fel har uppstått';

  @override
  String get appErrorDelete => 'Fel vid borttagning';

  @override
  String get appErrorForm => 'Fel i formuläret. Kontrollera dina uppgifter';

  @override
  String get appErrorLoadingAssets => 'Fel: Det gick inte att ladda filen';

  @override
  String get appErrorLoadingContent => 'Fel vid laddning av data';

  @override
  String appErrorReadFile(String context) {
    String _temp0 = intl.Intl.selectLogic(context, {
      'legalWarning': 'Fel: Det gick inte att läsa den rättsliga varningen',
      'userGuide': 'Fel: Det gick inte att läsa användarhandboken',
      'other': 'Fel: Det gick inte att läsa filen',
    });
    return '$_temp0';
  }

  @override
  String appLanguageName(String target) {
    String _temp0 = intl.Intl.selectLogic(target, {
      'fr': 'Franska',
      'en': 'Engelska',
      'es': 'Spanska',
      'fil': 'Filippinska',
      'hej': 'Hindi',
      'ja': 'Japanska',
      'sv': 'Svenska',
      'uk': 'Ukrainska',
      'zh': 'Kinesiska',
      'sw': 'Swahili',
      'other': 'Språk stöds inte',
    });
    return '$_temp0';
  }

  @override
  String get appLoadingLbl => 'Initierar...';

  @override
  String get appRefreshDataLbl => 'Uppdatera data';

  @override
  String get appSeeHistoryBtn => 'Visa historik';

  @override
  String appSuccessUpdate(String context) {
    String _temp0 = intl.Intl.selectLogic(context, {
      'profile': 'Profilen har uppdaterats med framgång',
      'history': 'Historiken har uppdaterats med framgång',
      'other': 'Uppdateringen lyckades',
    });
    return '$_temp0';
  }

  @override
  String appSummaryLbl(String duration) {
    String _temp0 = intl.Intl.selectLogic(duration, {
      'daily': 'Daglig sammanfattning',
      'weekly': 'Veckosammanfattning',
      'other': '',
    });
    return '$_temp0';
  }

  @override
  String get appUserNameInpLbl => 'Användarnamn';

  @override
  String get appWarningEmptyData => 'Ingen data';

  @override
  String appWarningFormValidation(String target) {
    String _temp0 = intl.Intl.selectLogic(target, {
      'weight': 'Ange en giltig vikt',
      'height': 'Ange en giltig längd',
      'age': 'Ange en giltig ålder',
      'comment': 'Vänligen ange din kommentar',
      'other': 'Ogiltig inmatning',
    });
    return '$_temp0';
  }

  @override
  String btnSaveLbl(String context) {
    return 'Spara $context';
  }

  @override
  String get btnSeeHistoryLbl => 'Visa historik';

  @override
  String get cameraScreenAnalysisInProgressLbl => 'Analys pågår via AI...';

  @override
  String cameraScreenBtn(String context) {
    String _temp0 = intl.Intl.selectLogic(context, {
      'flash': 'Växla blixt',
      'gallery': 'Välj en bild från galleriet',
      'camera': 'Ta ett foto',
      'other': 'Kamera',
    });
    return '$_temp0';
  }

  @override
  String cameraScreenErrors(String type) {
    String _temp0 = intl.Intl.selectLogic(type, {
      'initialization': 'Fel vid initiering av kameran',
      'flash': 'Fel vid växling av blixt',
      'capture': 'Fel vid bildtagning',
      'analysis': 'Analysfel',
      'permissions':
          'Kan inte komma åt kameran. Kontrollera appens behörigheter',
      'other': 'Kamerafel',
    });
    return '$_temp0';
  }

  @override
  String get cameraScreenTitle => 'Livsmedelsanalys';

  @override
  String get cameraScreenVisualHintLbl =>
      'Tips: Rikta mot ett livsmedel i taget, med bra ljus';

  @override
  String dashboardScreenChartTypeOption(String type) {
    String _temp0 = intl.Intl.selectLogic(type, {
      'bars': 'Staplar',
      'lines': 'Linjer',
      'other': 'Diagram',
    });
    return '$_temp0';
  }

  @override
  String dashboardScreenDailyObjectiveLbl(String target) {
    String _temp0 = intl.Intl.selectLogic(target, {
      'calories': 'Kalorier',
      'protein': 'Protein',
      'totalFat': 'Fett',
      'totalCarbohydrate': 'Kolhydrater',
      'other': 'Näringsämnen',
    });
    return '$_temp0';
  }

  @override
  String get dashboardScreenDailyObjectivesLbl => 'Dagens mål';

  @override
  String get dashboardScreenNotEnoughDataLbl =>
      'Otillräcklig historik för diagrammet';

  @override
  String get dashboardScreenSelectChartTypeLbl =>
      'Visa data i ett stapel- eller linjediagram';

  @override
  String get dashboardScreenTitle => 'Instrumentpanel';

  @override
  String get dashboardScreenWeeklySummaryLbl =>
      'Veckosammanfattning (Kalorier)';

  @override
  String get errorForm => 'Fel i formuläret. Kontrollera dina uppgifter';

  @override
  String get errorGlobal => 'Ett fel har uppstått';

  @override
  String get errorLoadingAssets => 'Fel: Det gick inte att ladda filen';

  @override
  String get errorLoadingContent => 'Fel vid laddning av data';

  @override
  String get errorReadUserGuide =>
      'Fel: Det gick inte att läsa användarhandboken';

  @override
  String get errorScreenDetailsLbl => 'Detaljer (synliga i felsökningsläge):';

  @override
  String errorScreenGoToBtn(String target) {
    String _temp0 = intl.Intl.selectLogic(target, {
      'comment': 'Skicka en kommentar',
      'home': 'Gå tillbaka till startsidan',
      'other': '',
    });
    return '$_temp0';
  }

  @override
  String get errorScreenTitle => 'Fel';

  @override
  String get feedbackScreenCommentHintLbl =>
      'Beskriv din upplevelse, rapportera en bugg eller föreslå en idé...';

  @override
  String get feedbackScreenCommentPaceholderLbl => 'Ditt meddelande...';

  @override
  String get feedbackScreenEncouragingMessageLbl =>
      'Jag uppskattar din feedback! Hjälp mig att förbättra MacroVision';

  @override
  String get feedbackScreenNoEmailClientLbl =>
      'Det går inte att öppna e-postappen';

  @override
  String get feedbackScreenNoRecipientEmailLbl =>
      'E-postadress för feedback saknas';

  @override
  String get feedbackScreenOpeningEmailLbl => 'Öppnar e-postappen';

  @override
  String feedbackScreenSendBtn(String state) {
    String _temp0 = intl.Intl.selectLogic(state, {
      'true': 'Skickar...',
      'false': 'Skicka feedback',
      'other': '',
    });
    return '$_temp0';
  }

  @override
  String get feedbackScreenSendToClipboard =>
      'Skicka mitt meddelande till urklipp';

  @override
  String get feedbackScreenSendTooltip => 'Skicka feedback';

  @override
  String feedbackScreenSendedToClipboard(String context) {
    String _temp0 = intl.Intl.selectLogic(context, {
      'comment': 'Kommentaren har kopierats till urklipp',
      'email': 'E-postadressen har kopierats till urklipp',
      'other': 'Kopierat till urklipp',
    });
    return '$_temp0';
  }

  @override
  String get feedbackScreenSendingError => 'Fel vid sändning av feedback';

  @override
  String get feedbackScreenTitle => 'Kommentar';

  @override
  String historyScreenDeleteSuccessLbl(String date) {
    return 'Inlägget för $date har tagits bort från historiken';
  }

  @override
  String get historyScreenTitle => 'Historik';

  @override
  String homeScreenDailyAnalisisLbl(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Analyser ($count)',
      one: 'Analys (1)',
      zero: 'Inga analyser',
    );
    return '$_temp0';
  }

  @override
  String homeScreenDailySummaryMacroCardLbl(String field) {
    String _temp0 = intl.Intl.selectLogic(field, {
      'carbohydrate': 'Kolhydrater',
      'protein': 'Proteiner',
      'fat': 'Lipider',
      'other': 'Näringsämnen',
    });
    return '$_temp0';
  }

  @override
  String homeScreenDailySummaryStatLbl(int stat) {
    return 'av $stat g';
  }

  @override
  String get homeScreenStartAnalysisBtn => 'Analysera en måltid';

  @override
  String get homeScreenTitle => 'Hem';

  @override
  String get homeScreenWelcomeLbl => 'Välkommen till MacroVision';

  @override
  String initializationScreenDialogDefaultLbl(String target) {
    String _temp0 = intl.Intl.selectLogic(target, {
      'legalWarning': 'Laddar rättslig varning...',
      'userGuide': 'Laddar instruktioner...',
      'other': 'Laddar innehåll...',
    });
    return '$_temp0';
  }

  @override
  String get profileScreenActivityLevelInpLbl => 'Fysisk aktivitetsnivå';

  @override
  String profileScreenActivityLevelOption(String target) {
    String _temp0 = intl.Intl.selectLogic(target, {
      'sedentary': 'Stillasittande (lite eller ingen motion)',
      'lightly': 'Lätt aktiv (1-3 dagar/vecka)',
      'moderate': 'Måttligt aktiv (3-5 dagar/vecka)',
      'very': 'Mycket aktiv (6-7 dagar/vecka)',
      'extra': 'Extremt aktiv (2 ggr/dag)',
      'other': 'Ingen',
    });
    return '$_temp0';
  }

  @override
  String get profileScreenGenderInpLbl => 'Kön';

  @override
  String profileScreenGenderOption(String target) {
    String _temp0 = intl.Intl.selectLogic(target, {
      'male': 'Man',
      'female': 'Kvinna',
      'other': 'Annat',
    });
    return '$_temp0';
  }

  @override
  String get profileScreenGoalInpLbl => 'Huvudsakligt mål';

  @override
  String profileScreenGoalOption(String target) {
    String _temp0 = intl.Intl.selectLogic(target, {
      'weightLoss': 'Viktminskning',
      'muscleGain': 'Muskelökning',
      'maintain': 'Behålla',
      'other': 'Inget',
    });
    return '$_temp0';
  }

  @override
  String profileScreenInpLbl(String target, String unit) {
    String _temp0 = intl.Intl.selectLogic(target, {
      'weight': 'Vikt ($unit)',
      'height': 'Längd ($unit)',
      'other': 'Ålder',
    });
    return '$_temp0';
  }

  @override
  String get profileScreenSaveBtn => 'Spara profil';

  @override
  String get profileScreenTitle => 'Profil';

  @override
  String get profileScreenUnitSystemSwitch =>
      'Metrisk (kg, cm) eller Imperial (lb, in)';

  @override
  String profileScreenUnitOption(String unit) {
    String _temp0 = intl.Intl.selectLogic(unit, {
      'metric': 'Metrisk',
      'imperial': 'Imperial',
      'other': 'Ingen',
    });
    return '$_temp0';
  }

  @override
  String get profileScreenUnitSystemLbl => 'Enhetssystem';

  @override
  String resultScreenAnalysisOutputLbl(String context) {
    String _temp0 = intl.Intl.selectLogic(context, {
      'energy': 'Energi',
      'calories': 'Kalorier',
      'totalFat': 'Fett',
      'saturatedFat': 'Mättat',
      'transFat': 'Trans',
      'cholesterol': 'Kolesterol',
      'sodium': 'Natrium',
      'potassium': 'Kalium',
      'carbohydrate': 'Kolhydrater',
      'fiber': 'Fiber',
      'sugar': 'Sockerarter',
      'protein': 'Protein',
      'other': 'Näringsämnen',
    });
    return '$_temp0';
  }

  @override
  String resultScreenAnalysisSummaryLbl(String weight, String unit) {
    return 'Näringsanalys för $weight $unit';
  }

  @override
  String resultScreenEstimatedWeightLbl(String weight, String unit) {
    return 'Portion uppskattad av AI: $weight $unit';
  }

  @override
  String get resultScreenNewAnalysisBtn => 'Analysera ett nytt foto';

  @override
  String resultScreenPortionLbl(String unit) {
    return 'Verklig vikt ($unit)';
  }

  @override
  String get resultScreenRefineAnalysisBtn => 'Justera analysen';

  @override
  String resultScreenRefineAnalysisLbl(String weight, String unit) {
    return 'Justerad analys för $weight ($unit)';
  }

  @override
  String resultScreenSwitchLbl(String unit) {
    String _temp0 = intl.Intl.selectLogic(unit, {
      'kJ': 'Visa i kcal/cal',
      'cal': 'Visa i kJ',
      'other': 'byt enhet',
    });
    return '$_temp0';
  }

  @override
  String get resultScreenTitle => 'Resultat';

  @override
  String settingsScreenCustomThemeOption(String color) {
    String _temp0 = intl.Intl.selectLogic(color, {
      'mint': 'Mynta',
      'ocean': 'Ocean',
      'passion': 'Passion',
      'neon': 'Neon',
      'platinum': 'Platina',
      'merlot': 'Merlot',
      'lemon': 'Citron',
      'lime': 'Lime',
      'peacock': 'Påfågel',
      'azure': 'Azur',
      'candy': 'Godis',
      'pumpkin': 'Pumpa',
      'lapis': 'Lapis',
      'scarlet': 'Scharlakansröd',
      'other': 'Färg',
    });
    return '$_temp0';
  }

  @override
  String get settingsScreenLanguageSelectLbl => 'Språk';

  @override
  String settingsScreenLuminosityOption(String target) {
    String _temp0 = intl.Intl.selectLogic(target, {
      'default': 'Systemstandard',
      'light': 'Ljust läge',
      'dark': 'Mörkt läge',
      'other': 'Ingen',
    });
    return '$_temp0';
  }

  @override
  String settingsScreenSectionLbl(String target) {
    String _temp0 = intl.Intl.selectLogic(target, {
      'language': 'Applikationsspråk',
      'luminosity': 'Applikationens ljusstyrka',
      'color': 'Anpassade färger',
      'other': 'Inställningar',
    });
    return '$_temp0';
  }

  @override
  String get settingsScreenTitle => 'Inställningar';

  @override
  String statsCalorie(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Kalorier: $count',
      one: 'Kalori: 1',
      zero: 'Kalori: 0',
    );
    return '$_temp0';
  }

  @override
  String get warningEmptyData => 'Ingen data';

  @override
  String warningFormValidation(String target) {
    String _temp0 = intl.Intl.selectLogic(target, {
      'weight': 'Ange en giltig vikt',
      'height': 'Ange en giltig längd',
      'age': 'Ange en giltig ålder',
      'other': 'Ogiltig inmatning',
    });
    return '$_temp0';
  }
}
