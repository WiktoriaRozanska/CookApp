import 'package:cook_app/components/buttons/rounded_button.dart';
import 'package:cook_app/components/inputs/rounded_input.dart';
import 'package:cook_app/components/inputs/rounded_password_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double defaultLoginSize = size.height - (size.height * 0.2);

    return Align(
      alignment: Alignment.center,
      child: SingleChildScrollView(
        child: Container(
          width: size.width,
          height: defaultLoginSize,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Your cookbook!',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                ),
              ),
              SizedBox(
                height: 40,
              ),
              SvgPicture.asset(
                'assets/images/undraw_cooking_lyxy.svg',
                width: 200,
                height: 200,
                fit: BoxFit.contain,
              ),
              SizedBox(
                height: 40,
              ),
              RoundedInput(
                  iconData: Icons.email_outlined, label: 'Username or email'),
              RoundedPasswordInput(
                label: 'Password',
              ),
              RoundedButton(label: 'Log in'),
            ],
          ),
        ),
      ),
    );
  }
}
