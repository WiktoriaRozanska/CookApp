import 'package:cook_app/components/buttons/rounded_button.dart';
import 'package:cook_app/components/inputs/rounded_input.dart';
import 'package:cook_app/components/inputs/rounded_password_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';

import 'components/registration_form.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    with SingleTickerProviderStateMixin {
  bool _isLogin = true;
  Animation<double>? containerSize;
  AnimationController? animationController;
  Duration animationDuration = const Duration(milliseconds: 270);

  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIOverlays([]);

    animationController =
        AnimationController(vsync: this, duration: animationDuration);
  }

  @override
  void dispose() {
    animationController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double viewInset = MediaQuery.of(context).viewInsets.bottom;
    double defaultLoginSize = size.height - (size.height * 0.2);
    double defaultRegisterSize = size.height - (size.height * 0.1);

    containerSize =
        Tween<double>(begin: size.height * 0.1, end: defaultRegisterSize)
            .animate(CurvedAnimation(
                parent: animationController!, curve: Curves.linear));

    Widget buildRegisterContainer() {
      return Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                alignment: Alignment.center,
                width: double.infinity,
                height: containerSize!.value,
                decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(100),
                      topRight: Radius.circular(100),
                    )),
                child: GestureDetector(
                  onVerticalDragStart: (_) {
                    animationController!.forward();
                    setState(() {
                      _isLogin = false;
                    });
                  },
                  child: _isLogin ? Text(
                    "Don't have an account? Sign up",
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontSize: 18,
                    ),
                  ) : RegistrationForm(),
                ),
              ),
            );
    }

    return SafeArea(
      child: Scaffold(
        body: Stack(
        children: [
          // cancel button

          if (!_isLogin)
            Align(
              alignment: Alignment.topCenter,
              child: Container(
                width: size.width,
                height: size.height * 0.1,
                alignment: Alignment.bottomCenter,
                child: IconButton(
                  icon: Icon(Icons.close),
                  onPressed: () {
                    animationController!.reverse();
                    setState(() {
                      _isLogin = true;
                    });
                  },
                  color: Theme.of(context).primaryColor,
                ),
              ),
            ),

          // login form
          LoginForm(size: size, defaultLoginSize: defaultLoginSize),

          // register cointainer
          AnimatedBuilder(
              animation: animationController!,
              builder: (context, child) {
                if(viewInset == 0 && _isLogin){
                  return buildRegisterContainer();
                }
                else if(!_isLogin)
                {
                  return buildRegisterContainer();
                }
                
                return Container();
              })
        ],
      )),
    );
  }
}

class LoginForm extends StatelessWidget {
  const LoginForm({
    Key? key,
    required this.size,
    required this.defaultLoginSize,
  }) : super(key: key);

  final Size size;
  final double defaultLoginSize;

  @override
  Widget build(BuildContext context) {
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
                  label: 'Username or email'),
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
