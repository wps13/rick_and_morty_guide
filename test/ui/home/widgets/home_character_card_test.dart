import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:network_image_mock/network_image_mock.dart';
import 'package:rick_and_morty_guide/ui/home/widgets/home_character_card.dart';

void main() {
  group('HomeCharacterCard', () {
    testWidgets('renders correct character info', (tester) async {
      const name = 'Rick Sanchez';
      const status = 'Vivo';
      const species = 'Human';
      const locationName = 'Earth';
      const imageUrl =
          'https://rickandmortyapi.com/api/character/avatar/1.jpeg';
      bool pressed = false;

      await mockNetworkImagesFor(
        () => tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: HomeCharacterCard(
                name: name,
                status: status,
                species: species,
                locationName: locationName,
                image: imageUrl,
                onPressed: () {
                  pressed = true;
                },
              ),
            ),
          ),
        ),
      );

      expect(find.text(name), findsOneWidget);
      expect(find.text('$status - $species'), findsOneWidget);
      expect(find.text(locationName), findsOneWidget);

      await tester.tap(find.byType(HomeCharacterCard));
      expect(pressed, isTrue);
    });
  });
}
