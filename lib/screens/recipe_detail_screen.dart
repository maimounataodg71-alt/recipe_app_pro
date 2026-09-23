import 'package:flutter/material.dart';

import '../data/favorites_controller.dart';
import '../data/recipe_repository.dart';
import '../l10n/app_localizations.dart';
import '../widgets/empty_state.dart';

class RecipeDetailScreen extends StatelessWidget {
  final String recipeId;
  final FavoritesController favoritesController;

  const RecipeDetailScreen({
    super.key,
    required this.recipeId,
    required this.favoritesController,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final recipe = RecipeRepository.instance.findById(recipeId);

    if (recipe == null) {
      return Scaffold(
        appBar: AppBar(title: Text(l10n.recipes)),
        body: EmptyState(message: l10n.noResults, icon: Icons.error_outline),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(recipe.title),
        actions: [
          ListenableBuilder(
            listenable: favoritesController,
            builder: (context, _) {
              final isFav = favoritesController.isFavorite(recipe.id);
              return Semantics(
                label: isFav ? l10n.favoriteRemoved : l10n.favoriteAdded,
                button: true,
                child: IconButton(
                  icon: Icon(isFav ? Icons.favorite : Icons.favorite_border),
                  onPressed: () => favoritesController.toggle(recipe.id),
                ),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RepaintBoundary(
              child: Stack(
                children: [
                  Container(height: 180, width: double.infinity, color: recipe.color),
                  Positioned(
                    bottom: 12,
                    right: 20,
                    child: Icon(recipe.icon, size: 72, color: Colors.white),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Wrap(
                    spacing: 8,
                    children: [
                      Chip(label: Text(recipe.category)),
                      Chip(label: Text('${recipe.prepMinutes} ${l10n.minutesShort}')),
                      Chip(label: Text(recipe.difficulty)),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Text(recipe.description, style: Theme.of(context).textTheme.bodyLarge),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
