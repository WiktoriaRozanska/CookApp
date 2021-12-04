import 'package:cook_app/components/buttons/rounded_button.dart';
import 'package:cook_app/components/inputs/rounded_input.dart';
import 'package:cook_app/components/inputs/rounded_password_input.dart';
import 'package:cook_app/models/http_exception.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import '../../../providers/auth.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({
    Key? key,
  }) : super(key: key);

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  var _isLoading = false;

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
                iconData: Icons.email_outlined,
                label: 'Email',
                textEditingController: _emailController,
              ),
              RoundedPasswordInput(
                label: 'Password',
                textEditingController: _passwordController,
              ),
              if (_isLoading)
                CircularProgressIndicator(
                  color: Theme.of(context).primaryColor,
                )
              else
                RoundedButton(
                  label: 'Log in',
                  onTap: login,
                ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
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

  Future<void> login() async {
    setState(() {
      _isLoading = true;
    });
    try {
      await Provider.of<Auth>(context, listen: false)
          .login(_emailController.value.text, _passwordController.value.text);
    } on HttpException catch (error) {
      // TODO
      var errorMessage = 'Authentication failed\n';
      print('Error->' + error.errors.toString());
      if (error.errors['error'] != null) {
        errorMessage += error.errors['error'];
      }
      _showErrorDialog(errorMessage);
    } catch (error) {
      print('Error->' + error.toString());
      var errorMessage =
          'Could not authentication you. Please try again later.';
      _showErrorDialog(errorMessage);
    }

    setState(() {
      _isLoading = false;
    });
  }
}
