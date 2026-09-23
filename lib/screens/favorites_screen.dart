import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../data/favorites_controller.dart';
import '../data/recipe_repository.dart';
import '../l10n/app_localizations.dart';
import '../widgets/empty_state.dart';
import '../widgets/recipe_card.dart';

/// Écran 4 (des 5 requis) : liste des recettes favorites.
class FavoritesScreen extends StatelessWidget {
  final FavoritesController favoritesController;

  const FavoritesScreen({super.key, required this.favoritesController});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return Scaffold(
      appBar: AppBar(title: Text(l10n.favorites)),
      body: ListenableBuilder(
        listenable: Listenable.merge([favoritesController, RecipeRepository.instance]),
        builder: (context, _) {
          final favoriteRecipes = RecipeRepository.instance.all
              .where((r) => favoritesController.isFavorite(r.id))
              .toList();

          if (favoriteRecipes.isEmpty) {
            return EmptyState(message: l10n.noFavorites, icon: Icons.favorite_border);
          }

          return ListView.builder(
            padding: const EdgeInsets.all(12),
            itemCount: favoriteRecipes.length,
            itemBuilder: (context, index) {
              final recipe = favoriteRecipes[index];
              return Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: RecipeCard(
                  key: ValueKey(recipe.id),
                  recipe: recipe,
                  isFavorite: true,
                  onFavoriteToggle: () => favoritesController.toggle(recipe.id),
                  onTap: () => context.push('/recipe/${recipe.id}'),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
