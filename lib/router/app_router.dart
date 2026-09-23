import 'package:go_router/go_router.dart';

import '../data/favorites_controller.dart';
import '../screens/add_recipe_screen.dart';
import '../screens/home_shell.dart';
import '../screens/recipe_detail_screen.dart';

GoRouter buildAppRouter(FavoritesController favoritesController) {
  return GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => HomeShell(favoritesController: favoritesController),
      ),
      GoRoute(
        path: '/recipe/:id',
        builder: (context, state) {
          final id = state.pathParameters['id']!;
          return RecipeDetailScreen(recipeId: id, favoritesController: favoritesController);
        },
      ),
      GoRoute(
        path: '/add',
        builder: (context, state) => const AddRecipeScreen(),
      ),
    ],
  );
}
