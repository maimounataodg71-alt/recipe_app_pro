import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Gère l'ensemble des identifiants de recettes favorites, avec
/// persistance locale. Séparé du [RecipeRepository] pour rester testable
/// indépendamment (pas de dépendance à la liste des recettes elle-même).
class FavoritesController extends ChangeNotifier {
  FavoritesController({SharedPreferences? preferences}) : _preferences = preferences;

  static const _prefsKey = 'favorite_recipe_ids';

  SharedPreferences? _preferences;
  final Set<String> _favoriteIds = {};
  bool _loaded = false;

  Set<String> get favoriteIds => Set.unmodifiable(_favoriteIds);

  bool isFavorite(String recipeId) => _favoriteIds.contains(recipeId);

  Future<void> load() async {
    if (_loaded) return;
    _preferences ??= await SharedPreferences.getInstance();
    final stored = _preferences!.getStringList(_prefsKey) ?? const [];
    _favoriteIds.addAll(stored);
    _loaded = true;
    notifyListeners();
  }

  Future<void> toggle(String recipeId) async {
    if (_favoriteIds.contains(recipeId)) {
      _favoriteIds.remove(recipeId);
    } else {
      _favoriteIds.add(recipeId);
    }
    notifyListeners();
    _preferences ??= await SharedPreferences.getInstance();
    await _preferences!.setStringList(_prefsKey, _favoriteIds.toList());
  }
}
