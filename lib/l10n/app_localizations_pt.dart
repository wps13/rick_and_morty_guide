// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Portuguese (`pt`).
class AppLocalizationsPt extends AppLocalizations {
  AppLocalizationsPt([String locale = 'pt']) : super(locale);

  @override
  String get detailScreenTitle => 'Detalhes do Personagem';

  @override
  String get configScreenTitle => 'Configurações';

  @override
  String get darkTheme => 'Tema Escuro';

  @override
  String get errorLoadingCharacter => 'Erro ao carregar personagem';

  @override
  String get errorLoadingCharacters =>
      'Ocorreu um erro ao carregar os personagens.';

  @override
  String get retryButton => 'Tentar novamente';

  @override
  String get statusAlive => 'Vivo';

  @override
  String get statusDead => 'Morto';

  @override
  String get statusUnknown => 'Desconhecido';

  @override
  String get genderMale => 'Masculino';

  @override
  String get genderFemale => 'Feminino';

  @override
  String get genderGenderless => 'Sem gênero';

  @override
  String get genderUnknown => 'Desconhecido';

  @override
  String get personalInfoTitle => 'Informações Pessoais';

  @override
  String get originLocationTitle => 'Origem e Localização';

  @override
  String get episodesTitle => 'Episódios';

  @override
  String get speciesLabel => 'Espécie';

  @override
  String get genderLabel => 'Gênero';

  @override
  String get originLabel => 'Origem';

  @override
  String get currentLocationLabel => 'Local Atual';

  @override
  String get episodesLabel => 'Episódios';

  @override
  String get statusLabel => 'STATUS';
}
