import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'di/service_locator.dart';
import 'ui/core/theme_controller.dart';
import 'ui/routes.dart';
import 'ui/core/themes/colors.dart';
import 'l10n/app_localizations.dart';

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
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: const [Locale('pt'), Locale('en')],
          locale: const Locale('pt'),
          theme: lightTheme,
          darkTheme: darkTheme,
          themeMode: themeMode,
          onGenerateRoute: appRouter.onGenerateRoute,
        );
      },
    );
  }
}
