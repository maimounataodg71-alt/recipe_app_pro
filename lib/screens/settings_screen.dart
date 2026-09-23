import 'package:flutter/material.dart';

import '../l10n/app_localizations.dart';
import '../l10n/locale_controller.dart';
import '../theme/theme_controller.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return Scaffold(
      appBar: AppBar(title: Text(l10n.settings)),
      body: ListView(
        children: [
          ValueListenableBuilder<ThemeMode>(
            valueListenable: ThemeController.mode,
            builder: (context, mode, _) {
              return Semantics(
                label: l10n.darkMode,
                toggled: mode == ThemeMode.dark,
                child: SwitchListTile(
                  title: Text(l10n.darkMode),
                  secondary: const Icon(Icons.dark_mode),
                  value: mode == ThemeMode.dark,
                  onChanged: (_) => ThemeController.toggle(),
                ),
              );
            },
          ),
          ValueListenableBuilder<Locale>(
            valueListenable: LocaleController.locale,
            builder: (context, locale, _) {
              return ListTile(
                leading: const Icon(Icons.language),
                title: Text(l10n.language),
                trailing: DropdownButton<Locale>(
                  value: locale,
                  onChanged: (value) {
                    if (value != null) LocaleController.setLocale(value);
                  },
                  items: const [
                    DropdownMenuItem(value: Locale('fr'), child: Text('Français')),
                    DropdownMenuItem(value: Locale('en'), child: Text('English')),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
