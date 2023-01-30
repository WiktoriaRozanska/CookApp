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
  bool? owner = false;
  String? imageUrl;

  RecipeItem(
      {this.id,
      required this.title,
      required this.description,
      required this.ingredients,
      required this.time,
      required this.calPerServ,
      required this.yields,
      required this.steps,
      required this.tags,
      this.isFavorite,
      this.owner,
      this.imageUrl});

  factory RecipeItem.fromJson(Map<String, dynamic> json) =>
      _$RecipeItemFromJson(json);

  Map<String, dynamic> toJson() => _$RecipeItemToJson(this);

  String? get imgUrl {
    return 'http://10.0.2.2:3000/${imageUrl}';
  }
}
