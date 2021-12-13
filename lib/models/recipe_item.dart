import 'package:cook_app/models/ingredient.dart';
import 'package:json_annotation/json_annotation.dart';

part 'recipe_item.g.dart';

@JsonSerializable()
class RecipeItem {
  String? id;
  String title;
  String description;
  int time;
  int calPerServ;
  int yields;
  List<Ingredient> ingredients;
  List<String> steps;
  List<String> tags;
  bool? isFavorite = false;

  RecipeItem({
    this.id,
    required this.title,
    required this.description,
    required this.ingredients,
    required this.time,
    required this.calPerServ,
    required this.yields,
    required this.steps,
    required this.tags,
  });

  factory RecipeItem.fromJson(Map<String, dynamic> json) =>
      _$RecipeItemFromJson(json);

  Map<String, dynamic> toJson() => _$RecipeItemToJson(this);
}
