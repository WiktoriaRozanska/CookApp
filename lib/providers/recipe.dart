import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:cook_app/models/ingredient.dart';
import 'package:http/http.dart' as http;
import '../models/recipe_item.dart';

class Recipe with ChangeNotifier {
  RecipeItem _recipe = RecipeItem(
      title: '',
      description: '',
      ingredients: [],
      steps: [],
      tags: [],
      time: 0,
      calPerServ: 0,
      yields: 0);

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

  void addTime(int time) {
    _recipe.time = time;
  }

  void addCalPerServ(int calPerServ) {
    _recipe.calPerServ = calPerServ;
  }

  void addYields(int yields) {
    _recipe.yields = yields;
  }

  void removeTag(int index) {
    _recipe.tags.removeAt(index);
  }

  String get title {
    return _recipe.title;
  }

  int get time {
    return _recipe.time;
  }

  int get calPerServ {
    return _recipe.calPerServ;
  }

  int get yields {
    return _recipe.yields;
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

  Future<RecipeItem> send() async {
    print('will send to BE');
    Map<String, dynamic> jsonRecipe = _recipe.toJson();
    var url = Uri.parse('http://10.0.2.2:3000/v1/recipes');
    final response = await http.post(url,
        body: json.encode({'recipe': jsonRecipe}),
        headers: {"Content-Type": "application/json"});

    Map<String, dynamic> recipeMap = jsonDecode(response.body);
    clear();
    return RecipeItem.fromJson(recipeMap);
  }

  Future<RecipeItem> fetchRecipe(String id) async {
    var url = Uri.parse('http://10.0.2.2:3000/v1/recipes/${id}');
    final response =
        await http.get(url, headers: {"Content-Type": "application/json"});
    Map<String, dynamic> recipeMap = jsonDecode(response.body);
    _recipe = RecipeItem.fromJson(recipeMap);
    return _recipe;
  }

  Future<List<RecipeItem>> fetchRecipes(int startIndex, int size) async {
    final qParameters = {
      'startIndex': startIndex.toString(),
      'size': size.toString()
    };
    var url = Uri.http('10.0.2.2:3000', '/v1/recipes', qParameters);

    final response = await http.get(
      url,
      headers: {"Content-Type": "application/json"},
    );

    List<dynamic> recipeList = jsonDecode(response.body);
    List<RecipeItem> recipes = recipeList.map((recipe) {
      return RecipeItem.fromJson(recipe);
    }).toList();
    return recipes;
  }
}
