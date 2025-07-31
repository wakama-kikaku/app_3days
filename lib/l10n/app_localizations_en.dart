// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => '3-Day Monk';

  @override
  String get goalLabel => 'Goal';

  @override
  String get continueButton => 'Continued today!';

  @override
  String get calendarButton => 'View Calendar';

  @override
  String get shareButton => 'Share Progress';

  @override
  String shareMessage(Object day, Object goal, Object level) {
    return 'Continuing goal \"$goal\"! Lv.$level - Day $day #3DayMonk';
  }

  @override
  String get setGoalPlaceholder => 'Enter your goal';

  @override
  String get setGoalButton => 'Set Goal';

  @override
  String get resetButton => 'Reset';

  @override
  String get resetConfirmTitle => 'Confirm';

  @override
  String get resetConfirmMessage => 'Are you sure you want to reset?';

  @override
  String get cancel => 'Cancel';

  @override
  String get resetConfirm => 'Reset';

  @override
  String get calendarTitle => 'Calendar';

  @override
  String get confirmTitle => 'Confirm';

  @override
  String get confirmReset => 'Are you sure you want to reset?';

  @override
  String get doReset => 'Reset';

  @override
  String yourGoal(Object goal) {
    return 'Goal: $goal';
  }

  @override
  String levelAndDay(Object level, Object day) {
    return 'Lv $level - Day $day';
  }

  @override
  String get todayDone => 'Continued today!';

  @override
  String get seeCalendar => 'View Calendar';

  @override
  String get shareProgressButton => 'Share Progress';

  @override
  String shareProgress(Object day, Object goal, Object level) {
    return 'Continuing goal \"$goal\"! Lv.$level - Day $day #3DayMonk';
  }

  @override
  String get goalHint => 'Enter your goal';

  @override
  String get setGoal => 'Set Goal';

  @override
  String get reset => 'Reset';

  @override
  String get autoResetMessage => 'Progress has been reset due to a missed day.';

  @override
  String get alreadyPressedToday =>
      'You\'ve already logged your progress today!';
}
