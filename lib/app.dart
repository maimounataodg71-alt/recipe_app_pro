import 'package:flutter/material.dart';

import 'data/favorites_controller.dart';
import 'l10n/app_localizations.dart';
import 'l10n/locale_controller.dart';
import 'router/app_router.dart';
import 'theme/app_theme.dart';
import 'theme/theme_controller.dart';

/// Racine de l'application, injectée avec un [FavoritesController] pour
/// rester testable (un contrôleur factice peut être fourni dans les tests
/// de widgets/intégration, sans dépendre de `SharedPreferences.getInstance`
/// tant que `load()` n'est pas appelé).
class RecipeApp extends StatelessWidget {
  final FavoritesController favoritesController;

  RecipeApp({super.key, FavoritesController? favoritesController})
      : favoritesController = favoritesController ?? FavoritesController();

  @override
  Widget build(BuildContext context) {
    final router = buildAppRouter(favoritesController);

    return ValueListenableBuilder<ThemeMode>(
      valueListenable: ThemeController.mode,
      builder: (context, themeMode, _) {
        return ValueListenableBuilder<Locale>(
          valueListenable: LocaleController.locale,
          builder: (context, locale, _) {
            return MaterialApp.router(
              title: 'Recipe App Pro',
              debugShowCheckedModeBanner: false,
              theme: AppTheme.light,
              darkTheme: AppTheme.dark,
              themeMode: themeMode,
              locale: locale,
              supportedLocales: AppLocalizations.supportedLocales,
              localizationsDelegates: AppLocalizations.localizationsDelegates,
              routerConfig: router,
            );
          },
        );
      },
    );
  }
}
