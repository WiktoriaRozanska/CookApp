import 'package:cook_app/components/forms/new_recipe_form.dart';
import 'package:cook_app/components/image_picker_box.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cook_app/providers/recipe.dart';

class NewRecipeScreen extends StatefulWidget {
  static const routeName = '/new_recipe';

  @override
  State<NewRecipeScreen> createState() => _NewRecipeScreenState();
}

class _NewRecipeScreenState extends State<NewRecipeScreen> {
  final _form = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final _recipe = Provider.of<Recipe>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: _recipe.editingMood
            ? const Text('Editing recipe')
            : const Text('New recepie'),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: Stack(
        children: [
          //decoration
          Container(
            margin: EdgeInsets.only(top: 50),
            decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(60),
                  topRight: Radius.circular(60),
                )),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ImagePickerBox(),
            ],
          ),
          Container(
            margin: const EdgeInsets.only(top: 180),
            padding: const EdgeInsets.all(10),
            child: NewRecipeFrom(),
          ),
        ],
      ),
    );
  }
}
