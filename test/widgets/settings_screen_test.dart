import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:recipe_app_pro/l10n/app_localizations.dart';
import 'package:recipe_app_pro/l10n/locale_controller.dart';
import 'package:recipe_app_pro/screens/settings_screen.dart';
import 'package:recipe_app_pro/theme/theme_controller.dart';

void main() {
  setUp(() {
    SharedPreferences.setMockInitialValues({});
  });

  Widget buildApp() {
    return const MaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: SettingsScreen(),
    );
  }

  testWidgets('affiche le sélecteur de mode sombre et de langue', (tester) async {
    await tester.pumpWidget(buildApp());
    await tester.pump();

    expect(find.byType(SwitchListTile), findsOneWidget);
    expect(find.byType(DropdownButton<Locale>), findsOneWidget);
  });

  testWidgets('bascule le mode sombre au clic', (tester) async {
    ThemeController.mode.value = ThemeMode.light;
    await tester.pumpWidget(buildApp());
    await tester.pump();

    await tester.tap(find.byType(SwitchListTile));
    await tester.pump();

    expect(ThemeController.mode.value, ThemeMode.dark);
    ThemeController.mode.value = ThemeMode.light;
  });

  testWidgets('change la langue via le menu déroulant', (tester) async {
    LocaleController.locale.value = const Locale('fr');
    await tester.pumpWidget(buildApp());
    await tester.pump();

    await tester.tap(find.byType(DropdownButton<Locale>));
    await tester.pumpAndSettle();
    await tester.tap(find.text('English').last);
    await tester.pumpAndSettle();

    expect(LocaleController.locale.value.languageCode, 'en');
    LocaleController.locale.value = const Locale('fr');
  });
}