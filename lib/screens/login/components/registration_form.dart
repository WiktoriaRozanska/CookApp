import 'package:cook_app/components/buttons/rounded_button.dart';
import 'package:cook_app/components/inputs/rounded_input.dart';
import 'package:cook_app/components/inputs/rounded_password_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import '../../../providers/auth.dart';

class RegistrationForm extends StatefulWidget {
  @override
  State<RegistrationForm> createState() => _RegistrationFormState();
}

class _RegistrationFormState extends State<RegistrationForm> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  @override
  void dispose() {
    _usernameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  Future<void> signup() async {
    print(_usernameController.value.text);
    print(_emailController.value.text);
    print("TAAAAAAAAAAK");
    await Provider.of<Auth>(context, listen: false).signup(
        _emailController.value.text,
        _usernameController.value.text,
        _passwordController.value.text,
        _confirmPasswordController.value.text);
    Scaffold.of(context).showSnackBar(SnackBar(
      content: Text('Hello there'),
      backgroundColor: Theme.of(context).primaryColor,
    ));
  }

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
              const SizedBox(
                height: 40,
              ),
              SvgPicture.asset(
                'assets/images/undraw_cookie_love_ulvn.svg',
                width: 180,
                height: 180,
                fit: BoxFit.contain,
              ),
              const SizedBox(
                height: 40,
              ),
              RoundedInput(
                  textEditingController: _usernameController,
                  iconData: Icons.face_retouching_natural_outlined,
                  label: 'Username'),
              RoundedInput(
                  textEditingController: _emailController,
                  iconData: Icons.email_outlined,
                  label: 'Email'),
              RoundedPasswordInput(
                textEditingController: _passwordController,
                label: 'Password',
              ),
              RoundedPasswordInput(
                textEditingController: _confirmPasswordController,
                label: 'Confirm password',
              ),
              RoundedButton(label: 'Sign up', onTap: signup),
            ],
          ),
        ),
      ),
    );
  }
}
