import 'package:cook_app/components/week_plan/specific_day.dart';
import 'package:cook_app/models/week_plan.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cook_app/providers/recipe.dart';

class MenuScreen extends StatefulWidget {
  static const routeName = '/menu';

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  Recipe? _weekPlanProvider;
  bool _isLoading = true;
  WeekPlan? weekPlan;

  @override
  void initState() {
    _weekPlanProvider = Provider.of<Recipe>(context, listen: false);
    Future.delayed(Duration.zero).then((_) {
      _weekPlanProvider!.fetchWeekPlan().then((value) {
        setState(() {
          weekPlan = value;
          _isLoading = false;
        });
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? Scaffold(
            body: Center(
            child: CircularProgressIndicator(
              color: Theme.of(context).primaryColor,
            ),
          ))
        : Scaffold(
            bottomSheet: Material(
              color: Colors.transparent,
              child: Container(
                margin: const EdgeInsets.only(bottom: 70),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    RaisedButton(
                      onPressed: () {
                        print('shopping list');
                      },
                      child: Row(
                        children: [
                          const Icon(Icons.shopping_basket_outlined),
                          const SizedBox(
                            width: 10,
                          ),
                          const Text('Go to shopping list'),
                        ],
                      ),
                      color: Theme.of(context).primaryColor,
                      textColor: Colors.white,
                    ),
                  ],
                ),
              ),
            ),
            appBar: AppBar(
              title: const Text('Menu for this week'),
            ),
            body: SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.only(
                    top: 10, left: 0, right: 0, bottom: 40),
                child: Column(
                  children: weekPlan!.days
                      .map((day) => SpecificDay(
                            day: day,
                            removeFromMenu:
                                _weekPlanProvider!.deleteRecipeFromMenu,
                          ))
                      .toList(),
                ),
              ),
            ),
          );
  }
}
