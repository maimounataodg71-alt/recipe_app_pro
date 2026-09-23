import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:recipe_app_pro/models/recipe.dart';
import 'package:recipe_app_pro/widgets/recipe_card.dart';

void main() {
  const recipe = Recipe(
    id: '1',
    title: 'Riz gras',
    category: 'Plat principal',
    prepMinutes: 45,
    difficulty: 'Moyen',
    description: 'Description de test.',
    icon: Icons.rice_bowl,
    color: Colors.deepOrange,
  );

  testWidgets('RecipeCard affiche le titre et les infos de la recette', (tester) async {
    await tester.pumpWidget(
      MaterialApp(home: Scaffold(body: RecipeCard(recipe: recipe, onTap: () {}))),
    );

    expect(find.text('Riz gras'), findsOneWidget);
    expect(find.text('Plat principal • 45 min'), findsOneWidget);
  });

  testWidgets('RecipeCard déclenche onTap lors d\'un appui', (tester) async {
    var tapped = false;
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(body: RecipeCard(recipe: recipe, onTap: () => tapped = true)),
      ),
    );

    await tester.tap(find.byType(RecipeCard));
    expect(tapped, isTrue);
  });

  testWidgets('le bouton favori a un label sémantique accessible', (tester) async {
    final handle = tester.ensureSemantics();

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: RecipeCard(recipe: recipe, onTap: () {}, onFavoriteToggle: () {}),
        ),
      ),
    );
    await tester.pump();

    expect(find.bySemanticsLabel('Ajouter aux favoris'), findsOneWidget);

    handle.dispose();
  });
}
