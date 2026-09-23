import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:recipe_app_pro/app.dart';
import 'package:recipe_app_pro/data/favorites_controller.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    SharedPreferences.setMockInitialValues({});
  });

  testWidgets(
    'parcours complet : ajouter une recette et la retrouver dans la liste',
    (tester) async {
      final favoritesController = FavoritesController();
      await favoritesController.load();

      await tester.pumpWidget(RecipeApp(favoritesController: favoritesController));
      await tester.pumpAndSettle();

      // Ouvre le formulaire d'ajout depuis l'écran liste.
      await tester.tap(find.byType(FloatingActionButton));
      await tester.pumpAndSettle();

      // Remplit le formulaire.
      final fields = find.byType(TextFormField);
      await tester.enterText(fields.at(0), 'Tarte aux pommes de test');
      await tester.enterText(fields.at(2), 'Une description suffisamment longue pour être valide.');

      await tester.tap(find.byType(DropdownButtonFormField<String>).first);
      await tester.pumpAndSettle();
      await tester.tap(find.text('Dessert').last);
      await tester.pumpAndSettle();

      await tester.tap(find.byType(DropdownButtonFormField<String>).at(1));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Facile').last);
      await tester.pumpAndSettle();

      await tester.enterText(fields.at(1), '30');

      // Valide le formulaire.
      await tester.tap(find.text('Enregistrer'));
      await tester.pumpAndSettle();

      // De retour sur la liste, la nouvelle recette doit apparaître.
      expect(find.text('Tarte aux pommes de test'), findsOneWidget);
    },
  );

  testWidgets(
    'parcours complet : ajouter une recette aux favoris et la retrouver dans l\'onglet Favoris',
    (tester) async {
      final favoritesController = FavoritesController();
      await favoritesController.load();

      await tester.pumpWidget(RecipeApp(favoritesController: favoritesController));
      await tester.pumpAndSettle();

      // Marque la première recette comme favorite depuis la liste.
      final favoriteButton = find.byIcon(Icons.favorite_border).first;
      await tester.tap(favoriteButton);
      await tester.pumpAndSettle();

      // Bascule vers l'onglet Favoris.
      await tester.tap(find.text('Favoris').last);
      await tester.pumpAndSettle();

      // La recette doit apparaître dans l'onglet Favoris (état vide absent).
      expect(find.text('Aucun favori pour l\'instant.'), findsNothing);
    },
  );
}
