import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
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
  Route? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.home:
        return MaterialPageRoute(
          builder: (_) => MainScreen(
            homeScreen: HomeScreen(viewmodel: GetIt.I<HomeViewModel>()),
            configScreen: ConfigScreen(
              themeController: GetIt.I<ThemeController>(),
            ),
          ),
        );
      case AppRoutes.detail:
        final characterId = settings.arguments as int;
        return MaterialPageRoute(
          builder: (_) => DetailScreen(
            viewmodel: GetIt.I<DetailViewModel>(),
            characterId: characterId,
          ),
        );
      default:
        return null;
    }
  }
}
