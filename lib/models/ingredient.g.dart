// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ingredient.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Ingredient _$IngredientFromJson(Map<String, dynamic> json) => Ingredient(
      name: json['name'] as String?,
      quantity: (json['quantity'] as num?)?.toDouble(),
      unit: $enumDecodeNullable(_$UnitsEnumMap, json['unit']),
    );

Map<String, dynamic> _$IngredientToJson(Ingredient instance) =>
    <String, dynamic>{
      'name': instance.name,
      'quantity': instance.quantity,
      'unit': _$UnitsEnumMap[instance.unit],
    };

const _$UnitsEnumMap = {
  Units.grams: 'grams',
  Units.kilograms: 'kilograms',
  Units.slice: 'slice',
  Units.teaspoon: 'teaspoon',
  Units.tablespoon: 'tablespoon',
  Units.cup: 'cup',
  Units.pint: 'pint',
  Units.mililiter: 'mililiter',
  Units.liter: 'liter',
};
