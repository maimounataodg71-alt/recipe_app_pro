import 'package:flutter/material.dart';

/// Représente une recette. Données pures, sans dépendance à l'UI ni au
/// stockage — testable en isolation.
@immutable
class Recipe {
  final String id;
  final String title;
  final String category;
  final int prepMinutes;
  final String difficulty;
  final String description;
  final IconData icon;
  final Color color;

  const Recipe({
    required this.id,
    required this.title,
    required this.category,
    required this.prepMinutes,
    required this.difficulty,
    required this.description,
    required this.icon,
    required this.color,
  });
}
