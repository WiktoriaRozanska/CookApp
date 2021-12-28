import 'package:cook_app/components/custom_dialog_box.dart';
import 'package:cook_app/components/lists/ingredient_list.dart';
import 'package:cook_app/components/lists/step_list.dart';
import 'package:cook_app/models/recipe_item.dart';
import 'package:cook_app/screens/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tags/flutter_tags.dart';
import 'package:provider/provider.dart';
import 'package:cook_app/providers/recipe.dart';

class RecipeScreen extends StatefulWidget {
  const RecipeScreen({Key? key}) : super(key: key);

  static const routeName = '/recipe';

  @override
  State<RecipeScreen> createState() => _RecipeScreenState();
}

class _RecipeScreenState extends State<RecipeScreen> {
  var _isLoading = true;
  var _isInit = true;
  var recipeItem;

  @override
  void didChangeDependencies() {
    if (_isInit) {
      recipeItem = ModalRoute.of(context)!.settings.arguments as RecipeItem;
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final _recipe = Provider.of<Recipe>(context, listen: false);
    final _tags = GlobalKey<TagsState>();

    return Scaffold(
      bottomSheet: Material(
        color: Colors.transparent,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton(
              onPressed: () {
                if (recipeItem.isFavorite) {
                  _recipe.removeFromFavorite(recipeItem.id);
                } else {
                  _recipe.addToFavorite(recipeItem.id);
                }

                setState(() {
                  recipeItem.isFavorite = !recipeItem.isFavorite;
                });

                print('Click');
              },
              child: Icon(
                recipeItem.isFavorite
                    ? Icons.favorite_outlined
                    : Icons.favorite_border,
                color: Colors.white,
              ),
              // child: const Text(
              //   'Add to favorite',
              //   style: TextStyle(color: Colors.white),
              // ),
              style: ElevatedButton.styleFrom(
                shape: CircleBorder(),
              ),
            ),
            RaisedButton(
              onPressed: () {
                showCustomDialogBox(context,
                    title: 'Set day when you want to doing this recipe',
                    description: 'We have created custom dialog box',
                    recipeId: recipeItem.id);
              },
              child: const Text(
                'Add to my menu',
                style: TextStyle(color: Colors.white),
              ),
              color: Theme.of(context).primaryColor,
            ),
            if (recipeItem.owner)
              ElevatedButton(
                onPressed: () {
                  _recipe.deleteRecipe(recipeItem.id);
                  Navigator.of(context).pop();
                  print('delete');
                },
                child: const Icon(
                  Icons.delete_outline,
                  color: Colors.white,
                ),
                // child: const Text(
                //   'Add to favorite',
                //   style: TextStyle(color: Colors.white),
                // ),
                style: ElevatedButton.styleFrom(
                  shape: CircleBorder(),
                ),
              )
          ],
        ),
      ),
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              expandedHeight: 300.0,
              floating: false,
              pinned: true,
              automaticallyImplyLeading: false,
              actions: <Widget>[
                IconButton(
                  icon: const Icon(Icons.arrow_forward_ios_outlined),
                  tooltip: 'Back to main screen',
                  onPressed: () {
                    Navigator.of(context).popAndPushNamed(HomeScreen.routeName);
                  },
                ),
              ],
              flexibleSpace: FlexibleSpaceBar(
                  centerTitle: true,
                  title: Text(recipeItem.title,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16.0,
                      )),
                  background: Image.network(
                    "https://domowe-wypieki.com/wp-content/uploads/2019/08/p%C3%B3lkule-413x247.jpg",
                    fit: BoxFit.cover,
                  )),
            ),
          ];
        },
        body: Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: ListView(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Container(
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color: Theme.of(context).primaryColor),
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(10))),
                          margin: const EdgeInsets.all(5),
                          child: Column(
                            children: [
                              const Icon(
                                Icons.timer,
                                color: Colors.teal,
                              ),
                              Text('${recipeItem.time} min'),
                            ],
                          )),
                    ),
                    Expanded(
                      child: Container(
                          margin: const EdgeInsets.all(2.5),
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color: Theme.of(context).primaryColor),
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(10))),
                          child: Column(
                            children: [
                              const Icon(
                                Icons.local_fire_department_outlined,
                                color: Colors.teal,
                              ),
                              Text('${recipeItem.calPerServ} kcal/serv'),
                            ],
                          )),
                    ),
                    Expanded(
                      child: Container(
                          margin: const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color: Theme.of(context).primaryColor),
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(10))),
                          child: Column(
                            children: [
                              const Icon(
                                Icons.restaurant_menu_outlined,
                                color: Colors.teal,
                              ),
                              Text('${recipeItem.yields}'),
                            ],
                          )),
                    ),
                  ],
                ),
                Container(
                  padding: const EdgeInsets.only(top: 20),
                  child: Text(
                    'Description',
                    style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 19),
                  ),
                ),
                Text(recipeItem.description),
                Divider(
                  color: Theme.of(context).primaryColor,
                ),
                Container(
                  padding: const EdgeInsets.only(top: 20),
                  child: Text(
                    'Ingredients',
                    style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 19),
                  ),
                ),
                IngredientList(ingredients: recipeItem.ingredients),
                Divider(
                  color: Theme.of(context).primaryColor,
                ),
                Container(
                  padding: const EdgeInsets.only(top: 20),
                  child: Text(
                    'Steps',
                    style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 19),
                  ),
                ),
                StepList(steps: recipeItem.steps),
                Tags(
                  key: _tags,
                  itemCount: recipeItem.tags.length,
                  columns: 6,
                  itemBuilder: (index) {
                    final String currentTag = recipeItem.tags[index];
                    return ItemTags(
                        key: Key(index.toString()),
                        index: index,
                        title: currentTag,
                        activeColor: Theme.of(context).primaryColor,
                        combine: ItemTagsCombine.withTextAfter);
                  },
                ),
              ],
            )),
      ),
    );
  }
}
