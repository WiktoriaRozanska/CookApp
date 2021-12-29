import 'package:json_annotation/json_annotation.dart';

part 'simple_recipe_item.g.dart';

@JsonSerializable()
class SimpleRecipeItem {
  String id;
  String title;
  String? imageUrl;

  SimpleRecipeItem({required this.id, required this.title, this.imageUrl});

  String? get imgUrl {
    return 'http://10.0.2.2:3000/${imageUrl}';
  }

  factory SimpleRecipeItem.fromJson(Map<String, dynamic> json) =>
      _$SimpleRecipeItemFromJson(json);

  Map<String, dynamic> toJson() => _$SimpleRecipeItemToJson(this);
}
