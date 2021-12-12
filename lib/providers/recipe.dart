import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:cook_app/models/ingredient.dart';
import 'package:http/http.dart' as http;

class RecipeItem {
  String title;
  String description;
  List<Ingredient> ingredients;
  List<String> steps;
  List<String> tags;

  RecipeItem({
    required this.title,
    required this.description,
    required this.ingredients,
    required this.steps,
    required this.tags,
  });
}

class Recipe with ChangeNotifier {
  RecipeItem _recipe = RecipeItem(
      title: '', description: '', ingredients: [], steps: [], tags: []);

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

  void addTag(String tag) {
    _recipe.tags.add(tag);
  }

  void removeTag(int index) {
    _recipe.tags.removeAt(index);
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

  List<String> get tags {
    return _recipe.tags;
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

  void send() {
    print('will send to BE');
  }
}
