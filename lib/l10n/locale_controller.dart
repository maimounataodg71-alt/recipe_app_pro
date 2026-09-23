import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Contrôle global de la langue de l'application (FR par défaut, EN
/// disponible). Persisté pour survivre au redémarrage.
class LocaleController {
  LocaleController._();

  static const _prefsKey = 'locale_language_code';

  static final ValueNotifier<Locale> locale = ValueNotifier(const Locale('fr'));

  static Future<void> load() async {
    final prefs = await SharedPreferences.getInstance();
    final code = prefs.getString(_prefsKey) ?? 'fr';
    locale.value = Locale(code);
  }

  static Future<void> setLocale(Locale newLocale) async {
    locale.value = newLocale;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_prefsKey, newLocale.languageCode);
  }
}
