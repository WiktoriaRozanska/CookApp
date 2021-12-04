import 'package:cook_app/components/buttons/rounded_button.dart';
import 'package:cook_app/components/inputs/rounded_input.dart';
import 'package:cook_app/components/inputs/rounded_password_input.dart';
import 'package:cook_app/models/http_exception.dart';
import 'package:email_validator/email_validator.dart';
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

  var _isLoading = false;

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
              if (_isLoading)
                CircularProgressIndicator(
                  color: Theme.of(context).primaryColor,
                )
              else
                RoundedButton(label: 'Sign up', onTap: signup),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _showErrorDialog(String message) {
    showDialog(
        barrierColor: Colors.grey.withAlpha(80),
        context: context,
        builder: (ctx) => AlertDialog(
              title: Text('An Error Occured!'),
              content: Text(message),
              actions: [
                FlatButton(
                    onPressed: () {
                      Navigator.of(ctx).pop();
                    },
                    child: Text('Okay'))
              ],
            ));
  }

  Future<void> signup() async {
    setState(() {
      _isLoading = true;
    });

    try {
      await Provider.of<Auth>(context, listen: false).signup(
          _emailController.value.text,
          _usernameController.value.text,
          _passwordController.value.text,
          _confirmPasswordController.value.text);
    } on HttpException catch (error) {
      var errorMessage = 'Authentication failed\n';
      if (error.errors['email'] != null) {
        errorMessage += 'Email ' + error.errors['email']![0] + '\n';
      }
      if (error.errors['username'] != null) {
        errorMessage += 'Username ' + error.errors['username']![0] + '\n';
      }
      if (error.errors['password'] != null) {
        errorMessage += 'Password ' + error.errors['password']![0] + '\n';
      }
      if (error.errors['password_confirmation'] != null) {
        errorMessage += 'Password confirmation ' +
            error.errors['password_confirmation']![0] +
            '\n';
      }

      _showErrorDialog(errorMessage);
    } catch (error) {
      var errorMessage = 'Could not registration you. Please try again later.';
      _showErrorDialog(errorMessage);
    }

    setState(() {
      _isLoading = false;
    });
  }
}
