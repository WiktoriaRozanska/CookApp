// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recipe_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RecipeItem _$RecipeItemFromJson(Map<String, dynamic> json) => RecipeItem(
      title: json['title'] as String,
      description: json['description'] as String,
      ingredients: (json['ingredients'] as List<dynamic>)
          .map((e) => Ingredient.fromJson(e as Map<String, dynamic>))
          .toList(),
      time: json['time'] as int,
      calPerServ: json['calPerServ'] as int,
      yields: json['yields'] as int,
      steps: (json['steps'] as List<dynamic>)
          .map((e) => e['description'] as String)
          .toList(),
      tags: (json['tags'] as List<dynamic>)
          .map((e) => e['name'] as String)
          .toList(),
    );

Map<String, dynamic> _$RecipeItemToJson(RecipeItem instance) =>
    <String, dynamic>{
      'title': instance.title,
      'description': instance.description,
      'time': instance.time,
      'calPerServ': instance.calPerServ,
      'yields': instance.yields,
      'ingredients': instance.ingredients,
      'steps': instance.steps,
      'tags': instance.tags,
    };
