import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:network_image_mock/network_image_mock.dart';
import 'package:rick_and_morty_guide/domain/models/character.dart';
import 'package:rick_and_morty_guide/ui/home/view_models/home_viewmodel.dart';
import 'package:rick_and_morty_guide/ui/home/widgets/home_screen.dart';
import 'package:rick_and_morty_guide/ui/home/widgets/home_character_card.dart';
import 'package:rick_and_morty_guide/ui/home/widgets/home_error_widget.dart';
import 'package:rick_and_morty_guide/ui/home/widgets/home_skeleton.dart';

class MockHomeViewModel extends Mock implements HomeViewModel {}

void main() {
  late MockHomeViewModel mockViewModel;

  setUp(() {
    mockViewModel = MockHomeViewModel();

    when(() => mockViewModel.addListener(any())).thenReturn(null);
    when(() => mockViewModel.removeListener(any())).thenReturn(null);

    when(
      () => mockViewModel.availableStatusFilters,
    ).thenReturn(['Todos', 'Vivo', 'Morto', 'Desconhecido']);
    when(() => mockViewModel.selectedStatusFilter).thenReturn('Todos');
    when(
      () => mockViewModel.statusFilters,
    ).thenReturn(['Todos', 'Vivo', 'Morto', 'Desconhecido']);
    when(() => mockViewModel.selectedStatus).thenReturn('Todos');
    when(() => mockViewModel.characters).thenReturn([]);
    when(() => mockViewModel.isLoading).thenReturn(false);
    when(() => mockViewModel.hasError).thenReturn(false);
    when(() => mockViewModel.isLoadingMore).thenReturn(false);
    when(() => mockViewModel.getAllCharacters()).thenAnswer((_) async {});
  });

  Widget createWidgetUnderTest() {
    return MaterialApp(home: HomeScreen(viewmodel: mockViewModel));
  }

  group('HomeScreen', () {
    testWidgets('renders loading skeleton when isLoading is true', (
      tester,
    ) async {
      when(() => mockViewModel.isLoading).thenReturn(true);

      await mockNetworkImagesFor(
        () => tester.pumpWidget(createWidgetUnderTest()),
      );

      expect(find.byType(HomeSkeleton), findsOneWidget);
    });

    testWidgets(
      'renders error widget when hasError is true and characters list is empty',
      (tester) async {
        when(() => mockViewModel.hasError).thenReturn(true);
        when(() => mockViewModel.characters).thenReturn([]);

        await mockNetworkImagesFor(
          () => tester.pumpWidget(createWidgetUnderTest()),
        );

        expect(find.byType(HomeErrorWidget), findsOneWidget);
      },
    );

    testWidgets('renders list of characters when data is available', (
      tester,
    ) async {
      final characters = [
        const Character(
          id: 1,
          name: 'Rick Sanchez',
          status: Status.alive,
          species: 'Human',
          gender: Gender.male,
          imageUrl: 'https://rickandmortyapi.com/api/character/avatar/1.jpeg',
          locationName: 'Earth',
          originName: 'Earth',
          episodesCount: 5,
        ),
        const Character(
          id: 2,
          name: 'Morty Smith',
          status: Status.alive,
          species: 'Human',
          gender: Gender.male,
          imageUrl: 'https://rickandmortyapi.com/api/character/avatar/2.jpeg',
          locationName: 'Earth',
          originName: 'Earth',
          episodesCount: 5,
        ),
      ];

      when(() => mockViewModel.characters).thenReturn(characters);

      await mockNetworkImagesFor(
        () => tester.pumpWidget(createWidgetUnderTest()),
      );

      expect(find.byType(HomeCharacterCard), findsNWidgets(2));
      expect(find.text('Rick Sanchez'), findsOneWidget);
      expect(find.text('Morty Smith'), findsOneWidget);
    });

    testWidgets('triggers getAllCharacters on init', (tester) async {
      await mockNetworkImagesFor(
        () => tester.pumpWidget(createWidgetUnderTest()),
      );
      verify(() => mockViewModel.getAllCharacters()).called(1);
    });

    testWidgets('triggers onStatusFilterChanged when filter is selected', (
      tester,
    ) async {
      await mockNetworkImagesFor(
        () => tester.pumpWidget(createWidgetUnderTest()),
      );

      await tester.tap(find.text('Vivo'));
      await tester.pump();

      verify(() => mockViewModel.onStatusFilterChanged('Vivo')).called(1);
    });

    testWidgets('triggers onSearchChanged when text is entered', (
      tester,
    ) async {
      await mockNetworkImagesFor(
        () => tester.pumpWidget(createWidgetUnderTest()),
      );

      await tester.enterText(find.byType(TextField), 'Rick');
      await tester.pump();

      verify(() => mockViewModel.onSearchChanged('Rick')).called(1);
    });
  });
}
