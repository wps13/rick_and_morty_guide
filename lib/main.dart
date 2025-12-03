import 'package:flutter/material.dart';
import 'data/services/api_client.dart';
import 'ui/core/theme_controller.dart';
import 'ui/routes.dart';

import 'data/repositories/characters_remote_repository.dart';
import 'ui/core/themes/colors.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final ThemeController _themeController = ThemeController(ThemeMode.light);
  late final CharactersRemoteRepository _charactersRepository;
  late final AppRouter _appRouter;

  @override
  void initState() {
    super.initState();
    _charactersRepository = CharactersRemoteRepository(apiClient: ApiClient());
    _appRouter = AppRouter(
      charactersRepository: _charactersRepository,
      themeController: _themeController,
    );
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: _themeController,
      builder: (context, themeMode, child) {
        return MaterialApp(
          theme: lightTheme,
          darkTheme: darkTheme,
          themeMode: themeMode,
          onGenerateRoute: _appRouter.onGenerateRoute,
        );
      },
    );
  }
}
