import 'package:flutter/material.dart';
import '../../models/ingredient.dart';

class IngredientList extends StatelessWidget {
  List<Ingredient> ingredients;

  IngredientList({required this.ingredients});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (ctx, index) {
        return ListTile(
          leading: CircleAvatar(
            backgroundColor: Theme.of(ctx).primaryColor,
            child: FittedBox(
              child: Text('${index + 1}'),
            ),
          ),
          title: Text('text1'),
          subtitle: Text('text2'),
        );
      },
      itemCount: ingredients.length,
    );
  }
}
