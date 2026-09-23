import 'package:flutter/material.dart';

import '../models/recipe.dart';

/// Source unique des données de recettes. Aucun écran ni widget ne
/// contient de recette codée en dur.
class RecipeRepository extends ChangeNotifier {
  RecipeRepository._internal();
  static final RecipeRepository instance = RecipeRepository._internal();

  static const List<String> availableCategories = [
    'Entrée',
    'Plat principal',
    'Dessert',
    'Boisson',
  ];

  static const List<String> availableDifficulties = ['Facile', 'Moyen', 'Difficile'];

  final List<Recipe> _recipes = [
    const Recipe(
      id: '1',
      title: 'Riz gras',
      category: 'Plat principal',
      prepMinutes: 45,
      difficulty: 'Moyen',
      description: 'Un riz gras traditionnel cuit dans un bouillon de tomate et de légumes.',
      icon: Icons.rice_bowl,
      color: Colors.deepOrange,
    ),
    const Recipe(
      id: '2',
      title: 'Salade fraîcheur',
      category: 'Entrée',
      prepMinutes: 15,
      difficulty: 'Facile',
      description: 'Une salade légère à base de concombre, tomate et oignon.',
      icon: Icons.eco,
      color: Colors.green,
    ),
    const Recipe(
      id: '3',
      title: 'Jus de bissap',
      category: 'Boisson',
      prepMinutes: 20,
      difficulty: 'Facile',
      description: 'Une infusion de fleurs d\'hibiscus sucrée, servie bien fraîche.',
      icon: Icons.local_drink,
      color: Colors.pinkAccent,
    ),
    const Recipe(
      id: '4',
      title: 'Beignets sucrés',
      category: 'Dessert',
      prepMinutes: 35,
      difficulty: 'Facile',
      description: 'Des petits beignets moelleux, parfaits avec un café.',
      icon: Icons.cookie,
      color: Colors.amber,
    ),
  ];

  List<Recipe> get all => List.unmodifiable(_recipes);

  List<String> get categories {
    final set = _recipes.map((r) => r.category).toSet().toList();
    set.sort();
    return set;
  }

  Recipe? findById(String id) {
    for (final recipe in _recipes) {
      if (recipe.id == id) return recipe;
    }
    return null;
  }

  void add(Recipe recipe) {
    _recipes.add(recipe);
    notifyListeners();
  }

  List<Recipe> search({String query = '', String category = 'Toutes'}) {
    return _recipes.where((r) {
      final matchesQuery = query.isEmpty || r.title.toLowerCase().contains(query.toLowerCase());
      final matchesCategory = category == 'Toutes' || r.category == category;
      return matchesQuery && matchesCategory;
    }).toList();
  }

  static Color colorForCategory(String category) {
    switch (category) {
      case 'Entrée':
        return Colors.green;
      case 'Plat principal':
        return Colors.deepOrange;
      case 'Dessert':
        return Colors.amber;
      case 'Boisson':
        return Colors.pinkAccent;
      default:
        return Colors.teal;
    }
  }

  static IconData iconForCategory(String category) {
    switch (category) {
      case 'Entrée':
        return Icons.eco;
      case 'Plat principal':
        return Icons.restaurant;
      case 'Dessert':
        return Icons.cake;
      case 'Boisson':
        return Icons.local_drink;
      default:
        return Icons.restaurant_menu;
    }
  }
}
