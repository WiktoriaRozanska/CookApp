import 'package:cook_app/models/ingredient.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cook_app/providers/recipe.dart';

class IngredientScreen extends StatelessWidget {
  static const routeName = '/ingredient';
  @override
  Widget build(BuildContext context) {
    final _recipe = Provider.of<Recipe>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Add ingredient'),
      ),
      body: Column(
        children: [
          RaisedButton(
            onPressed: () {
              _recipe.addIngredients(Ingredient(
                  name: 'Name', quantity: 12.0, unit: Units.kilograms));
            },
            child: const Text(
              'Add',
              style: TextStyle(color: Colors.white),
            ),
            color: Theme.of(context).primaryColor,
          )
        ],
      ),
    );
  }
}
