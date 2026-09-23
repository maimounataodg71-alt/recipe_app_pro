import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:recipe_app_pro/widgets/category_filter_chips.dart';
import 'package:recipe_app_pro/widgets/empty_state.dart';

void main() {
  testWidgets('EmptyState affiche le message fourni', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(home: Scaffold(body: EmptyState(message: 'Rien à afficher.'))),
    );

    expect(find.text('Rien à afficher.'), findsOneWidget);
    expect(find.byIcon(Icons.search_off), findsOneWidget);
  });

  testWidgets('CategoryFilterChips affiche toutes les catégories et notifie la sélection', (tester) async {
    String? selectedCategory;

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: CategoryFilterChips(
            categories: const ['Toutes', 'Dessert', 'Entrée'],
            selected: 'Toutes',
            onSelected: (category) => selectedCategory = category,
          ),
        ),
      ),
    );

    expect(find.text('Dessert'), findsOneWidget);

    await tester.tap(find.text('Dessert'));
    await tester.pump();

    expect(selectedCategory, 'Dessert');
  });
}
