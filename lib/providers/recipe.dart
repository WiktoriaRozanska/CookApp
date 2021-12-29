import 'dart:convert';

import 'package:cook_app/models/week_plan.dart';
import 'package:flutter/material.dart';
import 'package:cook_app/models/ingredient.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import '../models/recipe_item.dart';
import 'package:flutter/foundation.dart';
import 'package:cook_app/models/day.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class Recipe with ChangeNotifier {
  final String? authToke;
  XFile? _image;

  Recipe(this.authToke);

  RecipeItem _recipe = RecipeItem(
      title: '',
      description: '',
      ingredients: [],
      steps: [],
      tags: [],
      time: 0,
      calPerServ: 0,
      yields: 0);

  List<dynamic> _allTags = [];
  List<dynamic> _selectedTags = [];
  WeekPlan? _weekPlan;

  void addTitle(String title) {
    _recipe.title = title;
    notifyListeners();
  }

  void addImage(XFile? img) {
    _image = img;
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

  String? get imageUrl {
    return 'http://10.0.2.2:3000/${_recipe.imageUrl}';
  }

  bool get liked {
    if (_recipe.isFavorite == null) {
      return false;
    }
    return _recipe.isFavorite!;
  }

  bool get owner {
    if (_recipe.owner == null) {
      return false;
    }
    return _recipe.owner!;
  }

  void clear() {
    _recipe.title = '';
    _recipe.description = '';
    _recipe.ingredients = [];
    _recipe.steps = [];
    _image = null;
    notifyListeners();
  }

  Future<RecipeItem> send() async {
    print('will send to BE');
    Map<String, dynamic> jsonRecipe = _recipe.toJson();
    var url = Uri.parse('http://10.0.2.2:3000/v1/recipes');
    final response = await http.post(
      url,
      body: json.encode({'recipe': jsonRecipe}),
      headers: {
        "Content-Type": "application/json",
        "Authorization": '${authToke}'
      },
    );

    Map<String, dynamic> recipeMap = jsonDecode(response.body);

    RecipeItem recipeItem = RecipeItem.fromJson(recipeMap);

    //--------------------------------------------------------------------------

    if (_image != null) {
      var imgUrl =
          Uri.parse('http://10.0.2.2:3000/v1/recipes/${recipeItem.id}/image');

      var request = http.MultipartRequest("POST", imgUrl);
      request.fields['title'] = 'dummyTest';
      request.headers['Content-Type'] = 'application/json';
      request.headers['Authorization'] = '${authToke}';

      File file = File(_image!.path);

      //     var bytes = element.readAsBytes();
      // request.files.add(new http.MultipartFile.fromBytes('file', await bytes));
      var bytes = file.readAsBytes();

      // var picture = http.MultipartFile.fromBytes(
      //     'image', (await rootBundle.load(_image!.path)).buffer.asUint8List(),
      //     filename: 'testImg.png');

      // request.files.add(http.MultipartFile.fromBytes('image', await bytes));
      request.files
          .add(await http.MultipartFile.fromPath('image', _image!.path));

      var response = await request.send();
      var res = await http.Response.fromStream(response);
      print(res.statusCode);
      print(res.body);

      Map<String, dynamic> recipeMap = jsonDecode(res.body);

      recipeItem = RecipeItem.fromJson(recipeMap);
    }

    clear();
    return recipeItem;
  }

  Future<RecipeItem> fetchRecipe(String id) async {
    var url = Uri.parse('http://10.0.2.2:3000/v1/recipes/${id}');
    final response = await http.get(
      url,
      headers: {
        "Content-Type": "application/json",
        "Authorization": '${authToke}'
      },
    );
    Map<String, dynamic> recipeMap = jsonDecode(response.body);
    _recipe = RecipeItem.fromJson(recipeMap);
    return _recipe;
  }

  Future<void> addToFavorite(String recipeId) async {
    // /v1/recipe/favorites
    var url = Uri.parse('http://10.0.2.2:3000/v1/recipe/favorites');
    await http.post(
      url,
      body: json.encode({'recipe_id': recipeId}),
      headers: {
        "Content-Type": "application/json",
        "Authorization": '${authToke}'
      },
    );
  }

  Future<void> removeFromFavorite(String recipeId) async {
    // /v1/recipe/favorites
    var url = Uri.parse('http://10.0.2.2:3000/v1/recipe/favorites/${recipeId}');
    await http.delete(
      url,
      headers: {
        "Content-Type": "application/json",
        "Authorization": '${authToke}'
      },
    );
  }

  Future<List<RecipeItem>> fetchRecipes(
      int startIndex, int size, List<dynamic> filters) async {
    final qParameters = {
      'startIndex': startIndex.toString(),
      'size': size.toString(),
      'filters[]': filters.map((tag) => tag['id'].toString()),
    };
    var url = Uri.http('10.0.2.2:3000', '/v1/recipes', qParameters);

    final response = await http.get(
      url,
      headers: {
        "Content-Type": "application/json",
        "Authorization": '${authToke}'
      },
    );

    List<dynamic> recipeList = jsonDecode(response.body);
    List<RecipeItem> recipes = recipeList.map((recipe) {
      return RecipeItem.fromJson(recipe);
    }).toList();
    return recipes;
  }

  Future<List<RecipeItem>> fetchFavoriteRecipes(
      int startIndex, int size) async {
    final qParameters = {
      'startIndex': startIndex.toString(),
      'size': size.toString(),
    };
    var url = Uri.http('10.0.2.2:3000', '/v1/recipe/favorites', qParameters);

    final response = await http.get(
      url,
      headers: {
        "Content-Type": "application/json",
        "Authorization": '${authToke}'
      },
    );

    List<dynamic> recipeList = jsonDecode(response.body);
    List<RecipeItem> recipes = recipeList.map((recipe) {
      return RecipeItem.fromJson(recipe);
    }).toList();
    return recipes;
  }

  Future<List<RecipeItem>> fetchMyRecipes(int startIndex, int size) async {
    final qParameters = {
      'startIndex': startIndex.toString(),
      'size': size.toString(),
    };
    var url = Uri.http('10.0.2.2:3000', '/v1/my_recipes', qParameters);

    final response = await http.get(
      url,
      headers: {
        "Content-Type": "application/json",
        "Authorization": '${authToke}'
      },
    );

    List<dynamic> recipeList = jsonDecode(response.body);
    List<RecipeItem> recipes = recipeList.map((recipe) {
      return RecipeItem.fromJson(recipe);
    }).toList();
    return recipes;
  }

  List<dynamic> get allTags {
    return _allTags;
  }

  Future<List<dynamic>> fetchTags() async {
    var url = Uri.parse('http://10.0.2.2:3000/v1/tags');
    final response = await http.get(
      url,
      headers: {
        "Content-Type": "application/json",
        "Authorization": '${authToke}'
      },
    );

    _allTags = jsonDecode(response.body);

    return _allTags;
  }

  Future<void> addToMenu(String recipeId, List<dynamic> days) async {
    print(recipeId);
    print(days);
    Map<String, dynamic> arguments = {'recipeId': recipeId, 'days': days};
    var url = Uri.parse('http://10.0.2.2:3000/v1/week_plans');

    await http.post(
      url,
      body: json.encode({'weekPlan': arguments}),
      headers: {
        "Content-Type": "application/json",
        "Authorization": '${authToke}'
      },
    );
  }

  void addOrRemove(dynamic tag) {
    bool elementIsInTheList = lisContainsTag(tag);
    if (elementIsInTheList) {
      _selectedTags.removeWhere((element) => element['id'] == tag['id']);
    } else {
      _selectedTags.add(tag);
    }
  }

  Future<void> deleteRecipeFromMenu(String recipeId, int dayId) async {
    var url = Uri.parse(
        'http://10.0.2.2:3000/v1/week_plan/day/${dayId}/recipes/${recipeId}');

    Day day = _weekPlan!.days.firstWhere((day) => day.id == dayId);
    day.recipes.removeWhere((recipe) => recipe.id == recipeId);

    await http.delete(
      url,
      headers: {
        "Content-Type": "application/json",
        "Authorization": '${authToke}'
      },
    );
  }

  WeekPlan updatedRecipePlan() {
    return _weekPlan!;
  }

  Future<WeekPlan> fetchWeekPlan() async {
    var url = Uri.parse('http://10.0.2.2:3000/v1/week_plans');
    final response = await http.get(
      url,
      headers: {
        "Content-Type": "application/json",
        "Authorization": '${authToke}'
      },
    );

    var json = jsonDecode(response.body);
    _weekPlan = WeekPlan.fromJson(json);

    return _weekPlan!;
  }

  List<dynamic> get selectedTags {
    return _selectedTags;
  }

  bool lisContainsTag(Map<String, dynamic> tag) {
    bool isInList = false;
    _selectedTags.forEach((element) {
      if (mapEquals(element, tag)) {
        isInList = true;
      }
    });
    return isInList;
  }

  void removeTagFromList(dynamic tag) {
    _selectedTags.removeWhere((element) => element['id'] == tag['id']);
  }

  void addTagtoList(dynamic tag) {
    _selectedTags.add(tag);
  }

  Future<List<RecipeItem>> fetchFavorites(
      int startIndex, int size, List<dynamic> filters) async {
    final qParameters = {
      'startIndex': startIndex.toString(),
      'size': size.toString(),
      'filters[]': filters.map((tag) => tag['id'].toString()),
    };
    var url = Uri.http('10.0.2.2:3000', '/v1/recipes/favorites', qParameters);

    final response = await http.get(
      url,
      headers: {
        "Content-Type": "application/json",
        "Authorization": '${authToke}'
      },
    );

    List<dynamic> recipeList = jsonDecode(response.body);
    List<RecipeItem> recipes = recipeList.map((recipe) {
      return RecipeItem.fromJson(recipe);
    }).toList();
    return recipes;
  }

  Future<void> deleteRecipe(String recipeId) async {
    var url = Uri.parse('http://10.0.2.2:3000/v1/recipes/${recipeId}');
    ;

    await http.delete(
      url,
      headers: {
        "Content-Type": "application/json",
        "Authorization": '${authToke}'
      },
    );
  }
}
