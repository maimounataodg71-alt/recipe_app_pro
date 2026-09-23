import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../data/favorites_controller.dart';
import '../data/recipe_repository.dart';
import '../l10n/app_localizations.dart';
import '../widgets/category_filter_chips.dart';
import '../widgets/custom_text_field.dart';
import '../widgets/empty_state.dart';
import '../widgets/recipe_card.dart';

class RecipeListScreen extends StatefulWidget {
  final FavoritesController favoritesController;

  const RecipeListScreen({super.key, required this.favoritesController});

  @override
  State<RecipeListScreen> createState() => _RecipeListScreenState();
}

class _RecipeListScreenState extends State<RecipeListScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _query = '';
  String _selectedCategory = 'Toutes';

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return Scaffold(
      appBar: AppBar(title: Text(l10n.recipes)),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.push('/add'),
        tooltip: l10n.addRecipe,
        child: const Icon(Icons.add),
      ),
      body: ListenableBuilder(
        listenable: RecipeRepository.instance,
        builder: (context, _) {
          final categories = [l10n.all, ...RecipeRepository.instance.categories];
          final selected = _selectedCategory == 'Toutes' ? l10n.all : _selectedCategory;
          final results = RecipeRepository.instance.search(
            query: _query,
            category: _selectedCategory,
          );

          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(12, 12, 12, 0),
                child: CustomTextField(
                  controller: _searchController,
                  label: l10n.search,
                  prefixIcon: Icons.search,
                  onChanged: (value) => setState(() => _query = value),
                ),
              ),
              const SizedBox(height: 8),
              CategoryFilterChips(
                categories: categories,
                selected: selected,
                onSelected: (category) => setState(
                  () => _selectedCategory = category == l10n.all ? 'Toutes' : category,
                ),
              ),
              const SizedBox(height: 4),
              Expanded(
                child: results.isEmpty
                    ? EmptyState(message: l10n.noResults)
                    : ListenableBuilder(
                        listenable: widget.favoritesController,
                        builder: (context, _) {
                          return LayoutBuilder(
                            builder: (context, constraints) {
                              final crossAxisCount = constraints.maxWidth >= 900
                                  ? 3
                                  : constraints.maxWidth >= 600
                                      ? 2
                                      : 1;
                              return GridView.builder(
                                padding: const EdgeInsets.all(12),
                                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: crossAxisCount,
                                  mainAxisExtent: 110,
                                  mainAxisSpacing: 12,
                                  crossAxisSpacing: 12,
                                ),
                                itemCount: results.length,
                                itemBuilder: (context, index) {
                                  final recipe = results[index];
                                  return RecipeCard(
                                    key: ValueKey(recipe.id),
                                    recipe: recipe,
                                    isFavorite: widget.favoritesController.isFavorite(recipe.id),
                                    onFavoriteToggle: () =>
                                        widget.favoritesController.toggle(recipe.id),
                                    onTap: () => context.push('/recipe/${recipe.id}'),
                                  );
                                },
                              );
                            },
                          );
                        },
                      ),
              ),
            ],
          );
        },
      ),
    );
  }
}