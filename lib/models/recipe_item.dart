import 'package:cook_app/models/ingredient.dart';

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
