import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

/// Localisation FR/EN implémentée manuellement (sans `flutter gen-l10n`)
/// pour un projet léger : une table de chaînes par langue, accessible via
/// `AppLocalizations.of(context)`.
class AppLocalizations {
  final Locale locale;
  AppLocalizations(this.locale);

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const supportedLocales = [Locale('fr'), Locale('en')];

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = [
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
  ];

  static const Map<String, Map<String, String>> _strings = {
    'fr': {
      'appTitle': 'Mes Recettes',
      'recipes': 'Recettes',
      'favorites': 'Favoris',
      'settings': 'Réglages',
      'search': 'Rechercher une recette',
      'all': 'Toutes',
      'addRecipe': 'Nouvelle recette',
      'title': 'Titre de la recette',
      'category': 'Catégorie',
      'difficulty': 'Difficulté',
      'prepTime': 'Temps de préparation (minutes)',
      'description': 'Description',
      'save': 'Enregistrer',
      'noResults': 'Aucune recette ne correspond à ta recherche.',
      'noFavorites': 'Aucun favori pour l\'instant.',
      'darkMode': 'Mode sombre',
      'language': 'Langue',
      'titleTooShort': 'Le titre doit contenir au moins 3 caractères.',
      'chooseCategory': 'Choisis une catégorie.',
      'chooseDifficulty': 'Choisis un niveau de difficulté.',
      'invalidMinutes': 'Entre un nombre de minutes valide.',
      'descriptionTooShort': 'Décris la recette en au moins 10 caractères.',
      'minutesShort': 'min',
      'retry': 'Réessayer',
      'favoriteAdded': 'Ajouté aux favoris',
      'favoriteRemoved': 'Retiré des favoris',
    },
    'en': {
      'appTitle': 'My Recipes',
      'recipes': 'Recipes',
      'favorites': 'Favorites',
      'settings': 'Settings',
      'search': 'Search for a recipe',
      'all': 'All',
      'addRecipe': 'New recipe',
      'title': 'Recipe title',
      'category': 'Category',
      'difficulty': 'Difficulty',
      'prepTime': 'Preparation time (minutes)',
      'description': 'Description',
      'save': 'Save',
      'noResults': 'No recipe matches your search.',
      'noFavorites': 'No favorites yet.',
      'darkMode': 'Dark mode',
      'language': 'Language',
      'titleTooShort': 'Title must be at least 3 characters.',
      'chooseCategory': 'Choose a category.',
      'chooseDifficulty': 'Choose a difficulty level.',
      'invalidMinutes': 'Enter a valid number of minutes.',
      'descriptionTooShort': 'Describe the recipe in at least 10 characters.',
      'minutesShort': 'min',
      'retry': 'Retry',
      'favoriteAdded': 'Added to favorites',
      'favoriteRemoved': 'Removed from favorites',
    },
  };

  String _t(String key) => _strings[locale.languageCode]?[key] ?? _strings['fr']![key]!;

  String get appTitle => _t('appTitle');
  String get recipes => _t('recipes');
  String get favorites => _t('favorites');
  String get settings => _t('settings');
  String get search => _t('search');
  String get all => _t('all');
  String get addRecipe => _t('addRecipe');
  String get title => _t('title');
  String get category => _t('category');
  String get difficulty => _t('difficulty');
  String get prepTime => _t('prepTime');
  String get description => _t('description');
  String get save => _t('save');
  String get noResults => _t('noResults');
  String get noFavorites => _t('noFavorites');
  String get darkMode => _t('darkMode');
  String get language => _t('language');
  String get titleTooShort => _t('titleTooShort');
  String get chooseCategory => _t('chooseCategory');
  String get chooseDifficulty => _t('chooseDifficulty');
  String get invalidMinutes => _t('invalidMinutes');
  String get descriptionTooShort => _t('descriptionTooShort');
  String get minutesShort => _t('minutesShort');
  String get retry => _t('retry');
  String get favoriteAdded => _t('favoriteAdded');
  String get favoriteRemoved => _t('favoriteRemoved');
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) =>
      AppLocalizations.supportedLocales.any((l) => l.languageCode == locale.languageCode);

  @override
  Future<AppLocalizations> load(Locale locale) async => AppLocalizations(locale);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}
