// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String appDialogTitle(String target) {
    String _temp0 = intl.Intl.selectLogic(target, {
      'legalWarning': 'Advertencia legal',
      'userGuide': 'Guía del usuario',
      'other': 'Idioma no admitido',
    });
    return '$_temp0';
  }

  @override
  String get appError => 'Se ha producido un error';

  @override
  String get appErrorDelete => 'Error de eliminación';

  @override
  String get appErrorForm =>
      'Error en el formulario. Por favor, verifique sus datos';

  @override
  String get appErrorLoadingAssets => 'Error: No se pudo cargar el archivo';

  @override
  String get appErrorLoadingContent => 'Error al cargar los datos';

  @override
  String appErrorReadFile(String context) {
    String _temp0 = intl.Intl.selectLogic(context, {
      'legalWarning': 'Error: No se pudo leer la advertencia legal',
      'userGuide': 'Error: No se pudo leer la guía del usuario',
      'other': 'Error: No se pudo leer el archivo',
    });
    return '$_temp0';
  }

  @override
  String appLanguageName(String target) {
    String _temp0 = intl.Intl.selectLogic(target, {
      'fr': 'Francés',
      'en': 'Inglés',
      'es': 'Español',
      'fil': 'Filipino',
      'hi': 'Hindi',
      'ja': 'Japonés',
      'sv': 'Sueco',
      'uk': 'Ucraniano',
      'zh': 'Chino',
      'sw': 'Suajili',
      'other': 'Idioma no admitido',
    });
    return '$_temp0';
  }

  @override
  String get appLoadingLbl => 'Inicializando...';

  @override
  String get appRefreshDataLbl => 'Actualizar datos';

  @override
  String get appSeeHistoryBtn => 'Ver historial';

  @override
  String appSuccessUpdate(String context) {
    String _temp0 = intl.Intl.selectLogic(context, {
      'profile': 'El perfil se ha actualizado correctamente',
      'history': 'El historial se ha actualizado correctamente',
      'other': 'Actualización exitosa',
    });
    return '$_temp0';
  }

  @override
  String appSummaryLbl(String duration) {
    String _temp0 = intl.Intl.selectLogic(duration, {
      'daily': 'Resumen diario',
      'weekly': 'Resumen semanal',
      'other': '',
    });
    return '$_temp0';
  }

  @override
  String get appUserNameInpLbl => 'Nombre de usuario';

  @override
  String get appWarningEmptyData => 'No hay datos';

  @override
  String appWarningFormValidation(String target) {
    String _temp0 = intl.Intl.selectLogic(target, {
      'weight': 'Ingrese un peso válido',
      'height': 'Ingrese una altura válida',
      'age': 'Ingrese una edad válida',
      'comment': 'Por favor, introduzca su comentario',
      'other': 'Entrada no válida',
    });
    return '$_temp0';
  }

  @override
  String btnSaveLbl(String context) {
    return 'Guardar $context';
  }

  @override
  String get btnSeeHistoryLbl => 'Ver historial';

  @override
  String get cameraScreenAnalysisInProgressLbl => 'Análisis de IA en curso...';

  @override
  String cameraScreenBtn(String context) {
    String _temp0 = intl.Intl.selectLogic(context, {
      'flash': 'Alternar flash',
      'gallery': 'Seleccionar imagen de la galería',
      'camera': 'Tomar una foto',
      'other': 'Cámara',
    });
    return '$_temp0';
  }

  @override
  String cameraScreenErrors(String type) {
    String _temp0 = intl.Intl.selectLogic(type, {
      'initialization': 'Error de inicialización de la cámara',
      'flash': 'Error al alternar el flash',
      'capture': 'Error de captura',
      'analysis': 'Error de análisis',
      'permissions':
          'No se puede acceder a la cámara. Compruebe los permisos de la aplicación',
      'other': 'Error de cámara',
    });
    return '$_temp0';
  }

  @override
  String get cameraScreenTitle => 'Análisis de alimentos';

  @override
  String get cameraScreenVisualHintLbl =>
      'Consejo: Apunte a un alimento a la vez, con buena luz';

  @override
  String dashboardScreenChartTypeOption(String type) {
    String _temp0 = intl.Intl.selectLogic(type, {
      'bars': 'Barras',
      'lines': 'Líneas',
      'other': 'Gráfico',
    });
    return '$_temp0';
  }

  @override
  String dashboardScreenDailyObjectiveLbl(String target) {
    String _temp0 = intl.Intl.selectLogic(target, {
      'calories': 'Calorías',
      'protein': 'Proteínas',
      'totalFat': 'Grasas',
      'totalCarbohydrate': 'Carbohidratos',
      'other': 'Nutrientes',
    });
    return '$_temp0';
  }

  @override
  String get dashboardScreenDailyObjectivesLbl => 'Objetivos del día';

  @override
  String get dashboardScreenNotEnoughDataLbl =>
      'Historial insuficiente para el gráfico';

  @override
  String get dashboardScreenSelectChartTypeLbl =>
      'Mostrar los datos en un gráfico de barras o de líneas';

  @override
  String get dashboardScreenTitle => 'Tablero';

  @override
  String get dashboardScreenWeeklySummaryLbl => 'Resumen semanal (Calorías)';

  @override
  String get errorForm =>
      'Error en el formulario. Por favor, verifique sus datos';

  @override
  String get errorGlobal => 'Se ha producido un error';

  @override
  String get errorLoadingAssets => 'Error: No se pudo cargar el archivo';

  @override
  String get errorLoadingContent => 'Error al cargar los datos';

  @override
  String get errorReadUserGuide => 'Error: No se pudo leer la guía del usuario';

  @override
  String get errorScreenDetailsLbl => 'Detalles (visibles en modo Depuración):';

  @override
  String errorScreenGoToBtn(String target) {
    String _temp0 = intl.Intl.selectLogic(target, {
      'comment': 'Enviar un comentario',
      'home': 'Volver al inicio',
      'other': '',
    });
    return '$_temp0';
  }

  @override
  String get errorScreenTitle => 'Error';

  @override
  String get feedbackScreenCommentHintLbl =>
      'Describa su experiencia, informe de un error o proponga una idea...';

  @override
  String get feedbackScreenCommentPaceholderLbl => 'Su mensaje...';

  @override
  String get feedbackScreenEncouragingMessageLbl =>
      '¡Aprecio sus comentarios! Ayúdeme a mejorar MacroVision';

  @override
  String get feedbackScreenNoEmailClientLbl =>
      'No se pudo abrir la aplicación de correo electrónico';

  @override
  String get feedbackScreenNoRecipientEmailLbl =>
      'Falta la dirección de correo electrónico para comentarios';

  @override
  String get feedbackScreenOpeningEmailLbl =>
      'Abriendo la aplicación de correo electrónico';

  @override
  String feedbackScreenSendBtn(String state) {
    String _temp0 = intl.Intl.selectLogic(state, {
      'true': 'Enviando...',
      'false': 'Enviar comentarios',
      'other': '',
    });
    return '$_temp0';
  }

  @override
  String get feedbackScreenSendToClipboard =>
      'Enviar mi mensaje al portapapeles';

  @override
  String get feedbackScreenSendTooltip => 'Enviar comentarios';

  @override
  String feedbackScreenSendedToClipboard(String context) {
    String _temp0 = intl.Intl.selectLogic(context, {
      'comment': 'Comentario enviado al portapapeles',
      'email': 'Dirección de correo enviada al portapapeles',
      'other': 'Enviado al portapapeles',
    });
    return '$_temp0';
  }

  @override
  String get feedbackScreenSendingError => 'Error al enviar los comentarios';

  @override
  String get feedbackScreenTitle => 'Comentario';

  @override
  String historyScreenDeleteSuccessLbl(String date) {
    return 'La entrada del $date se ha eliminado del historial';
  }

  @override
  String get historyScreenTitle => 'Historial';

  @override
  String homeScreenDailyAnalisisLbl(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Análisis ($count)',
      one: 'Análisis (1)',
      zero: 'Ningún análisis',
    );
    return '$_temp0';
  }

  @override
  String homeScreenDailySummaryMacroCardLbl(String field) {
    String _temp0 = intl.Intl.selectLogic(field, {
      'carbohydrate': 'Carb',
      'protein': 'Pro',
      'fat': 'Grasa',
      'other': 'Estad',
    });
    return '$_temp0';
  }

  @override
  String homeScreenDailySummaryStatLbl(int stat) {
    return 'de $stat g';
  }

  @override
  String get homeScreenStartAnalysisBtn => 'Analizar una comida';

  @override
  String get homeScreenTitle => 'Inicio';

  @override
  String get homeScreenWelcomeLbl => 'Bienvenido a MacroVision';

  @override
  String initializationScreenDialogDefaultLbl(String target) {
    String _temp0 = intl.Intl.selectLogic(target, {
      'legalWarning': 'Cargando advertencia legal...',
      'userGuide': 'Cargando instrucciones...',
      'other': 'Cargando contenido...',
    });
    return '$_temp0';
  }

  @override
  String get profileScreenActivityLevelInpLbl => 'Nivel de actividad física';

  @override
  String profileScreenActivityLevelOption(String target) {
    String _temp0 = intl.Intl.selectLogic(target, {
      'sedentary': 'Sedentario (poco o nada de ejercicio)',
      'lightly': 'Ligeramente activo (1-3 días/semana)',
      'moderate': 'Moderadamente activo (3-5 días/semana)',
      'very': 'Muy activo (6-7 días/semana)',
      'extra': 'Extremadamente activo (2 veces/día)',
      'other': 'Ninguno',
    });
    return '$_temp0';
  }

  @override
  String get profileScreenGenderInpLbl => 'Sexo';

  @override
  String profileScreenGenderOption(String target) {
    String _temp0 = intl.Intl.selectLogic(target, {
      'male': 'Hombre',
      'female': 'Mujer',
      'other': 'Otro',
    });
    return '$_temp0';
  }

  @override
  String get profileScreenGoalInpLbl => 'Objetivo principal';

  @override
  String profileScreenGoalOption(String target) {
    String _temp0 = intl.Intl.selectLogic(target, {
      'weightLoss': 'Pérdida de peso',
      'muscleGain': 'Ganancia muscular',
      'maintain': 'Mantenimiento',
      'other': 'Ninguno',
    });
    return '$_temp0';
  }

  @override
  String profileScreenInpLbl(String target, String unit) {
    String _temp0 = intl.Intl.selectLogic(target, {
      'weight': 'Peso ($unit)',
      'height': 'Altura ($unit)',
      'other': 'Edad',
    });
    return '$_temp0';
  }

  @override
  String get profileScreenSaveBtn => 'Guardar perfil';

  @override
  String get profileScreenTitle => 'Perfil';

  @override
  String get profileScreenUnitSystemSwitch =>
      'Métrico (kg, cm) o Imperial (lb, in)';

  @override
  String profileScreenUnitOption(String unit) {
    String _temp0 = intl.Intl.selectLogic(unit, {
      'metric': 'Métrico',
      'imperial': 'Imperial',
      'other': 'Ninguno',
    });
    return '$_temp0';
  }

  @override
  String get profileScreenUnitSystemLbl => 'Sistema de unidades';

  @override
  String resultScreenAnalysisOutputLbl(String context) {
    String _temp0 = intl.Intl.selectLogic(context, {
      'energy': 'Energía',
      'calories': 'Calorías',
      'totalFat': 'Grasas',
      'saturatedFat': 'Saturadas',
      'transFat': 'Trans',
      'cholesterol': 'Colesterol',
      'sodium': 'Sodio',
      'potassium': 'Potasio',
      'carbohydrate': 'Carbohidratos',
      'fiber': 'Fibra',
      'sugar': 'Azúcares',
      'protein': 'Proteínas',
      'other': 'Nutrientes',
    });
    return '$_temp0';
  }

  @override
  String resultScreenAnalysisSummaryLbl(String weight, String unit) {
    return 'Análisis nutricional para $weight $unit';
  }

  @override
  String resultScreenEstimatedWeightLbl(String weight, String unit) {
    return 'Porción estimada por la IA: $weight $unit';
  }

  @override
  String get resultScreenNewAnalysisBtn => 'Analizar una nueva foto';

  @override
  String resultScreenPortionLbl(String unit) {
    return 'Peso real ($unit)';
  }

  @override
  String get resultScreenRefineAnalysisBtn => 'Ajustar análisis';

  @override
  String resultScreenRefineAnalysisLbl(String weight, String unit) {
    return 'Análisis ajustado para $weight ($unit)';
  }

  @override
  String resultScreenSwitchLbl(String unit) {
    String _temp0 = intl.Intl.selectLogic(unit, {
      'kJ': 'Mostrar en kcal/cal',
      'cal': 'Mostrar en kJ',
      'other': 'cambiar de unidad',
    });
    return '$_temp0';
  }

  @override
  String get resultScreenTitle => 'Resultado';

  @override
  String settingsScreenCustomThemeOption(String color) {
    String _temp0 = intl.Intl.selectLogic(color, {
      'mint': 'Menta',
      'ocean': 'Océano',
      'passion': 'Pasión',
      'neon': 'Neón',
      'platinum': 'Platino',
      'merlot': 'Merlot',
      'lemon': 'Limón',
      'lime': 'Lima',
      'peacock': 'Pavo real',
      'azure': 'Azur',
      'candy': 'Caramelo',
      'pumpkin': 'Calabaza',
      'lapis': 'Lapis',
      'scarlet': 'Escarlata',
      'other': 'Color',
    });
    return '$_temp0';
  }

  @override
  String get settingsScreenLanguageSelectLbl => 'Idioma';

  @override
  String settingsScreenLuminosityOption(String target) {
    String _temp0 = intl.Intl.selectLogic(target, {
      'default': 'Predeterminado del sistema',
      'light': 'Modo claro',
      'dark': 'Modo oscuro',
      'other': 'Ninguno',
    });
    return '$_temp0';
  }

  @override
  String settingsScreenSectionLbl(String target) {
    String _temp0 = intl.Intl.selectLogic(target, {
      'language': 'Idioma de la aplicación',
      'luminosity': 'Luminosidad de la aplicación',
      'color': 'Colores personalizados',
      'other': 'Configuración',
    });
    return '$_temp0';
  }

  @override
  String get settingsScreenTitle => 'Configuración';

  @override
  String statsCalorie(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Calorías: $count',
      one: 'Caloría: 1',
      zero: 'Caloría: 0',
    );
    return '$_temp0';
  }

  @override
  String get warningEmptyData => 'No hay datos';

  @override
  String warningFormValidation(String target) {
    String _temp0 = intl.Intl.selectLogic(target, {
      'weight': 'Ingrese un peso válido',
      'height': 'Ingrese una altura válida',
      'age': 'Ingrese una edad válida',
      'other': 'Entrada no válida',
    });
    return '$_temp0';
  }
}
