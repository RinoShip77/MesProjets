// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Japanese (`ja`).
class AppLocalizationsJa extends AppLocalizations {
  AppLocalizationsJa([String locale = 'ja']) : super(locale);

  @override
  String appDialogTitle(String target) {
    String _temp0 = intl.Intl.selectLogic(target, {
      'legalWarning': '法的警告',
      'userGuide': 'ユーザーガイド',
      'other': 'サポートされていない言語',
    });
    return '$_temp0';
  }

  @override
  String get appError => 'エラーが発生しました';

  @override
  String get appErrorDelete => '削除エラー';

  @override
  String get appErrorForm => 'フォームにエラーがあります。入力内容を確認してください';

  @override
  String get appErrorLoadingAssets => 'エラー：ファイルを読み込めませんでした';

  @override
  String get appErrorLoadingContent => 'データの読み込みエラー';

  @override
  String appErrorReadFile(String context) {
    String _temp0 = intl.Intl.selectLogic(context, {
      'legalWarning': 'エラー：法的警告を読み込めませんでした',
      'userGuide': 'エラー：ユーザーガイドを読み込めませんでした',
      'other': 'エラー：ファイルを読み込めませんでした',
    });
    return '$_temp0';
  }

  @override
  String appLanguageName(String target) {
    String _temp0 = intl.Intl.selectLogic(target, {
      'fr': 'フランス語',
      'en': '英語',
      'es': 'スペイン語',
      'fil': 'フィリピン語',
      'hi': 'ヒンディー語',
      'ja': '日本語',
      'sv': 'スウェーデン語',
      'uk': 'ウクライナ語',
      'zh': '中国語',
      'sw': 'スワヒリ語',
      'other': 'サポートされていない言語',
    });
    return '$_temp0';
  }

  @override
  String get appLoadingLbl => '初期化中...';

  @override
  String get appRefreshDataLbl => 'データを更新';

  @override
  String get appSeeHistoryBtn => '履歴を見る';

  @override
  String appSuccessUpdate(String context) {
    String _temp0 = intl.Intl.selectLogic(context, {
      'profile': 'プロファイルが正常に更新されました',
      'history': '履歴が正常に更新されました',
      'other': '更新に成功しました',
    });
    return '$_temp0';
  }

  @override
  String appSummaryLbl(String duration) {
    String _temp0 = intl.Intl.selectLogic(duration, {
      'daily': '日次サマリー',
      'weekly': '週次サマリー',
      'other': '',
    });
    return '$_temp0';
  }

  @override
  String get appUserNameInpLbl => 'ユーザー名';

  @override
  String get appWarningEmptyData => 'データがありません';

  @override
  String appWarningFormValidation(String target) {
    String _temp0 = intl.Intl.selectLogic(target, {
      'weight': '有効な体重を入力してください',
      'height': '有効な身長を入力してください',
      'age': '有効な年齢を入力してください',
      'comment': 'コメントを入力してください',
      'other': '無効な入力',
    });
    return '$_temp0';
  }

  @override
  String btnSaveLbl(String context) {
    return '$contextを保存';
  }

  @override
  String get btnSeeHistoryLbl => '履歴を見る';

  @override
  String get cameraScreenAnalysisInProgressLbl => 'AIによる分析中...';

  @override
  String cameraScreenBtn(String context) {
    String _temp0 = intl.Intl.selectLogic(context, {
      'flash': 'フラッシュの切り替え',
      'gallery': 'ギャラリーから画像を選択',
      'camera': '写真を撮る',
      'other': 'カメラ',
    });
    return '$_temp0';
  }

  @override
  String get cameraScreenConfirmFactsLbl => 'Confirmer les valeurs';

  @override
  String cameraScreenErrors(String type) {
    String _temp0 = intl.Intl.selectLogic(type, {
      'initialization': 'カメラの初期化エラー',
      'flash': 'フラッシュ切り替え時のエラー',
      'capture': 'キャプチャエラー',
      'analysis': '分析エラー',
      'permissions': 'カメラにアクセスできません。アプリの権限を確認してください',
      'other': 'カメラエラー',
    });
    return '$_temp0';
  }

  @override
  String get cameraScreenTitle => '食品分析';

  @override
  String get cameraScreenVisualHintLbl => 'ヒント：明るい場所で、一度に一つの食品をターゲットにしてください';

  @override
  String dashboardScreenChartTypeOption(String type) {
    String _temp0 = intl.Intl.selectLogic(type, {
      'bars': '棒グラフ',
      'lines': '折れ線グラフ',
      'other': 'グラフ',
    });
    return '$_temp0';
  }

  @override
  String dashboardScreenDailyObjectiveLbl(String target) {
    String _temp0 = intl.Intl.selectLogic(target, {
      'calories': 'カロリー',
      'protein': 'タンパク質',
      'totalFat': '脂質',
      'totalCarbohydrate': '炭水化物',
      'other': '栄養素',
    });
    return '$_temp0';
  }

  @override
  String get dashboardScreenDailyObjectivesLbl => '今日の目標';

  @override
  String get dashboardScreenNotEnoughDataLbl => 'グラフを表示するための履歴が不足しています';

  @override
  String get dashboardScreenSelectChartTypeLbl => 'データを棒グラフまたは折れ線グラフで表示';

  @override
  String get dashboardScreenTitle => 'ダッシュボード';

  @override
  String get dashboardScreenWeeklySummaryLbl => '週次サマリー（カロリー）';

  @override
  String get errorForm => 'フォームにエラーがあります。入力内容を確認してください';

  @override
  String get errorGlobal => 'エラーが発生しました';

  @override
  String get errorLoadingAssets => 'エラー：ファイルを読み込めませんでした';

  @override
  String get errorLoadingContent => 'データの読み込みエラー';

  @override
  String get errorReadUserGuide => 'エラー：ユーザーガイドを読み込めませんでした';

  @override
  String get errorScreenDetailsLbl => '詳細（デバッグモードで表示）：';

  @override
  String errorScreenGoToBtn(String target) {
    String _temp0 = intl.Intl.selectLogic(target, {
      'comment': 'コメントを送信',
      'home': 'ホームに戻る',
      'other': '',
    });
    return '$_temp0';
  }

  @override
  String get errorScreenTitle => 'エラー';

  @override
  String get feedbackScreenCommentHintLbl =>
      '体験したこと、バグの報告、アイデアの提案などを入力してください...';

  @override
  String get feedbackScreenCommentPaceholderLbl => 'メッセージ...';

  @override
  String get feedbackScreenEncouragingMessageLbl =>
      'フィードバックありがとうございます！MacroVisionの改善にご協力ください';

  @override
  String get feedbackScreenNoEmailClientLbl => 'メールアプリを開けませんでした';

  @override
  String get feedbackScreenNoRecipientEmailLbl => 'フィードバック用メールアドレスが見つかりません';

  @override
  String get feedbackScreenOpeningEmailLbl => 'メールアプリを起動しています';

  @override
  String feedbackScreenSendBtn(String state) {
    String _temp0 = intl.Intl.selectLogic(state, {
      'true': '送信中...',
      'false': 'フィードバックを送信',
      'other': '',
    });
    return '$_temp0';
  }

  @override
  String get feedbackScreenSendToClipboard => 'メッセージをクリップボードにコピー';

  @override
  String get feedbackScreenSendTooltip => 'フィードバックを送信';

  @override
  String feedbackScreenSendedToClipboard(String context) {
    String _temp0 = intl.Intl.selectLogic(context, {
      'comment': 'コメントをクリップボードにコピーしました',
      'email': 'メールアドレスをクリップボードにコピーしました',
      'other': 'クリップボードにコピーしました',
    });
    return '$_temp0';
  }

  @override
  String get feedbackScreenSendingError => 'フィードバックの送信中にエラーが発生しました';

  @override
  String get feedbackScreenTitle => 'コメント';

  @override
  String historyScreenDeleteSuccessLbl(String date) {
    return '$dateの入力が履歴から削除されました';
  }

  @override
  String get historyScreenTitle => '履歴';

  @override
  String homeScreenDailyAnalisisLbl(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '分析 ($count)',
      one: '分析 (1)',
      zero: '分析なし',
    );
    return '$_temp0';
  }

  @override
  String homeScreenDailySummaryMacroCardLbl(String field) {
    String _temp0 = intl.Intl.selectLogic(field, {
      'carbohydrate': '炭水化物',
      'protein': 'タンパク質',
      'fat': '脂質',
      'other': '栄養素',
    });
    return '$_temp0';
  }

  @override
  String homeScreenDailySummaryStatLbl(int stat) {
    return '$stat g中';
  }

  @override
  String get homeScreenStartAnalysisBtn => '食事を分析する';

  @override
  String get homeScreenTitle => 'ホーム';

  @override
  String get homeScreenWelcomeLbl => 'MacroVisionへようこそ';

  @override
  String initializationScreenDialogDefaultLbl(String target) {
    String _temp0 = intl.Intl.selectLogic(target, {
      'legalWarning': '法的警告を読み込んでいます...',
      'userGuide': '説明書を読み込んでいます...',
      'other': 'コンテンツを読み込んでいます...',
    });
    return '$_temp0';
  }

  @override
  String get profileScreenActivityLevelInpLbl => '身体活動レベル';

  @override
  String profileScreenActivityLevelOption(String target) {
    String _temp0 = intl.Intl.selectLogic(target, {
      'sedentary': '座りっぱなし（運動不足）',
      'lightly': '軽い活動（週1-3日）',
      'moderate': '適度な活動（週3-5日）',
      'very': '高い活動（週6-7日）',
      'extra': '非常に高い活動（1日2回以上）',
      'other': 'なし',
    });
    return '$_temp0';
  }

  @override
  String get profileScreenGenderInpLbl => '性別';

  @override
  String profileScreenGenderOption(String target) {
    String _temp0 = intl.Intl.selectLogic(target, {
      'male': '男性',
      'female': '女性',
      'other': 'その他',
    });
    return '$_temp0';
  }

  @override
  String get profileScreenGoalInpLbl => '主な目標';

  @override
  String profileScreenGoalOption(String target) {
    String _temp0 = intl.Intl.selectLogic(target, {
      'weightLoss': '減量',
      'muscleGain': '筋肉増量',
      'maintain': '維持',
      'other': 'なし',
    });
    return '$_temp0';
  }

  @override
  String profileScreenInpLbl(String target, String unit) {
    String _temp0 = intl.Intl.selectLogic(target, {
      'weight': '体重 ($unit)',
      'height': '身長 ($unit)',
      'other': '年齢',
    });
    return '$_temp0';
  }

  @override
  String get profileScreenSaveBtn => 'プロファイルを保存';

  @override
  String get profileScreenTitle => 'プロファイル';

  @override
  String get profileScreenUnitSystemSwitch =>
      'メートル法 (kg, cm) または ヤード・ポンド法 (lb, in)';

  @override
  String profileScreenUnitOption(String unit) {
    String _temp0 = intl.Intl.selectLogic(unit, {
      'metric': 'メートル法',
      'imperial': 'ヤード・ポンド法',
      'other': 'なし',
    });
    return '$_temp0';
  }

  @override
  String get profileScreenUnitSystemLbl => '単位系';

  @override
  String resultScreenAnalysisOutputLbl(String context) {
    String _temp0 = intl.Intl.selectLogic(context, {
      'energy': 'エネルギー',
      'calories': 'カロリー',
      'totalFat': '脂質',
      'saturatedFat': '飽和脂肪酸',
      'transFat': 'トランス脂肪酸',
      'cholesterol': 'コレステロール',
      'sodium': 'ナトリウム',
      'potassium': 'カリウム',
      'carbohydrate': '炭水化物',
      'fiber': '食物繊維',
      'sugar': '糖類',
      'protein': 'タンパク質',
      'other': '栄養素',
    });
    return '$_temp0';
  }

  @override
  String resultScreenAnalysisSummaryLbl(String weight, String unit) {
    return '$weight $unitあたりの栄養分析';
  }

  @override
  String resultScreenEstimatedWeightLbl(String weight, String unit) {
    return 'AIによる推定分量：$weight $unit';
  }

  @override
  String get resultScreenNewAnalysisBtn => '新しい写真を分析する';

  @override
  String resultScreenPortionLbl(String unit) {
    return '実際の重量 ($unit)';
  }

  @override
  String get resultScreenRefineAnalysisBtn => '分析を調整する';

  @override
  String resultScreenRefineAnalysisLbl(String weight, String unit) {
    return '$weight ($unit)に合わせて調整された分析';
  }

  @override
  String resultScreenSwitchLbl(String unit) {
    String _temp0 = intl.Intl.selectLogic(unit, {
      'kJ': 'kcal/calで表示',
      'cal': 'kJで表示',
      'other': '単位を切り替え',
    });
    return '$_temp0';
  }

  @override
  String get resultScreenTitle => '結果';

  @override
  String settingsScreenCustomThemeOption(String color) {
    String _temp0 = intl.Intl.selectLogic(color, {
      'mint': 'ミント',
      'ocean': 'オーシャン',
      'passion': 'パッション',
      'neon': 'ネオン',
      'platinum': 'プラチナ',
      'merlot': 'メルロー',
      'lemon': 'レモン',
      'lime': 'ライム',
      'peacock': 'ピーコック',
      'azure': 'アズール',
      'candy': 'キャンディ',
      'pumpkin': 'パンプキン',
      'lapis': 'ラピス',
      'scarlet': 'スカーレット',
      'other': 'カラー',
    });
    return '$_temp0';
  }

  @override
  String get settingsScreenLanguageSelectLbl => '言語';

  @override
  String settingsScreenLuminosityOption(String target) {
    String _temp0 = intl.Intl.selectLogic(target, {
      'default': 'システム設定に従う',
      'light': 'ライトモード',
      'dark': 'ダークモード',
      'other': 'なし',
    });
    return '$_temp0';
  }

  @override
  String settingsScreenSectionLbl(String target) {
    String _temp0 = intl.Intl.selectLogic(target, {
      'language': 'アプリの言語',
      'luminosity': 'アプリの輝度',
      'color': 'カスタムカラー',
      'other': '設定',
    });
    return '$_temp0';
  }

  @override
  String get settingsScreenTitle => '設定';

  @override
  String statsCalorie(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'カロリー：$count',
      one: 'カロリー：1',
      zero: 'カロリー：0',
    );
    return '$_temp0';
  }

  @override
  String get warningEmptyData => 'データがありません';

  @override
  String warningFormValidation(String target) {
    String _temp0 = intl.Intl.selectLogic(target, {
      'weight': '有効な体重を入力してください',
      'height': '有効な身長を入力してください',
      'age': '有効な年齢を入力してください',
      'other': '無効な入力',
    });
    return '$_temp0';
  }
}
