import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:cook_app/models/shopping_list_item.dart';
import 'package:http/http.dart' as http;

class ShoppingListProvider with ChangeNotifier {
  List<ShoppingListItem> shoppingList = [];

  List<ShoppingListItem> get listOfIngredients {
    return shoppingList;
  }

  Future<List<ShoppingListItem>> fetchShoppingList() async {
    var url = Uri.parse('http://10.0.2.2:3000/v1/shopping_list');
    final response =
        await http.get(url, headers: {"Content-Type": "application/json"});
    Map<String, dynamic> listMap = jsonDecode(response.body);

    shoppingList = (listMap['shopping_list'] as List).map((listItem) {
      return ShoppingListItem.fromJson(listItem);
    }).toList();

    return shoppingList;
  }
}
