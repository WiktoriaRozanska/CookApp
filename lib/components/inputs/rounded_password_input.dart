import 'package:cook_app/components/inputs/input_container.dart';
import 'package:flutter/material.dart';

class RoundedPasswordInput extends StatelessWidget {
    const RoundedPasswordInput({
    Key? key,
    required this.label,
  }) : super(key: key);
  
  final String label;

  @override
  Widget build(BuildContext context) {
    return InputContainer(
      child: TextField(
          cursorColor: Theme.of(context).primaryColor,
          obscureText: true,
          decoration: InputDecoration(
            icon: Icon(
              Icons.vpn_key_outlined,
              color: Theme.of(context).primaryColor,
            ),
            hintText: label,
            border: InputBorder.none,
          )),
    );
  }
}