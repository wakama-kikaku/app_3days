import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_ja.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('ja'),
  ];

  /// No description provided for @appTitle.
  ///
  /// In en, this message translates to:
  /// **'3-Day Monk'**
  String get appTitle;

  /// No description provided for @goalLabel.
  ///
  /// In en, this message translates to:
  /// **'Goal'**
  String get goalLabel;

  /// No description provided for @continueButton.
  ///
  /// In en, this message translates to:
  /// **'Continued today!'**
  String get continueButton;

  /// No description provided for @calendarButton.
  ///
  /// In en, this message translates to:
  /// **'View Calendar'**
  String get calendarButton;

  /// No description provided for @shareButton.
  ///
  /// In en, this message translates to:
  /// **'Share Progress'**
  String get shareButton;

  /// No description provided for @shareMessage.
  ///
  /// In en, this message translates to:
  /// **'Continuing goal「{goal}」Lv.{level} - Day {day} #3日坊主'**
  String shareMessage(Object day, Object goal, Object level);

  /// No description provided for @setGoalPlaceholder.
  ///
  /// In en, this message translates to:
  /// **'Enter your goal'**
  String get setGoalPlaceholder;

  /// No description provided for @setGoalButton.
  ///
  /// In en, this message translates to:
  /// **'Set Goal'**
  String get setGoalButton;

  /// No description provided for @resetButton.
  ///
  /// In en, this message translates to:
  /// **'Reset'**
  String get resetButton;

  /// No description provided for @resetConfirmTitle.
  ///
  /// In en, this message translates to:
  /// **'Confirm'**
  String get resetConfirmTitle;

  /// No description provided for @resetConfirmMessage.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to reset?'**
  String get resetConfirmMessage;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @resetConfirm.
  ///
  /// In en, this message translates to:
  /// **'Reset'**
  String get resetConfirm;

  /// No description provided for @calendarTitle.
  ///
  /// In en, this message translates to:
  /// **'Calendar'**
  String get calendarTitle;

  /// No description provided for @confirmTitle.
  ///
  /// In en, this message translates to:
  /// **'Confirm'**
  String get confirmTitle;

  /// No description provided for @confirmReset.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to reset?'**
  String get confirmReset;

  /// No description provided for @doReset.
  ///
  /// In en, this message translates to:
  /// **'Reset'**
  String get doReset;

  /// No description provided for @yourGoal.
  ///
  /// In en, this message translates to:
  /// **'Goal: {goal}'**
  String yourGoal(Object goal);

  /// No description provided for @levelAndDay.
  ///
  /// In en, this message translates to:
  /// **'Lv {level} - Day {day}'**
  String levelAndDay(Object level, Object day);

  /// No description provided for @todayDone.
  ///
  /// In en, this message translates to:
  /// **'Continued today!'**
  String get todayDone;

  /// No description provided for @seeCalendar.
  ///
  /// In en, this message translates to:
  /// **'View Calendar'**
  String get seeCalendar;

  /// No description provided for @shareProgressButton.
  ///
  /// In en, this message translates to:
  /// **'Share Progress'**
  String get shareProgressButton;

  /// No description provided for @shareProgress.
  ///
  /// In en, this message translates to:
  /// **'Continuing goal \"{goal}\"! Lv.{level} - Day {day} #3DayMonk'**
  String shareProgress(Object day, Object goal, Object level);

  /// No description provided for @goalHint.
  ///
  /// In en, this message translates to:
  /// **'Enter your goal'**
  String get goalHint;

  /// No description provided for @setGoal.
  ///
  /// In en, this message translates to:
  /// **'Set Goal'**
  String get setGoal;

  /// No description provided for @reset.
  ///
  /// In en, this message translates to:
  /// **'Reset'**
  String get reset;

  /// No description provided for @autoResetMessage.
  ///
  /// In en, this message translates to:
  /// **'Progress has been reset due to a missed day.'**
  String get autoResetMessage;

  /// No description provided for @alreadyPressedToday.
  ///
  /// In en, this message translates to:
  /// **'You\'ve already logged your progress today!'**
  String get alreadyPressedToday;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'ja'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'ja':
      return AppLocalizationsJa();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
