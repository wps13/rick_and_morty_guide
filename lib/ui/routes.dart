import 'package:flutter/material.dart';
import '../data/repositories/characters_remote_repository.dart';
import 'config/widgets/config_screen.dart';
import 'core/theme_controller.dart';
import 'detail/view_models/detail_viewmodel.dart';
import 'detail/widgets/detail_screen.dart';
import 'home/main_screen.dart';
import 'home/view_models/home_viewmodel.dart';
import 'home/widgets/home_screen.dart';

class AppRoutes {
  static const String home = '/';
  static const String detail = '/detail';
}

class AppRouter {
  final CharactersRemoteRepository charactersRepository;
  final ThemeController themeController;

  AppRouter({
    required this.charactersRepository,
    required this.themeController,
  });

  Route? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.home:
        return MaterialPageRoute(
          builder: (_) => MainScreen(
            homeScreen: HomeScreen(
              viewmodel: HomeViewModel(
                charactersRepository: charactersRepository,
              ),
            ),
            configScreen: ConfigScreen(themeController: themeController),
          ),
        );
      case AppRoutes.detail:
        final characterId = settings.arguments as int;
        return MaterialPageRoute(
          builder: (_) => DetailScreen(
            viewmodel: DetailViewModel(
              charactersRepository: charactersRepository,
            ),
            characterId: characterId,
          ),
        );
      default:
        return null;
    }
  }
}
