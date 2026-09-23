import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../data/recipe_repository.dart';
import '../l10n/app_localizations.dart';
import '../models/recipe.dart';
import '../widgets/custom_text_field.dart';

class AddRecipeScreen extends StatefulWidget {
  const AddRecipeScreen({super.key});

  @override
  State<AddRecipeScreen> createState() => _AddRecipeScreenState();
}

class _AddRecipeScreenState extends State<AddRecipeScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _prepController = TextEditingController();
  final _descriptionController = TextEditingController();
  String? _category;
  String? _difficulty;

  @override
  void dispose() {
    _titleController.dispose();
    _prepController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  void _submit() {
    final isValid = _formKey.currentState?.validate() ?? false;
    if (!isValid) return;

    final newRecipe = Recipe(
      id: DateTime.now().microsecondsSinceEpoch.toString(),
      title: _titleController.text.trim(),
      category: _category!,
      prepMinutes: int.parse(_prepController.text.trim()),
      difficulty: _difficulty!,
      description: _descriptionController.text.trim(),
      icon: RecipeRepository.iconForCategory(_category!),
      color: RecipeRepository.colorForCategory(_category!),
    );

    RecipeRepository.instance.add(newRecipe);
    if (context.mounted) context.pop();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return Scaffold(
      appBar: AppBar(title: Text(l10n.addRecipe)),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              CustomTextField(
                controller: _titleController,
                label: l10n.title,
                prefixIcon: Icons.title,
                validator: (value) {
                  if (value == null || value.trim().length < 3) return l10n.titleTooShort;
                  return null;
                },
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
              initialValue: _category,
                decoration: InputDecoration(labelText: l10n.category, border: const OutlineInputBorder()),
                items: RecipeRepository.availableCategories
                    .map((c) => DropdownMenuItem(value: c, child: Text(c)))
                    .toList(),
                onChanged: (value) => setState(() => _category = value),
                validator: (value) => value == null ? l10n.chooseCategory : null,
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
               initialValue: _difficulty,
                decoration: InputDecoration(labelText: l10n.difficulty, border: const OutlineInputBorder()),
                items: RecipeRepository.availableDifficulties
                    .map((d) => DropdownMenuItem(value: d, child: Text(d)))
                    .toList(),
                onChanged: (value) => setState(() => _difficulty = value),
                validator: (value) => value == null ? l10n.chooseDifficulty : null,
              ),
              const SizedBox(height: 16),
              CustomTextField(
                controller: _prepController,
                label: l10n.prepTime,
                prefixIcon: Icons.timer,
                keyboardType: TextInputType.number,
                validator: (value) {
                  final n = int.tryParse(value ?? '');
                  if (n == null || n <= 0) return l10n.invalidMinutes;
                  return null;
                },
              ),
              const SizedBox(height: 16),
              CustomTextField(
                controller: _descriptionController,
                label: l10n.description,
                prefixIcon: Icons.description,
                maxLines: 4,
                validator: (value) {
                  if (value == null || value.trim().length < 10) return l10n.descriptionTooShort;
                  return null;
                },
              ),
              const SizedBox(height: 24),
              ElevatedButton.icon(
                onPressed: _submit,
                icon: const Icon(Icons.check),
                label: Text(l10n.save),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
