import 'package:cook_app/components/forms/new_ingredient_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class IngredientScreen extends StatelessWidget {
  const IngredientScreen({Key? key}) : super(key: key);

  static const routeName = '/ingredient';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add ingredient'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Stack(
          children: [
            NewIngredientForm(),
            Positioned(
              bottom: 0,
              right: 0,
              child: SvgPicture.asset(
                'assets/images/undraw_diet_ghvw.svg',
                width: 190,
                height: 190,
                fit: BoxFit.contain,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
