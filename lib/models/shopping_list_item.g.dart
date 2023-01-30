// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'shopping_list_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ShoppingListItem _$ShoppingListItemFromJson(Map<String, dynamic> json) =>
    ShoppingListItem(
      name: json['name'] as String,
      unit: json['unit'] as String,
      quantity: json['quantity'] as int,
      isChecked: json['isChecked'] as bool? ?? false,
    );

Map<String, dynamic> _$ShoppingListItemToJson(ShoppingListItem instance) =>
    <String, dynamic>{
      'name': instance.name,
      'unit': instance.unit,
      'quantity': instance.quantity,
      'isChecked': instance.isChecked,
    };
