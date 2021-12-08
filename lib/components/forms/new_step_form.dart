import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cook_app/providers/recipe.dart';

class NewStepForm extends StatefulWidget {
  @override
  _NewStepFormState createState() => _NewStepFormState();
}

class _NewStepFormState extends State<NewStepForm> {
  final _form = GlobalKey<FormState>();
  final stepController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final _recipe = Provider.of<Recipe>(context);

    return Form(
      key: _form,
      child: Column(
        children: [
          TextFormField(
            decoration: const InputDecoration(labelText: 'Step description'),
            textInputAction: TextInputAction.send,
            controller: stepController,
            maxLines: 5,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter some description';
              }
              return null;
            },
          ),
          const SizedBox(
            height: 40,
          ),
          ElevatedButton(
              onPressed: () {
                if (_form.currentState!.validate()) {
                  _recipe.addStep(stepController.text);
                  Navigator.pop(context);
                }
              },
              child: const Text('Add step'))
        ],
      ),
    );
  }
}
