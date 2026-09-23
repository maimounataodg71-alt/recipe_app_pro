import 'package:flutter/material.dart';

import 'app.dart';
import 'data/favorites_controller.dart';
import 'l10n/locale_controller.dart';
import 'theme/theme_controller.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await ThemeController.load();
  await LocaleController.load();

  final favoritesController = FavoritesController();
  await favoritesController.load();

  runApp(RecipeApp(favoritesController: favoritesController));
}
