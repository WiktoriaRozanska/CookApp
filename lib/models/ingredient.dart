import 'package:json_annotation/json_annotation.dart';

part 'ingredient.g.dart';

enum Units {
  grams,
  kilograms,
  slice,
  teaspoon,
  tablespoon,
  cup,
  pint,
  mililiter,
  liter
}

@JsonSerializable()
class Ingredient {
  String? name;
  double? quantity;
  Units? unit;

  Ingredient({this.name, this.quantity, this.unit});

  factory Ingredient.fromJson(Map<String, dynamic> json) =>
      _$IngredientFromJson(json);

  Map<String, dynamic> toJson() => _$IngredientToJson(this);
}
