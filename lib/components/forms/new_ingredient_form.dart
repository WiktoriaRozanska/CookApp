import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cook_app/providers/recipe.dart';
import 'package:cook_app/models/ingredient.dart';

class NewIngredientForm extends StatefulWidget {
  const NewIngredientForm({Key? key}) : super(key: key);

  @override
  _NewIngredientFormState createState() => _NewIngredientFormState();
}

class _NewIngredientFormState extends State<NewIngredientForm> {
  final _form = GlobalKey<FormState>();
  Units dropdownValue = Units.grams;
  final nameController = TextEditingController();
  final quantityController = TextEditingController();

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

  @override
  void dispose() {
    nameController.dispose();
    quantityController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final _recipe = Provider.of<Recipe>(context);
    Ingredient? editingIngredient;

    if (_recipe.editingMood && _recipe.ingredientIndexToEdite >= 0) {
      editingIngredient = _recipe.ingredientToEdit;
      nameController.text = editingIngredient!.name!;
      quantityController.text = '${editingIngredient.quantity!}';
      dropdownValue = editingIngredient.unit!;
    }

    return Form(
      key: _form,
      child: Column(
        children: [
          TextFormField(
            decoration: const InputDecoration(labelText: 'Ingredient'),
            textInputAction: TextInputAction.next,
            controller: nameController,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter some ingredient';
              }
              return null;
            },
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Flexible(
                flex: 2,
                child: TextFormField(
                    decoration: const InputDecoration(labelText: 'Quantity'),
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.number,
                    controller: quantityController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter quantity';
                      }
                      return null;
                    }),
              ),
              Flexible(
                flex: 1,
                child: Padding(
                  padding: const EdgeInsets.only(left: 12.0),
                  child: DropdownButton<Units>(
                    isDense: true,
                    value: dropdownValue,
                    icon: const Icon(Icons.arrow_downward_outlined),
                    onChanged: (Units? newValue) {
                      setState(() {
                        dropdownValue = newValue!;
                      });
                    },
                    items: units.entries.map((entry) {
                      return DropdownMenuItem<Units>(
                        value: entry.key,
                        child: Text(entry.value),
                      );
                    }).toList(),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 40,
          ),
          ElevatedButton(
              onPressed: () {
                if (_form.currentState!.validate()) {
                  if (_recipe.editingMood &&
                      _recipe.ingredientIndexToEdite >= 0) {
                    _recipe.editIngredient(Ingredient(
                        name: nameController.text,
                        quantity: double.parse(quantityController.text),
                        unit: dropdownValue));
                  } else {
                    _recipe.addIngredients(Ingredient(
                        name: nameController.text,
                        quantity: double.parse(quantityController.text),
                        unit: dropdownValue));
                  }

                  Navigator.pop(context);
                }
              },
              child: _recipe.editingMood && _recipe.ingredientIndexToEdite >= 0
                  ? const Text('Update')
                  : const Text('Add ingredient'))
        ],
      ),
    );
  }
}
