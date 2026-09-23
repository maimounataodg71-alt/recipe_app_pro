import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:recipe_app_pro/data/recipe_repository.dart';
import 'package:recipe_app_pro/models/recipe.dart';

void main() {
  group('RecipeRepository', () {
    test('contient des recettes de démonstration au démarrage', () {
      expect(RecipeRepository.instance.all, isNotEmpty);
    });

    test('search() filtre par titre, insensible à la casse', () {
      final results = RecipeRepository.instance.search(query: 'RIZ');
      expect(results, isNotEmpty);
      expect(results.every((r) => r.title.toLowerCase().contains('riz')), isTrue);
    });

    test('search() filtre par catégorie', () {
      final results = RecipeRepository.instance.search(category: 'Dessert');
      expect(results, isNotEmpty);
      expect(results.every((r) => r.category == 'Dessert'), isTrue);
    });

    test('findById() retrouve une recette existante, sinon renvoie null', () {
      final existing = RecipeRepository.instance.all.first;
      expect(RecipeRepository.instance.findById(existing.id), isNotNull);
      expect(RecipeRepository.instance.findById('id-inconnu-xyz'), isNull);
    });

    test('add() ajoute une recette et notifie les auditeurs', () {
      final before = RecipeRepository.instance.all.length;
      var notified = false;
      void listener() => notified = true;

      RecipeRepository.instance.addListener(listener);
      RecipeRepository.instance.add(
        const Recipe(
          id: 'unit-test-recipe',
          title: 'Recette de test',
          category: 'Dessert',
          prepMinutes: 10,
          difficulty: 'Facile',
          description: 'Une recette ajoutée uniquement pour les tests.',
          icon: Icons.cake,
          color: Colors.amber,
        ),
      );

      expect(RecipeRepository.instance.all.length, before + 1);
      expect(notified, isTrue);
      RecipeRepository.instance.removeListener(listener);
    });

    test('colorForCategory() et iconForCategory() couvrent toutes les catégories connues', () {
      for (final category in RecipeRepository.availableCategories) {
        expect(RecipeRepository.colorForCategory(category), isA<Color>());
        expect(RecipeRepository.iconForCategory(category), isA<IconData>());
      }
    });

    test('categories renvoie une liste triée et sans doublon', () {
      final categories = RecipeRepository.instance.categories;
      final sorted = [...categories]..sort();
      expect(categories, sorted);
      expect(categories.toSet().length, categories.length);
    });
  });
}
