# Recipe App Pro

![CI](https://github.com/<votre-utilisateur>/<nom-du-repo>/actions/workflows/ci.yml/badge.svg)

Application Flutter de gestion de recettes, portée à un niveau **prêt pour la production** : suite de tests complète, internationalisation, accessibilité, performance optimisée, et intégration continue.

## Sommaire

- [Fonctionnalités](#fonctionnalités)
- [Architecture](#architecture)
- [Prérequis](#prérequis)
- [Installation](#installation)
- [Lancer l'application](#lancer-lapplication)
- [Tests](#tests)
- [Performance et accessibilité](#performance-et-accessibilité)
- [Internationalisation](#internationalisation)
- [CI/CD](#cicd)
- [Captures d'écran](#captures-décran)
- [Changelog](#changelog)

## Fonctionnalités

- **5 écrans** : liste des recettes (recherche + filtre), détail, ajout (formulaire validé), favoris, réglages
- **Favoris persistés** localement (`shared_preferences`)
- **Thème clair/sombre** et **langue FR/EN**, persistés et modifiables dans les Réglages
- **Design responsive** : navigation par onglets en bas sur mobile, `NavigationRail` sur tablette/desktop

## Architecture

Architecture en couches, feature-agnostique (projet de taille modérée, pas de découpage par feature) :

```
lib/
├── main.dart                    # Point d'entrée : charge thème/langue/favoris avant de lancer l'app
├── app.dart                     # Racine : thème, langue, routeur, injection du FavoritesController
├── models/
│   └── recipe.dart              # Modèle de données pur (aucune dépendance UI)
├── data/
│   ├── recipe_repository.dart   # Source unique des recettes (ChangeNotifier)
│   └── favorites_controller.dart# Gestion des favoris, persistée (ChangeNotifier)
├── theme/
│   ├── app_theme.dart           # ThemeData clair/sombre
│   └── theme_controller.dart    # Bascule + persistance du thème
├── l10n/
│   ├── app_localizations.dart   # Localisation FR/EN (délégué léger, sans codegen)
│   └── locale_controller.dart   # Bascule + persistance de la langue
├── router/
│   └── app_router.dart          # Toutes les routes GoRouter
├── screens/                     # Les 5 écrans + la coquille de navigation
└── widgets/                     # Composants réutilisables (RecipeCard, EmptyState...)
```

**Séparation des responsabilités** : les widgets et écrans ne contiennent aucune donnée codée en dur — tout provient de `RecipeRepository` et `FavoritesController`, tous deux testables indépendamment de l'UI.

## Prérequis

- [Flutter SDK](https://docs.flutter.dev/get-started/install) ≥ 3.24 (`flutter --version` pour vérifier)

## Installation

```bash
git clone <url-de-votre-repo>
cd recipe_app_pro
flutter pub get
```

Ce projet est livré sans les dossiers de plateforme. Génère-les une seule fois :

```bash
flutter create .
```

## Lancer l'application

```bash
flutter run -d chrome
```

## Tests

Le projet comprend trois niveaux de tests, comme exigé pour une livraison de production :

| Type | Quantité | Commande |
|---|---|---|
| Tests unitaires | 11 | `flutter test test/data test/controllers` |
| Tests widgets | 12 | `flutter test test/widgets` |
| Tests d'intégration | 2 | `flutter test integration_test/app_test.dart -d chrome` |

Tout lancer d'un coup (unitaires + widgets) :

```bash
flutter test
```

Avec couverture de code :

```bash
flutter test --coverage
```

### Détail des tests

- **`test/data/recipe_repository_test.dart`** — recherche par titre/catégorie, ajout avec notification, résolution couleur/icône, tri des catégories
- **`test/controllers/favorites_controller_test.dart`** — ajout/retrait, notification, persistance entre instances
- **`test/widgets/`** — rendu et interactions de `RecipeCard`, `EmptyState`, `CategoryFilterChips`, validation du formulaire d'ajout, état vide/peuplé des favoris, bascule thème/langue
- **`integration_test/app_test.dart`** — parcours complet "ajouter une recette puis la retrouver dans la liste", et "marquer un favori puis le retrouver dans l'onglet Favoris"

## Performance et accessibilité

- **`const`** utilisé systématiquement partout où c'est possible, pour limiter les reconstructions de widgets
- **`ValueKey`** sur les éléments de liste (grille de recettes) pour que Flutter ne reconstruise que ce qui a réellement changé
- **`RepaintBoundary`** autour des zones illustrées (icônes colorées de recette) pour isoler leur repaint du reste de l'écran
- **Semantics et labels** explicites sur les boutons favoris, les filtres de catégorie et le sélecteur de thème, pour une navigation correcte au lecteur d'écran
- Aucune image réseau non maîtrisée : les illustrations sont des icônes Material vectorielles (légères, sans latence de chargement)

## Internationalisation

Français (par défaut) et anglais, implémentés via un délégué de localisation léger (`lib/l10n/app_localizations.dart`), sans génération de code — adapté à la taille de ce projet. La langue se change dans **Réglages → Langue**, et le choix est persisté.

## CI/CD

Le pipeline GitHub Actions (`.github/workflows/ci.yml`) s'exécute à chaque push et pull request vers `main` :

1. `dart format --set-exit-if-changed` — vérifie le formatage
2. `flutter analyze` — analyse statique, doit être sans erreur
3. `flutter test --coverage` — tests unitaires et widgets, avec rapport de couverture publié en artefact
4. `flutter test integration_test/app_test.dart -d chrome` — tests d'intégration, dans un job séparé qui ne démarre qu'après la réussite du premier

## Captures d'écran

*(à ajouter après un premier lancement local — dossier suggéré : `docs/screenshots/`)*

| Liste | Détail | Ajout | Favoris | Réglages |
|---|---|---|---|---|
| _à venir_ | _à venir_ | _à venir_ | _à venir_ | _à venir_ |

## Changelog

Voir [CHANGELOG.md](./CHANGELOG.md) pour l'historique détaillé des versions.
