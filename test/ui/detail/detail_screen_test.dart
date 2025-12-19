import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:network_image_mock/network_image_mock.dart';
import 'package:rick_and_morty_guide/domain/models/character.dart';
import 'package:rick_and_morty_guide/ui/detail/view_models/detail_viewmodel.dart';
import 'package:rick_and_morty_guide/ui/detail/widgets/detail_screen.dart';
import 'package:rick_and_morty_guide/ui/detail/widgets/detail_info_card.dart';

class MockDetailViewModel extends Mock implements DetailViewModel {}

void main() {
  late MockDetailViewModel mockViewModel;
  const int testCharacterId = 1;

  setUp(() {
    mockViewModel = MockDetailViewModel();

    when(() => mockViewModel.addListener(any())).thenReturn(null);
    when(() => mockViewModel.removeListener(any())).thenReturn(null);

    when(() => mockViewModel.isLoading).thenReturn(false);
    when(() => mockViewModel.hasError).thenReturn(false);
    when(() => mockViewModel.character).thenReturn(null);
    when(() => mockViewModel.getCharacter(any())).thenAnswer((_) async {});
  });

  Widget createWidgetUnderTest() {
    return MaterialApp(
      home: DetailScreen(
        viewmodel: mockViewModel,
        characterId: testCharacterId,
      ),
    );
  }

  group('DetailScreen', () {
    testWidgets('triggers getCharacter on init', (tester) async {
      await mockNetworkImagesFor(
        () => tester.pumpWidget(createWidgetUnderTest()),
      );
      verify(() => mockViewModel.getCharacter(testCharacterId)).called(1);
    });

    testWidgets('shows loading indicator when isLoading is true', (
      tester,
    ) async {
      when(() => mockViewModel.isLoading).thenReturn(true);

      await mockNetworkImagesFor(
        () => tester.pumpWidget(createWidgetUnderTest()),
      );

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets('shows error message when hasError is true', (tester) async {
      when(() => mockViewModel.hasError).thenReturn(true);

      await mockNetworkImagesFor(
        () => tester.pumpWidget(createWidgetUnderTest()),
      );

      expect(find.text('Erro ao carregar personagem'), findsOneWidget);
      expect(find.text('Tentar novamente'), findsOneWidget);
    });

    testWidgets('shows character details when data is loaded', (tester) async {
      const character = Character(
        id: 1,
        name: 'Rick Sanchez',
        status: Status.alive,
        species: 'Human',
        gender: Gender.male,
        imageUrl: 'https://rickandmortyapi.com/api/character/avatar/1.jpeg',
        locationName: 'Earth (C-137)',
        originName: 'Earth (C-137)',
        episodesCount: 55,
      );

      when(() => mockViewModel.character).thenReturn(character);

      await mockNetworkImagesFor(
        () => tester.pumpWidget(createWidgetUnderTest()),
      );

      expect(find.text('STATUS: VIVO'), findsOneWidget);
      expect(find.text('Espécie:'), findsOneWidget);
      expect(find.text('Human'), findsOneWidget);
      expect(find.text('Gênero:'), findsOneWidget);
      expect(find.text('Masculino'), findsOneWidget);
      expect(find.text('Origem:'), findsOneWidget);
      expect(find.text('Earth (C-137)'), findsNWidgets(2));

      expect(find.byType(DetailInfoCard), findsNWidgets(3));
    });

    testWidgets('calls getCharacter when retry button is pressed', (
      tester,
    ) async {
      when(() => mockViewModel.hasError).thenReturn(true);

      await mockNetworkImagesFor(
        () => tester.pumpWidget(createWidgetUnderTest()),
      );

      await tester.tap(find.text('Tentar novamente'));

      verify(() => mockViewModel.getCharacter(testCharacterId)).called(2);
    });
  });
}
