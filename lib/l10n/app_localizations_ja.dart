// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Japanese (`ja`).
class AppLocalizationsJa extends AppLocalizations {
  AppLocalizationsJa([String locale = 'ja']) : super(locale);

  @override
  String get appTitle => '3日坊主';

  @override
  String get goalLabel => '目標';

  @override
  String get continueButton => '今日も続けた！';

  @override
  String get calendarButton => 'カレンダーを見る';

  @override
  String get shareButton => '進捗を共有する';

  @override
  String shareMessage(Object day, Object goal, Object level) {
    return '目標「$goal」継続中！Lv.$level - Day $day #3日坊主';
  }

  @override
  String get setGoalPlaceholder => '目標を入力してください';

  @override
  String get setGoalButton => '目標を掲げる';

  @override
  String get resetButton => 'リセット';

  @override
  String get resetConfirmTitle => '確認';

  @override
  String get resetConfirmMessage => '本当にリセットしますか？';

  @override
  String get cancel => 'キャンセル';

  @override
  String get resetConfirm => 'リセットする';

  @override
  String get calendarTitle => 'カレンダー';

  @override
  String get confirmTitle => '確認';

  @override
  String get confirmReset => '本当にリセットしますか？';

  @override
  String get doReset => 'リセットする';

  @override
  String yourGoal(Object goal) {
    return '目標: $goal';
  }

  @override
  String levelAndDay(Object level, Object day) {
    return 'Lv $level - Day $day';
  }

  @override
  String get todayDone => '今日も続けた！';

  @override
  String get seeCalendar => 'カレンダーを見る';

  @override
  String get shareProgressButton => '進捗を共有する';

  @override
  String shareProgress(Object day, Object goal, Object level) {
    return '目標「$goal」継続中！Lv.$level - Day $day #3日坊主';
  }

  @override
  String get goalHint => '目標を入力してください';

  @override
  String get setGoal => '目標を掲げる';

  @override
  String get reset => 'リセット';
}
