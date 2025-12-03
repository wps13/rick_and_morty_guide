import 'package:flutter/material.dart';

class RickAndMortyColors {
  static const Color darkPrimaryBg = Color(0xFF0B1E2D);
  static const Color darkSecondaryBg = Color(0xFF1A3A52);

  static const Color darkCardBorder = Color(0xFF00D9CC);

  static const Color darkFont = Color(0xFFE8F5F7);
  static const Color darkFontSecondary = Color(0xFFB0C9CE);

  static const Color darkAppTitle = Color(0xFF00FFF0);

  static const Color statusAlive = Color(0xFF55CC44);
  static const Color statusDead = Color(0xFFD63D2E);
  static const Color statusUnknown = Color(0xFF9E9E9E);

  static const Color lightPrimaryBg = Color(0xFFF0F8F7);
  static const Color lightSecondaryBg = Color(0xFFFFFFFF);

  static const Color lightCardBorder = Color(0xFF00A89C);

  static const Color lightFont = Color(0xFF0A1E2D);
  static const Color lightFontSecondary = Color(0xFF3F5A6A);

  static const Color lightAppTitle = Color(0xFF008B82);

  static const Color statusAliveDark = Color(0xFF2E7D32);
  static const Color statusDeadDark = Color(0xFFC62828);
  static const Color statusUnknownDark = Color(0xFF616161);
}

final ThemeData darkTheme = ThemeData(
  useMaterial3: true,
  brightness: Brightness.dark,

  colorScheme: ColorScheme.dark(
    primary: RickAndMortyColors.darkCardBorder,
    surface: RickAndMortyColors.darkSecondaryBg,
    onPrimary: RickAndMortyColors.darkPrimaryBg,
    onSurface: RickAndMortyColors.darkFont,
    outline: RickAndMortyColors.darkCardBorder,
  ),

  scaffoldBackgroundColor: RickAndMortyColors.darkPrimaryBg,

  textTheme: TextTheme(
    displayLarge: TextStyle(
      color: RickAndMortyColors.darkAppTitle,
      fontSize: 32,
      fontWeight: FontWeight.bold,
    ),
    displayMedium: TextStyle(
      color: RickAndMortyColors.darkAppTitle,
      fontSize: 24,
      fontWeight: FontWeight.bold,
    ),
    bodyLarge: TextStyle(color: RickAndMortyColors.darkFont, fontSize: 16),
    bodyMedium: TextStyle(
      color: RickAndMortyColors.darkFontSecondary,
      fontSize: 14,
    ),
  ),
);

final ThemeData lightTheme = ThemeData(
  useMaterial3: true,
  brightness: Brightness.light,
  colorScheme: ColorScheme.light(
    primary: RickAndMortyColors.lightCardBorder,
    surface: RickAndMortyColors.lightSecondaryBg,
    onPrimary: Colors.white,
    onSurface: RickAndMortyColors.lightFont,
    outline: RickAndMortyColors.lightCardBorder,
  ),

  scaffoldBackgroundColor: RickAndMortyColors.lightPrimaryBg,

  textTheme: TextTheme(
    displayLarge: TextStyle(
      color: RickAndMortyColors.lightAppTitle,
      fontSize: 32,
      fontWeight: FontWeight.bold,
    ),
    displayMedium: TextStyle(
      color: RickAndMortyColors.lightAppTitle,
      fontSize: 24,
      fontWeight: FontWeight.bold,
    ),
    bodyLarge: TextStyle(color: RickAndMortyColors.lightFont, fontSize: 16),
    bodyMedium: TextStyle(
      color: RickAndMortyColors.lightFontSecondary,
      fontSize: 14,
    ),
  ),
);
