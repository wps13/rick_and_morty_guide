import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:rick_and_morty_guide/data/repositories/characters_repository.dart';
import 'package:rick_and_morty_guide/domain/models/character.dart';
import 'package:rick_and_morty_guide/ui/home/view_models/home_viewmodel.dart';
import 'package:rick_and_morty_guide/utils/result.dart';

class MockCharactersRepository extends Mock implements CharactersRepository {}

void main() {
  late HomeViewModel viewModel;
  late MockCharactersRepository mockRepository;

  setUp(() {
    mockRepository = MockCharactersRepository();
    viewModel = HomeViewModel(charactersRepository: mockRepository);
  });

  group('HomeViewModel', () {
    test('initial state is correct', () {
      expect(viewModel.characters, isEmpty);
      expect(viewModel.isLoading, false);
      expect(viewModel.hasError, false);
      expect(viewModel.selectedStatusFilter, 'Todos');
      expect(viewModel.page, 1);
    });

    group('getAllCharacters', () {
      test(
        'should update characters list and increment page when success',
        () async {
          final characters = [
            const Character(
              id: 1,
              name: 'Rick',
              status: Status.alive,
              species: 'Human',
              gender: Gender.male,
              imageUrl: 'image',
              locationName: 'Earth',
              originName: 'Earth',
              episodesCount: 1,
            ),
          ];

          when(
            () => mockRepository.getCharacters(
              page: 1,
              statusFilter: null,
              nameQuery: null,
            ),
          ).thenAnswer((_) async => Result.ok(characters));

          await viewModel.getAllCharacters();

          expect(viewModel.characters, characters);
          expect(viewModel.isLoading, false);
          expect(viewModel.hasError, false);
          expect(viewModel.page, 2);
          expect(viewModel.hasReachedEnd, true); // < 20
        },
      );

      test('should set hasReachedEnd true when list is empty', () async {
        when(
          () => mockRepository.getCharacters(
            page: 1,
            statusFilter: null,
            nameQuery: null,
          ),
        ).thenAnswer((_) async => Result.ok([]));

        await viewModel.getAllCharacters();

        expect(viewModel.characters, isEmpty);
        expect(viewModel.hasReachedEnd, true);
      });

      test('should set hasError true on failure', () async {
        when(
          () => mockRepository.getCharacters(
            page: 1,
            statusFilter: null,
            nameQuery: null,
          ),
        ).thenAnswer((_) async => Result.error(Exception('Error')));

        await viewModel.getAllCharacters();

        expect(viewModel.hasError, true);
        expect(viewModel.isLoading, false);
      });
    });

    group('loadMoreCharacters', () {
      test('should fetch next page', () async {
        // Setup initial state (page 1 loaded)
        final charactersPage1 = List.generate(
          20,
          (index) => Character(
            id: index,
            name: 'Char $index',
            status: Status.alive,
            species: 'Human',
            gender: Gender.male,
            imageUrl: 'image',
            locationName: 'Earth',
            originName: 'Earth',
            episodesCount: 1,
          ),
        );

        when(
          () => mockRepository.getCharacters(
            page: 1,
            statusFilter: null,
            nameQuery: null,
          ),
        ).thenAnswer((_) async => Result.ok(charactersPage1));

        await viewModel.getAllCharacters();
        expect(viewModel.page, 2);

        // Load page 2
        final charactersPage2 = [
          const Character(
            id: 21,
            name: 'Char 21',
            status: Status.alive,
            species: 'Human',
            gender: Gender.male,
            imageUrl: 'image',
            locationName: 'Earth',
            originName: 'Earth',
            episodesCount: 1,
          ),
        ];

        when(
          () => mockRepository.getCharacters(
            page: 2,
            statusFilter: null,
            nameQuery: null,
          ),
        ).thenAnswer((_) async => Result.ok(charactersPage2));

        await viewModel.loadMoreCharacters();

        expect(viewModel.characters.length, 21);
        expect(viewModel.page, 3);
        expect(viewModel.isLoadingMore, false);
      });

      test('should not load if already loading', () async {
        viewModel.isLoading = true;
        await viewModel.loadMoreCharacters();
        verifyNever(
          () => mockRepository.getCharacters(
            page: any(named: 'page'),
            statusFilter: any(named: 'statusFilter'),
            nameQuery: any(named: 'nameQuery'),
          ),
        );
      });
    });

    group('onStatusFilterChanged', () {
      test('should reset and filter', () async {
        when(
          () => mockRepository.getCharacters(
            page: 1,
            statusFilter: 'alive',
            nameQuery: null,
          ),
        ).thenAnswer((_) async => Result.ok([]));

        viewModel.onStatusFilterChanged('Vivo');

        expect(viewModel.selectedStatusFilter, 'Vivo');
        await Future.delayed(Duration.zero); // Wait for async call

        verify(
          () => mockRepository.getCharacters(
            page: 1,
            statusFilter: 'alive',
            nameQuery: null,
          ),
        ).called(1);
      });

      test('should ignore if same status', () async {
        viewModel.onStatusFilterChanged('Todos');
        verifyNever(
          () => mockRepository.getCharacters(
            page: any(named: 'page'),
            statusFilter: any(named: 'statusFilter'),
            nameQuery: any(named: 'nameQuery'),
          ),
        );
      });
    });

    group('onSearchChanged', () {
      test('should debounce and search', () async {
        when(
          () => mockRepository.getCharacters(
            page: 1,
            statusFilter: null,
            nameQuery: 'Rick',
          ),
        ).thenAnswer((_) async => Result.ok([]));

        viewModel.onSearchChanged('Rick');

        // Timer duration is 1 second
        await Future.delayed(const Duration(seconds: 1));

        verify(
          () => mockRepository.getCharacters(
            page: 1,
            statusFilter: null,
            nameQuery: 'Rick',
          ),
        ).called(1);
        expect(viewModel.searchNameQuery, 'Rick');
      });
    });
  });
}
