import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_pt.dart';

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

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
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
    Locale('pt'),
  ];

  /// Title for the character detail screen
  ///
  /// In pt, this message translates to:
  /// **'Detalhes do Personagem'**
  String get detailScreenTitle;

  /// Title for the configuration screen
  ///
  /// In pt, this message translates to:
  /// **'Configurações'**
  String get configScreenTitle;

  /// Label for dark theme toggle
  ///
  /// In pt, this message translates to:
  /// **'Tema Escuro'**
  String get darkTheme;

  /// Error message when character fails to load
  ///
  /// In pt, this message translates to:
  /// **'Erro ao carregar personagem'**
  String get errorLoadingCharacter;

  /// Error message when characters list fails to load
  ///
  /// In pt, this message translates to:
  /// **'Ocorreu um erro ao carregar os personagens.'**
  String get errorLoadingCharacters;

  /// Button label to retry loading
  ///
  /// In pt, this message translates to:
  /// **'Tentar novamente'**
  String get retryButton;

  /// Status label for alive characters
  ///
  /// In pt, this message translates to:
  /// **'Vivo'**
  String get statusAlive;

  /// Status label for dead characters
  ///
  /// In pt, this message translates to:
  /// **'Morto'**
  String get statusDead;

  /// Status label for unknown status
  ///
  /// In pt, this message translates to:
  /// **'Desconhecido'**
  String get statusUnknown;

  /// Gender label for male
  ///
  /// In pt, this message translates to:
  /// **'Masculino'**
  String get genderMale;

  /// Gender label for female
  ///
  /// In pt, this message translates to:
  /// **'Feminino'**
  String get genderFemale;

  /// Gender label for genderless
  ///
  /// In pt, this message translates to:
  /// **'Sem gênero'**
  String get genderGenderless;

  /// Gender label for unknown gender
  ///
  /// In pt, this message translates to:
  /// **'Desconhecido'**
  String get genderUnknown;

  /// Title for personal information card
  ///
  /// In pt, this message translates to:
  /// **'Informações Pessoais'**
  String get personalInfoTitle;

  /// Title for origin and location card
  ///
  /// In pt, this message translates to:
  /// **'Origem e Localização'**
  String get originLocationTitle;

  /// Title for episodes card
  ///
  /// In pt, this message translates to:
  /// **'Episódios'**
  String get episodesTitle;

  /// Label for species field
  ///
  /// In pt, this message translates to:
  /// **'Espécie'**
  String get speciesLabel;

  /// Label for gender field
  ///
  /// In pt, this message translates to:
  /// **'Gênero'**
  String get genderLabel;

  /// Label for origin field
  ///
  /// In pt, this message translates to:
  /// **'Origem'**
  String get originLabel;

  /// Label for current location field
  ///
  /// In pt, this message translates to:
  /// **'Local Atual'**
  String get currentLocationLabel;

  /// Label for episodes field
  ///
  /// In pt, this message translates to:
  /// **'Episódios'**
  String get episodesLabel;

  /// Label prefix for status display
  ///
  /// In pt, this message translates to:
  /// **'STATUS'**
  String get statusLabel;
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
      <String>['en', 'pt'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'pt':
      return AppLocalizationsPt();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
