import 'package:flutter/material.dart';
import '../../models/ingredient.dart';

class IngredientList extends StatelessWidget {
  List<Ingredient> ingredients;

  static const units = {
    Units.grams: 'grams',
    Units.kilograms: 'kilograms',
    Units.slice: 'slice',
    Units.teaspoon: 'teaspoon',
    Units.cup: 'cup',
    Units.pint: 'pint',
    Units.mililiter: 'mililiter',
    Units.liter: 'liter'
  };

  IngredientList({required this.ingredients});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: Column(
        children: ingredients.map((ingredient) {
          return ListTile(
            leading: CircleAvatar(
              backgroundColor: Theme.of(context).primaryColorLight,
              child: FittedBox(
                child: Text(
                  '${ingredients.indexOf(ingredient) + 1}',
                  style: const TextStyle(color: Colors.white),
                ),
              ),
            ),
            title: Text('${ingredient.name}'),
            subtitle: Text('${ingredient.quantity} ${units[ingredient.unit]}'),
          );
        }).toList(),
      ),
    );
  }
}
