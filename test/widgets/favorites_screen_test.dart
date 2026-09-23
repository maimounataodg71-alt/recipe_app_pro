import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:recipe_app_pro/data/favorites_controller.dart';
import 'package:recipe_app_pro/data/recipe_repository.dart';
import 'package:recipe_app_pro/l10n/app_localizations.dart';
import 'package:recipe_app_pro/screens/favorites_screen.dart';

void main() {
  Widget buildApp(FavoritesController controller) {
    return MaterialApp(
      locale: const Locale('fr'),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: FavoritesScreen(favoritesController: controller),
    );
  }

  setUp(() {
    SharedPreferences.setMockInitialValues({});
  });

  testWidgets('affiche un état vide quand aucune recette n\'est favorite', (tester) async {
    final controller = FavoritesController();
    await controller.load();

    await tester.pumpWidget(buildApp(controller));
    await tester.pump();

    expect(find.text('Aucun favori pour l\'instant.'), findsOneWidget);
  });

  testWidgets('affiche les recettes marquées comme favorites', (tester) async {
    final controller = FavoritesController();
    await controller.load();
    final firstRecipeId = RecipeRepository.instance.all.first.id;
    await controller.toggle(firstRecipeId);

    await tester.pumpWidget(buildApp(controller));
    await tester.pump();

    expect(find.text(RecipeRepository.instance.all.first.title), findsOneWidget);
  });
}
