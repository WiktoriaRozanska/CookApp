import 'package:cook_app/models/simple_recipe_item.dart';
import 'package:json_annotation/json_annotation.dart';

part 'day.g.dart';

@JsonSerializable()
class Day {
  int id;
  String name;
  int position;
  List<SimpleRecipeItem> recipes;

  Day(
      {required this.id,
      required this.name,
      required this.position,
      required this.recipes});

  factory Day.fromJson(Map<String, dynamic> json) => _$DayFromJson(json);

  Map<String, dynamic> toJson() => _$DayToJson(this);
}
