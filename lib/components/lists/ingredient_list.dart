import 'package:cook_app/screens/recepies/new_recipe/ingredient.dart';
import 'package:flutter/material.dart';
import '../../models/ingredient.dart';
import 'package:provider/provider.dart';
import 'package:cook_app/providers/recipe.dart';

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
    final _recipe = Provider.of<Recipe>(context);

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
            trailing: _recipe.editingMood
                ? GestureDetector(
                    child: const Icon(Icons.edit_outlined),
                    onTap: () {
                      _recipe.setIngredientIndexToEdit(
                          ingredients.indexOf(ingredient));
                      Navigator.of(context)
                          .pushNamed(IngredientScreen.routeName);
                    },
                  )
                : null,
          );
        }).toList(),
      ),
    );
  }
}
