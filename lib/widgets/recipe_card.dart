import 'package:flutter/material.dart';

import '../models/recipe.dart';

/// Carte réutilisable affichant l'aperçu d'une [Recipe], avec un bouton
/// favori accessible (Semantics + tooltip) et un rendu optimisé
/// (const où possible, RepaintBoundary pour isoler le repaint de l'icône).
class RecipeCard extends StatelessWidget {
  final Recipe recipe;
  final VoidCallback onTap;
  final bool isFavorite;
  final VoidCallback? onFavoriteToggle;

  const RecipeCard({
    super.key,
    required this.recipe,
    required this.onTap,
    this.isFavorite = false,
    this.onFavoriteToggle,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              RepaintBoundary(
                child: Container(
                  width: 90,
                  height: double.infinity,
                  color: recipe.color,
                  child: Icon(
                    recipe.icon,
                    color: Colors.white,
                    size: 36,
                    semanticLabel: recipe.category,
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        recipe.title,
                        style: Theme.of(context).textTheme.titleMedium,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '${recipe.category} • ${recipe.prepMinutes} min',
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ],
                  ),
                ),
              ),
              if (onFavoriteToggle != null)
                Semantics(
                  label: isFavorite ? 'Retirer des favoris' : 'Ajouter aux favoris',
                  button: true,
                  container: true,
                  child: IconButton(
                    tooltip: isFavorite ? 'Retirer des favoris' : 'Ajouter aux favoris',
                    icon: Icon(isFavorite ? Icons.favorite : Icons.favorite_border),
                    onPressed: onFavoriteToggle,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
