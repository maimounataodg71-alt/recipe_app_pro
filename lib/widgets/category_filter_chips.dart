import 'package:flutter/material.dart';

class CategoryFilterChips extends StatelessWidget {
  final List<String> categories;
  final String selected;
  final ValueChanged<String> onSelected;

  const CategoryFilterChips({
    super.key,
    required this.categories,
    required this.selected,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 44,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        itemCount: categories.length,
        separatorBuilder: (context, index) => const SizedBox(width: 8),
        itemBuilder: (context, index) {
          final category = categories[index];
          final isSelected = category == selected;
          return Semantics(
            selected: isSelected,
            button: true,
            label: 'Filtrer par $category',
            child: ChoiceChip(
              label: Text(category),
              selected: isSelected,
              onSelected: (_) => onSelected(category),
            ),
          );
        },
      ),
    );
  }
}
