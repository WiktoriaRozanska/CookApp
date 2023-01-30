// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'week_plan.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WeekPlan _$WeekPlanFromJson(Map<String, dynamic> json) => WeekPlan(
      id: json['id'] as int,
      days: (json['days'] as List<dynamic>)
          .map((e) => Day.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$WeekPlanToJson(WeekPlan instance) => <String, dynamic>{
      'id': instance.id,
      'days': instance.days,
    };
