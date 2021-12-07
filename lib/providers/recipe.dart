import 'package:flutter/material.dart';
import 'package:cook_app/models/ingredient.dart';

class RecipeItem {
  String title;
  String description;
  List<Ingredient> ingredients;
  List<String> steps;

  RecipeItem({
    required this.title,
    required this.description,
    required this.ingredients,
    required this.steps,
  });
}

class Recipe with ChangeNotifier {
  RecipeItem _recipe =
      RecipeItem(title: '', description: '', ingredients: [], steps: []);

  void addTitle(String title) {
    _recipe.title = title;
    notifyListeners();
  }

  void addDescription(String description) {
    _recipe.description = description;
    notifyListeners();
  }

  void addIngredients(Ingredient ingredient) {
    _recipe.ingredients.add(ingredient);
    notifyListeners();
  }

  void addStep(String step) {
    _recipe.steps.add(step);
    notifyListeners();
  }

  String get title {
    return _recipe.title;
  }

  String get description {
    return _recipe.description;
  }

  List<String> get steps {
    return _recipe.steps;
  }

  List<Ingredient> get ingredients {
    return _recipe.ingredients;
  }

  void clear() {
    _recipe.title = '';
    _recipe.description = '';
    _recipe.ingredients = [];
    _recipe.steps = [];
    notifyListeners();
  }
}
