import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'components/login_form.dart';
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
              borderRadius: const BorderRadius.only(
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
            child: _isLogin
                ? Text(
                    "Don't have an account? Sign up",
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontSize: 18,
                    ),
                  )
                : RegistrationForm(),
          ),
        ),
      );
    }

    return SafeArea(
      child: Scaffold(
          body: Stack(
        children: [
          // decoration
          Positioned(
              top: 90,
              right: -50,
              child: Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color: Colors.lime.withAlpha(90),
                ),
              )),

          Positioned(
              top: -50,
              left: -50,
              child: Container(
                width: 200,
                height: 200,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  color: Colors.lime.withAlpha(90),
                ),
              )),

          Positioned(
              bottom: -50,
              left: -70,
              child: Container(
                width: 250,
                height: 250,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(125),
                  color: Colors.lime.withAlpha(90),
                ),
              )),

          // cancel button
          if (!_isLogin)
            Align(
              alignment: Alignment.topCenter,
              child: Container(
                width: size.width,
                height: size.height * 0.1,
                alignment: Alignment.bottomCenter,
                child: IconButton(
                  icon: const Icon(Icons.close),
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
          const LoginForm(),

          // register cointainer
          AnimatedBuilder(
              animation: animationController!,
              builder: (context, child) {
                if (viewInset == 0 && _isLogin) {
                  return buildRegisterContainer();
                } else if (!_isLogin) {
                  return buildRegisterContainer();
                }

                return Container();
              })
        ],
      )),
    );
  }
}
