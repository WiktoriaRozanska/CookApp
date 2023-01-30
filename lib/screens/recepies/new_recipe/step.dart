import 'package:cook_app/components/forms/new_step_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class StepScreen extends StatelessWidget {
  const StepScreen({Key? key}) : super(key: key);

  static const routeName = '/step';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('Add step'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Stack(
          children: [
            Positioned(
              bottom: 0,
              right: 0,
              child: SvgPicture.asset(
                'assets/images/undraw_typewriter_i-8-xd.svg',
                width: 190,
                height: 190,
                fit: BoxFit.contain,
              ),
            ),
            NewStepForm(),
          ],
        ),
      ),
    );
  }
}
