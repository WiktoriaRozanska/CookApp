import 'package:cook_app/models/shopping_list_item.dart';
import 'package:cook_app/providers/shopping_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ShoppingListScreen extends StatefulWidget {
  static const routeName = '/shopping_list';

  @override
  _ShoppingListScreenState createState() => _ShoppingListScreenState();
}

class _ShoppingListScreenState extends State<ShoppingListScreen> {
  var _isLoading = true;
  bool? val = false;
  ShoppingListProvider? shoppingListProvider;
  List<ShoppingListItem> shoppingList = [];

  @override
  void initState() {
    shoppingListProvider =
        Provider.of<ShoppingListProvider>(context, listen: false);
    Future.delayed(Duration.zero).then((_) {
      shoppingListProvider!.fetchShoppingList().then((value) {
        setState(() {
          // print(value);
          shoppingList = value;
          _isLoading = false;
        });
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? Scaffold(
            body: Center(
            child: CircularProgressIndicator(
              color: Theme.of(context).primaryColor,
            ),
          ))
        : Scaffold(
            appBar: AppBar(
              title: const Text('Your shopping list'),
            ),
            body: SingleChildScrollView(
              child: Column(
                children: shoppingList.map((item) {
                  return CheckboxListTile(
                    title: Text(
                      item.name,
                      style: TextStyle(
                          color: item.isChecked ? Colors.grey : Colors.black,
                          decoration: item.isChecked
                              ? TextDecoration.lineThrough
                              : null),
                    ),
                    subtitle: Text(
                      item.subtitle,
                      style: TextStyle(
                          color: item.isChecked
                              ? Colors.grey[400]
                              : Colors.grey[600],
                          decoration: item.isChecked
                              ? TextDecoration.lineThrough
                              : null),
                    ),
                    value: item.isChecked,
                    onChanged: (value) {
                      setState(() {
                        if (value != null) {
                          item.isChecked = value;
                        }
                      });
                    },
                    activeColor: Theme.of(context).primaryColor,
                  );
                }).toList(),
              ),
            ),
          );
  }
}
