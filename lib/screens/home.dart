import 'package:cook_app/screens/recepies/categories.dart';
import 'package:cook_app/screens/recepies/favorite.dart';
import 'package:cook_app/screens/recepies/menu.dart';
import 'package:cook_app/screens/recepies/new_recipe.dart';
import 'package:cook_app/screens/profile.dart';
import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = '/home';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final navigationKey = GlobalKey<CurvedNavigationBarState>();
  var index = 2;

  final screens = [
    NewRecipeScreen(),
    FavoriteScreen(),
    CategoriesScreen(),
    MenuScreen(),
    ProfileScreen(),
  ];

  static const items = <Widget>[
    Icon(Icons.add_circle_outline),
    Icon(Icons.favorite),
    Icon(Icons.apps_sharp),
    Icon(Icons.calendar_today_outlined),
    Icon(Icons.person)
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: screens[index],
      bottomNavigationBar: CurvedNavigationBar(
        key: navigationKey,
        height: 60,
        items: items,
        buttonBackgroundColor: Theme.of(context).primaryColor,
        animationDuration: const Duration(milliseconds: 300),
        backgroundColor: Colors.transparent,
        color: Theme.of(context).primaryColor,
        index: index,
        onTap: (index) {
          setState(() {
            this.index = index;
          });
        },
      ),
    );
  }
}
