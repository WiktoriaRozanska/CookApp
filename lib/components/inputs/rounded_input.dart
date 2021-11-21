import 'package:cook_app/components/inputs/input_container.dart';
import 'package:flutter/material.dart';

class RoundedInput extends StatelessWidget {
  const RoundedInput({
    Key? key,
    required this.iconData,
    required this.label,
  }) : super(key: key);


  final IconData iconData;
  final String label;

  @override
  Widget build(BuildContext context) {
    return InputContainer(
      child: TextField(
          cursorColor: Theme.of(context).primaryColor,
          decoration: InputDecoration(
            icon: Icon(
              iconData,
              color: Theme.of(context).primaryColor,
            ),
            hintText: label,
            border: InputBorder.none,
          )),
    );
  }
}
