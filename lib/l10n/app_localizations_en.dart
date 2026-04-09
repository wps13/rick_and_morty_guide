// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get detailScreenTitle => 'Character Details';

  @override
  String get configScreenTitle => 'Settings';

  @override
  String get darkTheme => 'Dark Theme';

  @override
  String get errorLoadingCharacter => 'Error loading character';

  @override
  String get errorLoadingCharacters =>
      'An error occurred while loading characters.';

  @override
  String get retryButton => 'Try again';

  @override
  String get statusAlive => 'Alive';

  @override
  String get statusDead => 'Dead';

  @override
  String get statusUnknown => 'Unknown';

  @override
  String get genderMale => 'Male';

  @override
  String get genderFemale => 'Female';

  @override
  String get genderGenderless => 'Genderless';

  @override
  String get genderUnknown => 'Unknown';

  @override
  String get personalInfoTitle => 'Personal Information';

  @override
  String get originLocationTitle => 'Origin and Location';

  @override
  String get episodesTitle => 'Episodes';

  @override
  String get speciesLabel => 'Species';

  @override
  String get genderLabel => 'Gender';

  @override
  String get originLabel => 'Origin';

  @override
  String get currentLocationLabel => 'Current Location';

  @override
  String get episodesLabel => 'Episodes';

  @override
  String get statusLabel => 'STATUS';
}
