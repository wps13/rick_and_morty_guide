import 'package:flutter/material.dart';
import '../../../l10n/app_localizations.dart';
import '../../core/theme_controller.dart';

class ConfigScreen extends StatelessWidget {
  const ConfigScreen({super.key, required this.themeController});

  final ThemeController themeController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context).configScreenTitle),
      ),
      body: Center(
        child: ValueListenableBuilder<ThemeMode>(
          valueListenable: themeController,
          builder: (context, themeMode, child) {
            return SwitchListTile(
              title: Text(AppLocalizations.of(context).darkTheme),
              value: themeMode == ThemeMode.dark,
              onChanged: (value) {
                themeController.toggleTheme();
              },
            );
          },
        ),
      ),
    );
  }
}
