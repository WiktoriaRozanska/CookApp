import 'package:cook_app/models/day.dart';
import 'package:json_annotation/json_annotation.dart';

part 'week_plan.g.dart';

@JsonSerializable()
class WeekPlan {
  int id;
  List<Day> days;

  WeekPlan({required this.id, required this.days});

  factory WeekPlan.fromJson(Map<String, dynamic> json) =>
      _$WeekPlanFromJson(json);

  Map<String, dynamic> toJson() => _$WeekPlanToJson(this);
}
