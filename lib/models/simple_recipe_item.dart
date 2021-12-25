import 'package:json_annotation/json_annotation.dart';

part 'simple_recipe_item.g.dart';

@JsonSerializable()
class SimpleRecipeItem {
  String id;
  String title;

  SimpleRecipeItem({required this.id, required this.title});

  factory SimpleRecipeItem.fromJson(Map<String, dynamic> json) =>
      _$SimpleRecipeItemFromJson(json);

  Map<String, dynamic> toJson() => _$SimpleRecipeItemToJson(this);
}
