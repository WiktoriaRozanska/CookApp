// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'day.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Day _$DayFromJson(Map<String, dynamic> json) => Day(
      id: json['id'] as int,
      name: json['name'] as String,
      position: json['position'] as int,
      recipes: (json['recipes'] as List<dynamic>)
          .map((e) => SimpleRecipeItem.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$DayToJson(Day instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'position': instance.position,
      'recipes': instance.recipes,
    };
