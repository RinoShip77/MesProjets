// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Ukrainian (`uk`).
class AppLocalizationsUk extends AppLocalizations {
  AppLocalizationsUk([String locale = 'uk']) : super(locale);

  @override
  String appDialogTitle(String target) {
    String _temp0 = intl.Intl.selectLogic(target, {
      'legalWarning': 'Юридичне попередження',
      'userGuide': 'Посібник користувача',
      'other': 'Мова не підтримується',
    });
    return '$_temp0';
  }

  @override
  String get appError => 'Сталася помилка';

  @override
  String get appErrorDelete => 'Помилка видалення';

  @override
  String get appErrorForm =>
      'Помилка у формі. Будь ласка, перевірте введені дані';

  @override
  String get appErrorLoadingAssets => 'Помилка: Не вдалося завантажити файл';

  @override
  String get appErrorLoadingContent => 'Помилка завантаження даних';

  @override
  String appErrorReadFile(String context) {
    String _temp0 = intl.Intl.selectLogic(context, {
      'legalWarning': 'Помилка: Не вдалося прочитати юридичне попередження',
      'userGuide': 'Помилка: Не вдалося прочитати посібник користувача',
      'other': 'Помилка: Не вдалося прочитати файл',
    });
    return '$_temp0';
  }

  @override
  String appLanguageName(String target) {
    String _temp0 = intl.Intl.selectLogic(target, {
      'fr': 'Французька',
      'en': 'Англійська',
      'es': 'іспанська',
      'fil': 'філіппінська',
      'hi': 'хінді',
      'ja': 'японська',
      'sv': 'шведська',
      'uk': 'українська',
      'zh': 'китайська',
      'other': 'Мова не підтримується',
    });
    return '$_temp0';
  }

  @override
  String get appLoadingLbl => 'Ініціалізація...';

  @override
  String get appRefreshDataLbl => 'Оновити дані';

  @override
  String get appSeeHistoryBtn => 'Переглянути історію';

  @override
  String appSuccessUpdate(String context) {
    String _temp0 = intl.Intl.selectLogic(context, {
      'profile': 'Профіль успішно оновлено',
      'history': 'Історію успішно оновлено',
      'other': 'Оновлення успішне',
    });
    return '$_temp0';
  }

  @override
  String appSummaryLbl(String duration) {
    String _temp0 = intl.Intl.selectLogic(duration, {
      'daily': 'Щоденний підсумок',
      'weekly': 'Щотижневий підсумок',
      'other': '',
    });
    return '$_temp0';
  }

  @override
  String get appUserNameInpLbl => 'Ім\'я користувача';

  @override
  String get appWarningEmptyData => 'Дані відсутні';

  @override
  String appWarningFormValidation(String target) {
    String _temp0 = intl.Intl.selectLogic(target, {
      'weight': 'Введіть коректну вагу',
      'height': 'Введіть коректний зріст',
      'age': 'Введіть коректний вік',
      'comment': 'Будь ласка, введіть свій коментар',
      'other': 'Некоректне введення',
    });
    return '$_temp0';
  }

  @override
  String btnSaveLbl(String context) {
    return 'Зберегти $context';
  }

  @override
  String get btnSeeHistoryLbl => 'Переглянути історію';

  @override
  String get cameraScreenAnalysisInProgressLbl => 'Триває аналіз ШІ...';

  @override
  String cameraScreenBtn(String context) {
    String _temp0 = intl.Intl.selectLogic(context, {
      'flash': 'Перемкнути спалах',
      'gallery': 'Вибрати зображення з галереї',
      'camera': 'Зробити фото',
      'other': 'Камера',
    });
    return '$_temp0';
  }

  @override
  String cameraScreenErrors(String type) {
    String _temp0 = intl.Intl.selectLogic(type, {
      'initialization': 'Помилка ініціалізації камери',
      'flash': 'Помилка при перемиканні спалаху',
      'capture': 'Помилка захоплення',
      'analysis': 'Помилка аналізу',
      'permissions':
          'Не вдалося отримати доступ до камери. Перевірте дозволи програми',
      'other': 'Помилка камери',
    });
    return '$_temp0';
  }

  @override
  String get cameraScreenTitle => 'Аналіз їжі';

  @override
  String get cameraScreenVisualHintLbl =>
      'Порада: цільтеся в один продукт за раз при хорошому освітленні';

  @override
  String dashboardScreenChartTypeOption(String type) {
    String _temp0 = intl.Intl.selectLogic(type, {
      'bars': 'Стовпці',
      'lines': 'Лінії',
      'other': 'Графік',
    });
    return '$_temp0';
  }

  @override
  String dashboardScreenDailyObjectiveLbl(String target) {
    String _temp0 = intl.Intl.selectLogic(target, {
      'calories': 'Калорії',
      'protein': 'Білки',
      'totalFat': 'Жири',
      'totalCarbohydrate': 'Вуглеводи',
      'other': 'Нутрієнти',
    });
    return '$_temp0';
  }

  @override
  String get dashboardScreenDailyObjectivesLbl => 'Цілі на сьогодні';

  @override
  String get dashboardScreenNotEnoughDataLbl =>
      'Недостатньо історії для графіка';

  @override
  String get dashboardScreenSelectChartTypeLbl =>
      'Відобразити дані у вигляді стовпчастої або лінійної діаграми';

  @override
  String get dashboardScreenTitle => 'Панель приладів';

  @override
  String get dashboardScreenWeeklySummaryLbl => 'Тижневий підсумок (калорії)';

  @override
  String get errorForm => 'Помилка у формі. Будь ласка, перевірте введені дані';

  @override
  String get errorGlobal => 'Сталася помилка';

  @override
  String get errorLoadingAssets => 'Помилка: Не вдалося завантажити файл';

  @override
  String get errorLoadingContent => 'Помилка завантаження даних';

  @override
  String get errorReadUserGuide =>
      'Помилка: Не вдалося прочитати посібник користувача';

  @override
  String get errorScreenDetailsLbl => 'Деталі (видно в режимі налагодження):';

  @override
  String errorScreenGoToBtn(String target) {
    String _temp0 = intl.Intl.selectLogic(target, {
      'comment': 'Надіслати коментар',
      'home': 'Повернутися на головну',
      'other': '',
    });
    return '$_temp0';
  }

  @override
  String get errorScreenTitle => 'Помилка';

  @override
  String get feedbackScreenCommentHintLbl =>
      'Опишіть свій досвід, повідомте про помилку або запропонуйте ідею...';

  @override
  String get feedbackScreenCommentPaceholderLbl => 'Ваше повідомлення...';

  @override
  String get feedbackScreenEncouragingMessageLbl =>
      'Я ціную ваші відгуки! Допоможіть мені вдосконалити MacroVision';

  @override
  String get feedbackScreenNoEmailClientLbl =>
      'Не вдалося відкрити поштову програму';

  @override
  String get feedbackScreenNoRecipientEmailLbl =>
      'Відсутня електронна адреса для відгуків';

  @override
  String get feedbackScreenOpeningEmailLbl => 'Відкриття поштової програми';

  @override
  String feedbackScreenSendBtn(String state) {
    String _temp0 = intl.Intl.selectLogic(state, {
      'true': 'Надсилання...',
      'false': 'Надіслати відгук',
      'other': '',
    });
    return '$_temp0';
  }

  @override
  String get feedbackScreenSendToClipboard =>
      'Копіювати повідомлення в буфер обміну';

  @override
  String get feedbackScreenSendTooltip => 'Надіслати відгук';

  @override
  String feedbackScreenSendedToClipboard(String context) {
    String _temp0 = intl.Intl.selectLogic(context, {
      'comment': 'Коментар скопійовано в буфер обміну',
      'email': 'Електронну адресу скопійовано в буфер обміну',
      'other': 'Скопійовано в буфер обміну',
    });
    return '$_temp0';
  }

  @override
  String get feedbackScreenSendingError => 'Помилка під час надсилання відгуку';

  @override
  String get feedbackScreenTitle => 'Коментар';

  @override
  String historyScreenDeleteSuccessLbl(String date) {
    return 'Запис за $date видалено з історії';
  }

  @override
  String get historyScreenTitle => 'Історія';

  @override
  String homeScreenDailyAnalisisLbl(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Аналізи ($count)',
      one: 'Аналіз (1)',
      zero: 'Немає аналізів',
    );
    return '$_temp0';
  }

  @override
  String homeScreenDailySummaryMacroCardLbl(String field) {
    String _temp0 = intl.Intl.selectLogic(field, {
      'carbohydrate': 'Вугл',
      'protein': 'Білки',
      'fat': 'Жири',
      'other': 'Стат',
    });
    return '$_temp0';
  }

  @override
  String homeScreenDailySummaryStatLbl(int stat) {
    return 'з $stat г';
  }

  @override
  String get homeScreenStartAnalysisBtn => 'Проаналізувати страву';

  @override
  String get homeScreenTitle => 'Головна';

  @override
  String get homeScreenWelcomeLbl => 'Ласкаво просимо до MacroVision';

  @override
  String initializationScreenDialogDefaultLbl(String target) {
    String _temp0 = intl.Intl.selectLogic(target, {
      'legalWarning': 'Завантаження юридичного попередження...',
      'userGuide': 'Завантаження інструкцій...',
      'other': 'Завантаження вмісту...',
    });
    return '$_temp0';
  }

  @override
  String get profileScreenActivityLevelInpLbl => 'Рівень фізичної активності';

  @override
  String profileScreenActivityLevelOption(String target) {
    String _temp0 = intl.Intl.selectLogic(target, {
      'sedentary': 'Сидячий (мало або зовсім без вправ)',
      'lightly': 'Малоактивний (1-3 дні/тиждень)',
      'moderate': 'Помірно активний (3-5 днів/тиждень)',
      'very': 'Дуже активний (6-7 днів/тиждень)',
      'extra': 'Екстремально активний (2 рази на день)',
      'other': 'Немає',
    });
    return '$_temp0';
  }

  @override
  String get profileScreenGenderInpLbl => 'Стать';

  @override
  String profileScreenGenderOption(String target) {
    String _temp0 = intl.Intl.selectLogic(target, {
      'male': 'Чоловік',
      'female': 'Жінка',
      'other': 'Інше',
    });
    return '$_temp0';
  }

  @override
  String get profileScreenGoalInpLbl => 'Основна ціль';

  @override
  String profileScreenGoalOption(String target) {
    String _temp0 = intl.Intl.selectLogic(target, {
      'weightLoss': 'Втрата ваги',
      'muscleGain': 'Набір м\'язової маси',
      'maintain': 'Підтримка',
      'other': 'Немає',
    });
    return '$_temp0';
  }

  @override
  String profileScreenInpLbl(String target, String unit) {
    String _temp0 = intl.Intl.selectLogic(target, {
      'weight': 'Вага ($unit)',
      'height': 'Зріст ($unit)',
      'other': 'Вік',
    });
    return '$_temp0';
  }

  @override
  String get profileScreenSaveBtn => 'Зберегти профіль';

  @override
  String get profileScreenTitle => 'Профіль';

  @override
  String get profileScreenUnitSystemSwitch =>
      'Метрична (кг, см) або Імперська (фунти, дюйми)';

  @override
  String profileScreenUnitOption(String unit) {
    String _temp0 = intl.Intl.selectLogic(unit, {
      'metric': 'Метрична',
      'imperial': 'Імперська',
      'other': 'Немає',
    });
    return '$_temp0';
  }

  @override
  String get profileScreenUnitSystemLbl => 'Система одиниць';

  @override
  String resultScreenAnalysisOutputLbl(String context) {
    String _temp0 = intl.Intl.selectLogic(context, {
      'energy': 'Енергія',
      'calories': 'Калорії',
      'totalFat': 'Жири',
      'saturatedFat': 'Насичені',
      'transFat': 'Трансжири',
      'cholesterol': 'Холестерин',
      'sodium': 'Натрій',
      'potassium': 'Калій',
      'carbohydrate': 'Вуглеводи',
      'fiber': 'Клітковина',
      'sugar': 'Цукри',
      'protein': 'Білки',
      'other': 'Нутрієнти',
    });
    return '$_temp0';
  }

  @override
  String resultScreenAnalysisSummaryLbl(String weight, String unit) {
    return 'Харчовий аналіз для $weight $unit';
  }

  @override
  String resultScreenEstimatedWeightLbl(String weight, String unit) {
    return 'Порція, оцінена ШІ: $weight $unit';
  }

  @override
  String get resultScreenNewAnalysisBtn => 'Проаналізувати нове фото';

  @override
  String resultScreenPortionLbl(String unit) {
    return 'Фактична вага ($unit)';
  }

  @override
  String get resultScreenRefineAnalysisBtn => 'Налаштувати аналіз';

  @override
  String resultScreenRefineAnalysisLbl(String weight, String unit) {
    return 'Скоригований аналіз для $weight ($unit)';
  }

  @override
  String resultScreenSwitchLbl(String unit) {
    String _temp0 = intl.Intl.selectLogic(unit, {
      'kJ': 'Показати в ккал/кал',
      'cal': 'Показати в кДж',
      'other': 'змінити одиницю виміру',
    });
    return '$_temp0';
  }

  @override
  String get resultScreenTitle => 'Результат';

  @override
  String settingsScreenCustomThemeOption(String color) {
    String _temp0 = intl.Intl.selectLogic(color, {
      'mint': 'М\'ята',
      'ocean': 'Океан',
      'passion': 'Пристрасть',
      'neon': 'Неон',
      'platinum': 'Платина',
      'merlot': 'Мерло',
      'lemon': 'Лимон',
      'lime': 'Лайм',
      'peacock': 'Павич',
      'azure': 'Лазур',
      'candy': 'Цукерка',
      'pumpkin': 'Гарбуз',
      'lapis': 'Лазурит',
      'scarlet': 'Червоний',
      'other': 'Колір',
    });
    return '$_temp0';
  }

  @override
  String get settingsScreenLanguageSelectLbl => 'Мова';

  @override
  String settingsScreenLuminosityOption(String target) {
    String _temp0 = intl.Intl.selectLogic(target, {
      'default': 'Системна за замовчуванням',
      'light': 'Світлий режим',
      'dark': 'Темний режим',
      'other': 'Немає',
    });
    return '$_temp0';
  }

  @override
  String settingsScreenSectionLbl(String target) {
    String _temp0 = intl.Intl.selectLogic(target, {
      'language': 'Мова програми',
      'luminosity': 'Яскравість програми',
      'color': 'Персоналізовані кольори',
      'other': 'Налаштування',
    });
    return '$_temp0';
  }

  @override
  String get settingsScreenTitle => 'Налаштування';

  @override
  String statsCalorie(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Калорій: $count',
      one: 'Калорія: 1',
      zero: 'Калорій: 0',
    );
    return '$_temp0';
  }

  @override
  String get warningEmptyData => 'Дані відсутні';

  @override
  String warningFormValidation(String target) {
    String _temp0 = intl.Intl.selectLogic(target, {
      'weight': 'Введіть коректну вагу',
      'height': 'Введіть коректний зріст',
      'age': 'Введіть коректний вік',
      'other': 'Некоректне введення',
    });
    return '$_temp0';
  }
}
