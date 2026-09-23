import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:recipe_app_pro/l10n/app_localizations.dart';
import 'package:recipe_app_pro/screens/add_recipe_screen.dart';

void main() {
  Widget buildApp() {
    final router = GoRouter(
      initialLocation: '/add',
      routes: [
        GoRoute(path: '/add', builder: (context, state) => const AddRecipeScreen()),
      ],
    );
    return MaterialApp.router(
      routerConfig: router,
      locale: const Locale('fr'),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
    );
  }

  testWidgets('affiche les erreurs de validation si le formulaire est vide', (tester) async {
    await tester.pumpWidget(buildApp());
    await tester.pump();

    await tester.tap(find.text('Enregistrer'));
    await tester.pump();

    expect(find.text('Le titre doit contenir au moins 3 caractères.'), findsOneWidget);
    expect(find.text('Choisis une catégorie.'), findsOneWidget);
    expect(find.text('Choisis un niveau de difficulté.'), findsOneWidget);
  });

  testWidgets('affiche bien les 3 champs de texte et les 2 menus déroulants', (tester) async {
    await tester.pumpWidget(buildApp());
    await tester.pump();

    expect(find.byType(TextFormField), findsNWidgets(3));
    expect(find.byType(DropdownButtonFormField<String>), findsNWidgets(2));
  });
}
