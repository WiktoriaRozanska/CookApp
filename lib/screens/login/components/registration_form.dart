import 'package:cook_app/components/buttons/rounded_button.dart';
import 'package:cook_app/components/inputs/rounded_input.dart';
import 'package:cook_app/components/inputs/rounded_password_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';


class RegistrationForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double defaultRegisterSize = size.height - (size.height * 0.1);

    return Align(
            alignment: Alignment.center,
            child: SingleChildScrollView(
              child: Container(
                width: size.width,
                height: defaultRegisterSize,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Welcome',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                      ),
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    SvgPicture.asset(
                      'assets/images/undraw_cookie_love_ulvn.svg',
                      width: 180,
                      height: 180,
                      fit: BoxFit.contain,
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    RoundedInput(
                        iconData: Icons.face_retouching_natural_outlined,
                        label: 'Username'),
                        RoundedInput(
                        iconData: Icons.email_outlined,
                        label: 'Email'),
                    RoundedPasswordInput(
                      label: 'Password',
                    ),
                    RoundedPasswordInput(
                      label: 'Confirm password',
                    ),
                    RoundedButton(label: 'Sign up'),
                  ],
                ),
              ),
            ),
          );
  }
}