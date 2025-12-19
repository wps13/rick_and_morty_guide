import 'package:flutter/material.dart';
import 'di/service_locator.dart';
import 'ui/core/theme_controller.dart';
import 'ui/routes.dart';
import 'ui/core/themes/colors.dart';

void main() {
  setupServiceLocator();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeController = getIt<ThemeController>();
    final appRouter = AppRouter();

    return ValueListenableBuilder<ThemeMode>(
      valueListenable: themeController,
      builder: (context, themeMode, child) {
        return MaterialApp(
          theme: lightTheme,
          darkTheme: darkTheme,
          themeMode: themeMode,
          onGenerateRoute: appRouter.onGenerateRoute,
        );
      },
    );
  }
}
