// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Chinese (`zh`).
class AppLocalizationsZh extends AppLocalizations {
  AppLocalizationsZh([String locale = 'zh']) : super(locale);

  @override
  String appDialogTitle(String target) {
    String _temp0 = intl.Intl.selectLogic(target, {
      'legalWarning': '法律警告',
      'userGuide': '用户指南',
      'other': '不支持的语言',
    });
    return '$_temp0';
  }

  @override
  String get appError => '发生错误';

  @override
  String get appErrorDelete => '删除错误';

  @override
  String get appErrorForm => '表单错误。请检查您的输入';

  @override
  String get appErrorLoadingAssets => '错误：无法加载文件';

  @override
  String get appErrorLoadingContent => '数据加载错误';

  @override
  String appErrorReadFile(String context) {
    String _temp0 = intl.Intl.selectLogic(context, {
      'legalWarning': '错误：无法读取法律警告',
      'userGuide': '错误：无法读取用户指南',
      'other': '错误：无法读取文件',
    });
    return '$_temp0';
  }

  @override
  String appLanguageName(String target) {
    String _temp0 = intl.Intl.selectLogic(target, {
      'fr': '法语',
      'en': '英语',
      'es': '西班牙语',
      'fil': '菲律宾语',
      'hi': '印地语',
      'ja': '日语',
      'sv': '瑞典语',
      'uk': '乌克兰语',
      'zh': '中文',
      'sw': '斯瓦希里语',
      'other': '不支持的语言',
    });
    return '$_temp0';
  }

  @override
  String get appLoadingLbl => '正在初始化...';

  @override
  String get appRefreshDataLbl => '刷新数据';

  @override
  String get appSeeHistoryBtn => '查看历史记录';

  @override
  String appSuccessUpdate(String context) {
    String _temp0 = intl.Intl.selectLogic(context, {
      'profile': '个人资料已成功更新',
      'history': '历史记录已成功更新',
      'other': '更新成功',
    });
    return '$_temp0';
  }

  @override
  String appSummaryLbl(String duration) {
    String _temp0 = intl.Intl.selectLogic(duration, {
      'daily': '每日总结',
      'weekly': '每周总结',
      'other': '',
    });
    return '$_temp0';
  }

  @override
  String get appUserNameInpLbl => '用户名';

  @override
  String get appWarningEmptyData => '暂无数据';

  @override
  String appWarningFormValidation(String target) {
    String _temp0 = intl.Intl.selectLogic(target, {
      'weight': '请输入有效体重',
      'height': '请输入有效身高',
      'age': '请输入有效年龄',
      'comment': '请输入您的评论',
      'other': '无效输入',
    });
    return '$_temp0';
  }

  @override
  String btnSaveLbl(String context) {
    return '保存 $context';
  }

  @override
  String get btnSeeHistoryLbl => '查看历史记录';

  @override
  String get cameraScreenAnalysisInProgressLbl => '人工智能正在分析...';

  @override
  String cameraScreenBtn(String context) {
    String _temp0 = intl.Intl.selectLogic(context, {
      'flash': '切换闪光灯',
      'gallery': '从相册选择图片',
      'camera': '拍照',
      'other': '相机',
    });
    return '$_temp0';
  }

  @override
  String cameraScreenErrors(String type) {
    String _temp0 = intl.Intl.selectLogic(type, {
      'initialization': '相机初始化错误',
      'flash': '切换闪光灯时出错',
      'capture': '拍摄错误',
      'analysis': '分析错误',
      'permissions': '无法访问相机。请检查应用权限',
      'other': '相机错误',
    });
    return '$_temp0';
  }

  @override
  String get cameraScreenTitle => '食物分析';

  @override
  String get cameraScreenVisualHintLbl => '提示：光线充足时，一次针对一种食物';

  @override
  String dashboardScreenChartTypeOption(String type) {
    String _temp0 = intl.Intl.selectLogic(type, {
      'bars': '条形图',
      'lines': '折线图',
      'other': '图表',
    });
    return '$_temp0';
  }

  @override
  String dashboardScreenDailyObjectiveLbl(String target) {
    String _temp0 = intl.Intl.selectLogic(target, {
      'calories': '热量',
      'protein': '蛋白质',
      'totalFat': '脂肪',
      'totalCarbohydrate': '碳水化合物',
      'other': '营养素',
    });
    return '$_temp0';
  }

  @override
  String get dashboardScreenDailyObjectivesLbl => '今日目标';

  @override
  String get dashboardScreenNotEnoughDataLbl => '历史记录不足，无法显示图表';

  @override
  String get dashboardScreenSelectChartTypeLbl => '以条形图或折线图显示数据';

  @override
  String get dashboardScreenTitle => '仪表板';

  @override
  String get dashboardScreenWeeklySummaryLbl => '每周总结（卡路里）';

  @override
  String get errorForm => '表单错误。请检查您的输入';

  @override
  String get errorGlobal => '发生错误';

  @override
  String get errorLoadingAssets => '错误：无法加载文件';

  @override
  String get errorLoadingContent => '数据加载错误';

  @override
  String get errorReadUserGuide => '错误：无法读取用户指南';

  @override
  String get errorScreenDetailsLbl => '详情（在调试模式下可见）：';

  @override
  String errorScreenGoToBtn(String target) {
    String _temp0 = intl.Intl.selectLogic(target, {
      'comment': '提交评论',
      'home': '返回首页',
      'other': '',
    });
    return '$_temp0';
  }

  @override
  String get errorScreenTitle => '错误';

  @override
  String get feedbackScreenCommentHintLbl => '描述您的体验、报告错误或提出建议...';

  @override
  String get feedbackScreenCommentPaceholderLbl => '您的留言...';

  @override
  String get feedbackScreenEncouragingMessageLbl => '感谢您的反馈！帮助我改进 MacroVision';

  @override
  String get feedbackScreenNoEmailClientLbl => '无法打开邮件应用程序';

  @override
  String get feedbackScreenNoRecipientEmailLbl => '缺少反馈电子邮箱地址';

  @override
  String get feedbackScreenOpeningEmailLbl => '正在打开邮件应用程序';

  @override
  String feedbackScreenSendBtn(String state) {
    String _temp0 = intl.Intl.selectLogic(state, {
      'true': '正在发送...',
      'false': '发送反馈',
      'other': '',
    });
    return '$_temp0';
  }

  @override
  String get feedbackScreenSendToClipboard => '将我的留言发送到剪贴板';

  @override
  String get feedbackScreenSendTooltip => '发送反馈';

  @override
  String feedbackScreenSendedToClipboard(String context) {
    String _temp0 = intl.Intl.selectLogic(context, {
      'comment': '评论已复制到剪贴板',
      'email': '电子邮箱已复制到剪贴板',
      'other': '已复制到剪贴板',
    });
    return '$_temp0';
  }

  @override
  String get feedbackScreenSendingError => '发送反馈时出错';

  @override
  String get feedbackScreenTitle => '评论';

  @override
  String historyScreenDeleteSuccessLbl(String date) {
    return '$date 的记录已从历史记录中删除';
  }

  @override
  String get historyScreenTitle => '历史记录';

  @override
  String homeScreenDailyAnalisisLbl(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '分析 ($count)',
      one: '分析 (1)',
      zero: '无分析',
    );
    return '$_temp0';
  }

  @override
  String homeScreenDailySummaryMacroCardLbl(String field) {
    String _temp0 = intl.Intl.selectLogic(field, {
      'carbohydrate': '碳水化合物',
      'protein': '蛋白质',
      'fat': '脂肪',
      'other': '营养素',
    });
    return '$_temp0';
  }

  @override
  String homeScreenDailySummaryStatLbl(int stat) {
    return '/ $stat 克';
  }

  @override
  String get homeScreenStartAnalysisBtn => '分析餐食';

  @override
  String get homeScreenTitle => '首页';

  @override
  String get homeScreenWelcomeLbl => '欢迎使用 MacroVision';

  @override
  String initializationScreenDialogDefaultLbl(String target) {
    String _temp0 = intl.Intl.selectLogic(target, {
      'legalWarning': '正在加载法律警告...',
      'userGuide': '正在加载说明...',
      'other': '正在加载内容...',
    });
    return '$_temp0';
  }

  @override
  String get profileScreenActivityLevelInpLbl => '身体活动水平';

  @override
  String profileScreenActivityLevelOption(String target) {
    String _temp0 = intl.Intl.selectLogic(target, {
      'sedentary': '久坐（几乎不运动）',
      'lightly': '轻度活跃（每周 1-3 天运动）',
      'moderate': '中度活跃（每周 3-5 天运动）',
      'very': '非常活跃（每周 6-7 天运动）',
      'extra': '极度活跃（每天运动 2 次）',
      'other': '无',
    });
    return '$_temp0';
  }

  @override
  String get profileScreenGenderInpLbl => '性别';

  @override
  String profileScreenGenderOption(String target) {
    String _temp0 = intl.Intl.selectLogic(target, {
      'male': '男',
      'female': '女',
      'other': '其他',
    });
    return '$_temp0';
  }

  @override
  String get profileScreenGoalInpLbl => '主要目标';

  @override
  String profileScreenGoalOption(String target) {
    String _temp0 = intl.Intl.selectLogic(target, {
      'weightLoss': '减重',
      'muscleGain': '增肌',
      'maintain': '维持',
      'other': '无',
    });
    return '$_temp0';
  }

  @override
  String profileScreenInpLbl(String target, String unit) {
    String _temp0 = intl.Intl.selectLogic(target, {
      'weight': '体重 ($unit)',
      'height': '身高 ($unit)',
      'other': '年龄',
    });
    return '$_temp0';
  }

  @override
  String get profileScreenSaveBtn => '保存个人资料';

  @override
  String get profileScreenTitle => '个人资料';

  @override
  String get profileScreenUnitSystemSwitch => '公制 (kg, cm) 或 英制 (lb, in)';

  @override
  String profileScreenUnitOption(String unit) {
    String _temp0 = intl.Intl.selectLogic(unit, {
      'metric': '公制',
      'imperial': '英制',
      'other': '无',
    });
    return '$_temp0';
  }

  @override
  String get profileScreenUnitSystemLbl => '单位制';

  @override
  String resultScreenAnalysisOutputLbl(String context) {
    String _temp0 = intl.Intl.selectLogic(context, {
      'energy': '能量',
      'calories': '卡路里',
      'totalFat': '脂肪',
      'saturatedFat': '饱和脂肪',
      'transFat': '反式脂肪',
      'cholesterol': '胆固醇',
      'sodium': '钠',
      'potassium': '钾',
      'carbohydrate': '碳水化合物',
      'fiber': '膳食纤维',
      'sugar': '糖',
      'protein': '蛋白质',
      'other': '营养素',
    });
    return '$_temp0';
  }

  @override
  String resultScreenAnalysisSummaryLbl(String weight, String unit) {
    return '$weight $unit 的营养分析';
  }

  @override
  String resultScreenEstimatedWeightLbl(String weight, String unit) {
    return 'AI 估算的份量：$weight $unit';
  }

  @override
  String get resultScreenNewAnalysisBtn => '分析新照片';

  @override
  String resultScreenPortionLbl(String unit) {
    return '实际重量 ($unit)';
  }

  @override
  String get resultScreenRefineAnalysisBtn => '调整分析';

  @override
  String resultScreenRefineAnalysisLbl(String weight, String unit) {
    return '针对 $weight ($unit) 调整后的分析';
  }

  @override
  String resultScreenSwitchLbl(String unit) {
    String _temp0 = intl.Intl.selectLogic(unit, {
      'kJ': '显示为 kcal/cal',
      'cal': '显示为 kJ',
      'other': '切换单位',
    });
    return '$_temp0';
  }

  @override
  String get resultScreenTitle => '结果';

  @override
  String settingsScreenCustomThemeOption(String color) {
    String _temp0 = intl.Intl.selectLogic(color, {
      'mint': '薄荷',
      'ocean': '海洋',
      'passion': '激情',
      'neon': '霓虹',
      'platinum': '铂金',
      'merlot': '梅洛',
      'lemon': '柠檬',
      'lime': '青柠',
      'peacock': '孔雀蓝',
      'azure': '天蓝',
      'candy': '糖果',
      'pumpkin': '南瓜',
      'lapis': '青金石',
      'scarlet': '绯红',
      'other': '颜色',
    });
    return '$_temp0';
  }

  @override
  String get settingsScreenLanguageSelectLbl => '语言';

  @override
  String settingsScreenLuminosityOption(String target) {
    String _temp0 = intl.Intl.selectLogic(target, {
      'default': '系统默认',
      'light': '浅色模式',
      'dark': '深色模式',
      'other': '无',
    });
    return '$_temp0';
  }

  @override
  String settingsScreenSectionLbl(String target) {
    String _temp0 = intl.Intl.selectLogic(target, {
      'language': '应用语言',
      'luminosity': '应用亮度',
      'color': '自定义颜色',
      'other': '设置',
    });
    return '$_temp0';
  }

  @override
  String get settingsScreenTitle => '设置';

  @override
  String statsCalorie(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '卡路里：$count',
      one: '卡路里：1',
      zero: '卡路里：0',
    );
    return '$_temp0';
  }

  @override
  String get warningEmptyData => '暂无数据';

  @override
  String warningFormValidation(String target) {
    String _temp0 = intl.Intl.selectLogic(target, {
      'weight': '请输入有效体重',
      'height': '请输入有效身高',
      'age': '请输入有效年龄',
      'other': '无效输入',
    });
    return '$_temp0';
  }
}
