import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Contrôle global et partagé du thème. Un simple ValueNotifier suffit
/// pour ce besoin ; persisté pour survivre au redémarrage de l'app.
class ThemeController {
  ThemeController._();

  static const _prefsKey = 'theme_mode_is_dark';

  static final ValueNotifier<ThemeMode> mode = ValueNotifier(ThemeMode.light);

  static Future<void> load() async {
    final prefs = await SharedPreferences.getInstance();
    final isDark = prefs.getBool(_prefsKey) ?? false;
    mode.value = isDark ? ThemeMode.dark : ThemeMode.light;
  }

  static Future<void> toggle() async {
    mode.value = mode.value == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_prefsKey, mode.value == ThemeMode.dark);
  }
}
