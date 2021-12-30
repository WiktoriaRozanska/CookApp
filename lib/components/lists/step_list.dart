import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cook_app/providers/recipe.dart';
import 'package:cook_app/screens/recepies/new_recipe/step.dart';

class StepList extends StatelessWidget {
  List<String> steps;

  StepList({Key? key, required this.steps}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _recipe = Provider.of<Recipe>(context);

    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: Column(
        children: steps.map((step) {
          return ListTile(
            leading: CircleAvatar(
              backgroundColor: Theme.of(context).primaryColorLight,
              child: FittedBox(
                child: Text(
                  '${steps.indexOf(step) + 1}',
                  style: const TextStyle(color: Colors.white),
                ),
              ),
            ),
            title: Text(step),
            trailing: _recipe.editingMood
                ? GestureDetector(
                    child: const Icon(Icons.edit_outlined),
                    onTap: () {
                      _recipe.setStepIndexToEdite(steps.indexOf(step));
                      print('tap tap');
                      Navigator.of(context).pushNamed(StepScreen.routeName);
                    },
                  )
                : null,
          );
        }).toList(),
      ),
    );
  }
}
