import 'package:cook_app/components/lists/ingredient_list.dart';
import 'package:cook_app/screens/recepies/ingredients/ingredient.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cook_app/providers/recipe.dart';

class NewRecipeFrom extends StatefulWidget {
  @override
  State<NewRecipeFrom> createState() => _NewRecipeFromState();
}

class _NewRecipeFromState extends State<NewRecipeFrom> {
  final _form = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final _recipe = Provider.of<Recipe>(context);
    return Form(
      key: _form,
      child: GlowingOverscrollIndicator(
        color: Theme.of(context).primaryColor,
        axisDirection: AxisDirection.down,
        child: ListView(
          children: [
            TextFormField(
              decoration: const InputDecoration(labelText: 'Title'),
              textInputAction: TextInputAction.next,
              onChanged: (value) {
                _recipe.addTitle(value);
              },
            ),
            TextFormField(
              decoration:
                  const InputDecoration(labelText: 'Description & Tips'),
              maxLines: 3,
              keyboardType: TextInputType.multiline,
              onSaved: (newValue) {
                print('On saved description');
                if (newValue != null) {
                  _recipe.addDescription(newValue);
                }
              },
            ),
            Row(
              children: [
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.only(right: 10),
                    child: TextFormField(
                      decoration:
                          const InputDecoration(labelText: 'Time (min)'),
                      keyboardType: TextInputType.number,
                      textInputAction: TextInputAction.next,
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.only(right: 5),
                    child: TextFormField(
                      decoration: const InputDecoration(labelText: 'Cal/Serv'),
                      keyboardType: TextInputType.number,
                      textInputAction: TextInputAction.next,
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.only(left: 5),
                    child: TextFormField(
                      decoration: const InputDecoration(labelText: 'Yields'),
                      keyboardType: TextInputType.number,
                      textInputAction: TextInputAction.next,
                    ),
                  ),
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 30),
              child: Divider(
                color: Theme.of(context).primaryColor,
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: 20),
              child: Text(
                'Ingredients',
                style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 19),
              ),
            ),
            IngredientList(ingredients: _recipe.ingredients),
            Padding(
              padding: const EdgeInsets.only(left: 60, right: 60),
              child: RaisedButton(
                onPressed: () {
                  Navigator.of(context).pushNamed(IngredientScreen.routeName);
                },
                child: const Text(
                  'Add a new ingredient',
                  style: TextStyle(color: Colors.white),
                ),
                color: Theme.of(context).primaryColor,
              ),
            ),
            const SizedBox(
              height: 40,
            )
          ],
        ),
      ),
    );
  }
}
