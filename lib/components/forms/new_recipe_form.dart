import 'package:cook_app/components/lists/ingredient_list.dart';
import 'package:cook_app/components/lists/step_list.dart';
import 'package:cook_app/screens/recepies/new_recipe/ingredient.dart';
import 'package:cook_app/screens/recepies/new_recipe/step.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cook_app/providers/recipe.dart';
import 'package:flutter_tags/flutter_tags.dart';

class NewRecipeFrom extends StatefulWidget {
  @override
  State<NewRecipeFrom> createState() => _NewRecipeFromState();
}

class _NewRecipeFromState extends State<NewRecipeFrom> {
  List<String> tags = [];
  final _form = GlobalKey<FormState>();
  final _tags = GlobalKey<TagsState>();

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
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some title';
                  }
                  return null;
                }),
            TextFormField(
                decoration:
                    const InputDecoration(labelText: 'Description & Tips'),
                maxLines: 3,
                keyboardType: TextInputType.multiline,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some description';
                  }
                  return null;
                }),
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
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter time';
                          }
                          return null;
                        }),
                  ),
                ),
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.only(right: 5),
                    child: TextFormField(
                        decoration:
                            const InputDecoration(labelText: 'Cal/Serv'),
                        keyboardType: TextInputType.number,
                        textInputAction: TextInputAction.next,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter some cal/serv';
                          }
                          return null;
                        }),
                  ),
                ),
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.only(left: 5),
                    child: TextFormField(
                        decoration: const InputDecoration(labelText: 'Yields'),
                        keyboardType: TextInputType.number,
                        textInputAction: TextInputAction.next,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter number of yields';
                          }
                          return null;
                        }),
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
                color: Theme.of(context).primaryColorLight,
              ),
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
                'Steps',
                style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 19),
              ),
            ),
            StepList(steps: _recipe.steps),
            Padding(
              padding: const EdgeInsets.only(left: 60, right: 60),
              child: RaisedButton(
                onPressed: () {
                  Navigator.of(context).pushNamed(StepScreen.routeName);
                },
                child: const Text(
                  'Add a new step',
                  style: TextStyle(color: Colors.white),
                ),
                color: Theme.of(context).primaryColorLight,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10, bottom: 20),
              child: Divider(
                color: Theme.of(context).primaryColor,
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: 20),
              child: Text(
                'Tags',
                style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 19),
              ),
            ),
            Tags(
              key: _tags,
              itemCount: tags.length,
              columns: 6,
              textField: TagsTextField(
                maxLength: 20,
                onSubmitted: (newTag) {
                  setState(() {
                    tags.add(newTag);
                    _recipe.addTag(newTag);
                  });
                },
              ),
              itemBuilder: (index) {
                final String currentTag = tags[index];

                return ItemTags(
                  key: Key(index.toString()),
                  index: index,
                  title: currentTag,
                  activeColor: Theme.of(context).primaryColor,
                  combine: ItemTagsCombine.withTextAfter,
                  removeButton: ItemTagsRemoveButton(
                      onRemoved: () {
                        setState(() {
                          tags.removeAt(index);
                          _recipe.removeTag(index);
                        });
                        return true;
                      },
                      color: Colors.black,
                      backgroundColor: Colors.white),
                );
              },
            ),
            RaisedButton(
              onPressed: () {
                // Navigator.of(context).pushNamed(IngredientScreen.routeName);
                _recipe.send();
                print('Tu na razie jest sciernisko ale bedzie sanfrancisko');
              },
              child: const Text(
                'Save my recipe',
                style: TextStyle(color: Colors.white),
              ),
              color: Theme.of(context).primaryColor,
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
