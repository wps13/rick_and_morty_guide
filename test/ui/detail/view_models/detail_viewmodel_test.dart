import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:rick_and_morty_guide/data/repositories/characters_repository.dart';
import 'package:rick_and_morty_guide/domain/models/character.dart';
import 'package:rick_and_morty_guide/ui/detail/view_models/detail_viewmodel.dart';
import 'package:rick_and_morty_guide/utils/result.dart';

class MockCharactersRepository extends Mock implements CharactersRepository {}

void main() {
  late DetailViewModel viewModel;
  late MockCharactersRepository mockRepository;

  setUp(() {
    mockRepository = MockCharactersRepository();
    viewModel = DetailViewModel(charactersRepository: mockRepository);
  });

  group('DetailViewModel', () {
    test('initial state is correct', () {
      expect(viewModel.character, isNull);
      expect(viewModel.isLoading, false);
      expect(viewModel.hasError, false);
    });

    test('getCharacter success updates character', () async {
      const character = Character(
        id: 1,
        name: 'Rick',
        status: Status.alive,
        species: 'Human',
        gender: Gender.male,
        imageUrl: 'image',
        locationName: 'Earth',
        originName: 'Earth',
        episodesCount: 1,
      );

      when(
        () => mockRepository.getCharacterById(1),
      ).thenAnswer((_) async => Result.ok(character));

      await viewModel.getCharacter(1);

      expect(viewModel.character, character);
      expect(viewModel.hasError, false);
      expect(viewModel.isLoading, false);
    });

    test('getCharacter failure updates hasError', () async {
      when(
        () => mockRepository.getCharacterById(1),
      ).thenAnswer((_) async => Result.error(Exception('Error')));

      await viewModel.getCharacter(1);

      expect(viewModel.character, isNull);
      expect(viewModel.hasError, true);
      expect(viewModel.isLoading, false);
    });
  });
}
