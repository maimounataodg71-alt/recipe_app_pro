import 'package:flutter/material.dart';

import '../data/favorites_controller.dart';
import '../l10n/app_localizations.dart';
import 'favorites_screen.dart';
import 'recipe_list_screen.dart';
import 'settings_screen.dart';

/// Coquille de navigation principale : 3 onglets (Recettes, Favoris,
/// Réglages). Le détail et l'ajout sont poussés par-dessus via GoRouter.
class HomeShell extends StatefulWidget {
  final FavoritesController favoritesController;

  const HomeShell({super.key, required this.favoritesController});

  @override
  State<HomeShell> createState() => _HomeShellState();
}

class _HomeShellState extends State<HomeShell> {
  int _index = 0;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final screens = [
      RecipeListScreen(favoritesController: widget.favoritesController),
      FavoritesScreen(favoritesController: widget.favoritesController),
      const SettingsScreen(),
    ];

    return LayoutBuilder(
      builder: (context, constraints) {
        final isWide = constraints.maxWidth >= 600;
        final destinations = [
          NavigationRailDestination(icon: const Icon(Icons.restaurant_menu), label: Text(l10n.recipes)),
          NavigationRailDestination(icon: const Icon(Icons.favorite_border), label: Text(l10n.favorites)),
          NavigationRailDestination(icon: const Icon(Icons.settings), label: Text(l10n.settings)),
        ];

        if (isWide) {
          return Scaffold(
            body: Row(
              children: [
                NavigationRail(
                  selectedIndex: _index,
                  onDestinationSelected: (i) => setState(() => _index = i),
                  labelType: NavigationRailLabelType.all,
                  destinations: destinations,
                ),
                const VerticalDivider(width: 1),
                Expanded(child: IndexedStack(index: _index, children: screens)),
              ],
            ),
          );
        }

        return Scaffold(
          body: IndexedStack(index: _index, children: screens),
          bottomNavigationBar: NavigationBar(
            selectedIndex: _index,
            onDestinationSelected: (i) => setState(() => _index = i),
            destinations: [
              NavigationDestination(icon: const Icon(Icons.restaurant_menu), label: l10n.recipes),
              NavigationDestination(icon: const Icon(Icons.favorite_border), label: l10n.favorites),
              NavigationDestination(icon: const Icon(Icons.settings), label: l10n.settings),
            ],
          ),
        );
      },
    );
  }
}
