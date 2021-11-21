import 'package:cook_app/components/buttons/rounded_button.dart';
import 'package:cook_app/components/inputs/rounded_input.dart';
import 'package:cook_app/components/inputs/rounded_password_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class LoginForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          'Your cookbook!',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
        const SizedBox(
          height: 40,
        ),
        SvgPicture.asset(
          'assets/images/undraw_cooking_lyxy.svg',
          width: 200,
          height: 200,
          fit: BoxFit.contain,
        ),
        const SizedBox(
          height: 40,
        ),
        const RoundedInput(
            iconData: Icons.email_outlined, label: 'Username or email'),
        const RoundedPasswordInput(
          label: 'Password',
        ),
        const RoundedButton(label: 'Log in'),
      ],
    );
  }
}
