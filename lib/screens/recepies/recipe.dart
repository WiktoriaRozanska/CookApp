import 'package:cook_app/components/lists/ingredient_list.dart';
import 'package:cook_app/components/lists/step_list.dart';
import 'package:cook_app/models/recipe_item.dart';
import 'package:cook_app/screens/home.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cook_app/providers/recipe.dart';
import 'package:flutter_tags/flutter_tags.dart';

class RecipeScreen extends StatefulWidget {
  const RecipeScreen({Key? key}) : super(key: key);

  static const routeName = '/recipe';

  @override
  State<RecipeScreen> createState() => _RecipeScreenState();
}

class _RecipeScreenState extends State<RecipeScreen> {
  var _isLoading = true;
  var _isInit = true;
  var _recipe = RecipeItem(
      title: '',
      description: '',
      ingredients: [],
      time: 0,
      calPerServ: 0,
      yields: 0,
      steps: [],
      tags: []);

  @override
  void didChangeDependencies() {
    if (_isInit) {
      final recipeId = ModalRoute.of(context)!.settings.arguments as String?;

      if (recipeId != null && recipeId.isNotEmpty) {
        Provider.of<Recipe>(context).fetchRecipe(recipeId).then((value) {
          _recipe = value;
          setState(() {
            _isLoading = false;
          });
        });
      }
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final _recipe = Provider.of<Recipe>(context);
    final _tags = GlobalKey<TagsState>();

    return _isLoading
        ? Scaffold(
            body: Center(
            child: CircularProgressIndicator(
              color: Theme.of(context).primaryColor,
            ),
          ))
        : Scaffold(
            bottomSheet: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    print('Click');
                  },
                  child: const Icon(
                    Icons.favorite_border,
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
                    print('Click');
                  },
                  child: const Text(
                    'Add to my menu',
                    style: TextStyle(color: Colors.white),
                  ),
                  color: Theme.of(context).primaryColor,
                )
              ],
            ),
            body: NestedScrollView(
              headerSliverBuilder:
                  (BuildContext context, bool innerBoxIsScrolled) {
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
                          Navigator.of(context)
                              .popAndPushNamed(HomeScreen.routeName);
                        },
                      ),
                    ],
                    flexibleSpace: FlexibleSpaceBar(
                        centerTitle: true,
                        title: Text(_recipe.title,
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
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(10))),
                                margin: const EdgeInsets.all(5),
                                child: Column(
                                  children: [
                                    const Icon(
                                      Icons.timer,
                                      color: Colors.teal,
                                    ),
                                    Text('${_recipe.time} min'),
                                  ],
                                )),
                          ),
                          Expanded(
                            child: Container(
                                margin: const EdgeInsets.all(2.5),
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        color: Theme.of(context).primaryColor),
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(10))),
                                child: Column(
                                  children: [
                                    const Icon(
                                      Icons.local_fire_department_outlined,
                                      color: Colors.teal,
                                    ),
                                    Text('${_recipe.calPerServ} kcal/serv'),
                                  ],
                                )),
                          ),
                          Expanded(
                            child: Container(
                                margin: const EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        color: Theme.of(context).primaryColor),
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(10))),
                                child: Column(
                                  children: [
                                    const Icon(
                                      Icons.restaurant_menu_outlined,
                                      color: Colors.teal,
                                    ),
                                    Text('${_recipe.yields}'),
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
                      Text(_recipe.description),
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
                      IngredientList(ingredients: _recipe.ingredients),
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
                      StepList(steps: _recipe.steps),
                      Tags(
                        key: _tags,
                        itemCount: _recipe.tags.length,
                        columns: 6,
                        itemBuilder: (index) {
                          final String currentTag = _recipe.tags[index];
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
