import 'package:cook_app/screens/login/splash_screen.dart';
import 'package:provider/provider.dart';
import 'package:cook_app/providers/user.dart';
import 'package:cook_app/providers/auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:cook_app/models/user.dart' as model;

class ProfileScreen extends StatefulWidget {
  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final _form = GlobalKey<FormState>();
  int _value = 1;
  bool _isLoading = true;
  var _isInit = true;
  User? userProvider;
  model.User? currentUser;

  @override
  void initState() {
    userProvider = Provider.of<User>(context, listen: false);
    Future.delayed(Duration.zero).then((_) {
      userProvider!.fetchCurrentUser().then((value) {
        setState(() {
          currentUser = value;
          _isLoading = false;
        });
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Auth authProvider = Provider.of<Auth>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: const Text('My profile'),
      ),
      body: _isLoading
          ? const SplashScreen()
          : SingleChildScrollView(
              child: Container(
                margin: const EdgeInsets.only(
                    top: 40, left: 20, right: 20, bottom: 40),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: CircleAvatar(
                        child: _value == 1
                            ? SvgPicture.asset(
                                'assets/images/undraw_female_avatar_w3jk.svg')
                            : SvgPicture.asset(
                                'assets/images/undraw_male_avatar_323b.svg'),
                        radius: 80,
                      ),
                    ),
                    Container(
                      padding:
                          const EdgeInsets.only(left: 40, right: 40, top: 20),
                      child: Form(
                        key: _form,
                        child: Column(
                          children: [
                            TextFormField(
                              decoration:
                                  const InputDecoration(labelText: 'Email'),
                              enabled: false,
                              initialValue: currentUser!.email,
                              style: const TextStyle(color: Colors.grey),
                            ),
                            TextFormField(
                              decoration:
                                  const InputDecoration(labelText: 'Nick'),
                              initialValue: currentUser!.username,
                              onChanged: (value) {
                                if (value == '') {
                                  return;
                                }

                                setState(() {
                                  currentUser!.username = value;
                                });
                              },
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            const Text('Avatar icon:'),
                            Row(
                              children: [
                                Radio(
                                  activeColor: Theme.of(context).primaryColor,
                                  groupValue: _value,
                                  value: 1,
                                  onChanged: (value) {
                                    setState(() {
                                      currentUser!.isFemale = true;
                                      _value = 1;
                                    });
                                  },
                                ),
                                const SizedBox(
                                  width: 10.0,
                                ),
                                const Text('Female'),
                              ],
                            ),
                            Row(
                              children: [
                                Radio(
                                  activeColor: Theme.of(context).primaryColor,
                                  groupValue: _value,
                                  value: 2,
                                  onChanged: (value) {
                                    setState(() {
                                      currentUser!.isFemale = false;
                                      _value = 2;
                                    });
                                  },
                                ),
                                const SizedBox(
                                  width: 10.0,
                                ),
                                const Text('Male'),
                              ],
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            SizedBox(
                              width: 200,
                              child: ElevatedButton(
                                  onPressed: () {
                                    userProvider!.updateUser(
                                        currentUser!.isFemale,
                                        currentUser!.username);
                                  },
                                  child: const Text('Update account')),
                            ),
                            SizedBox(
                              width: 200,
                              child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      primary: Colors.grey),
                                  onPressed: () {
                                    print('click - log out');
                                    authProvider.logout();
                                  },
                                  child: const Text('Log out')),
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
    );
  }
}
