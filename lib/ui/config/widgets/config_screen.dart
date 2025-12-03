import 'package:flutter/material.dart';
import '../../core/theme_controller.dart';

class ConfigScreen extends StatelessWidget {
  const ConfigScreen({super.key, required this.themeController});

  final ThemeController themeController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Configurações')),
      body: Center(
        child: ValueListenableBuilder<ThemeMode>(
          valueListenable: themeController,
          builder: (context, themeMode, child) {
            return SwitchListTile(
              title: const Text('Tema Escuro'),
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
