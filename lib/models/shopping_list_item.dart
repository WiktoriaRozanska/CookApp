import 'package:json_annotation/json_annotation.dart';

part 'shopping_list_item.g.dart';

@JsonSerializable()
class ShoppingListItem {
  String name;
  String unit;
  int quantity;
  bool isChecked;

  ShoppingListItem(
      {required this.name,
      required this.unit,
      required this.quantity,
      this.isChecked = false});

  String get title {
    return name;
  }

  String get subtitle {
    return '${quantity} ${unit}';
  }

  void swapChecked() {
    isChecked != isChecked;
  }

  bool get value {
    return isChecked;
  }

  factory ShoppingListItem.fromJson(Map<String, dynamic> json) =>
      _$ShoppingListItemFromJson(json);

  Map<String, dynamic> toJson() => _$ShoppingListItemToJson(this);
}
