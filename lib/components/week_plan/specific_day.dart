import 'package:cook_app/components/week_plan/dismissible_widget.dart';
import 'package:cook_app/models/day.dart';
import 'package:flutter/material.dart';

class SpecificDay extends StatelessWidget {
  final Day day;
  final Function removeFromMenu;
  SpecificDay({Key? key, required this.day, required this.removeFromMenu})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(5),
      child: Column(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.only(left: 15),
              child: Text(
                '${shortToFullNameMap[day.name]}',
                style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 19),
              ),
            ),
          ),
          Divider(
            color: Theme.of(context).primaryColor,
          ),
          ...day.recipes
              .map((recipe) => DismissibleWidget(
                    key: UniqueKey(),
                    item: recipe,
                    child: ListTile(
                      // contentPadding: ,
                      leading: const CircleAvatar(
                        backgroundImage: NetworkImage(
                            "https://domowe-wypieki.com/wp-content/uploads/2019/08/p%C3%B3lkule-413x247.jpg"),
                      ),
                      title: Text(recipe.title),
                      // onTap: () => Navigator.of(context).pushReplacementNamed('/'),
                    ),
                    onDismissed: (_) => dismissRecipe(recipe),
                  ))
              .toList(),
        ],
      ),
    );
  }

  void dismissRecipe(recipe) {
    removeFromMenu(recipe.id, day.id);
  }

  Map<String, String> shortToFullNameMap = {
    "Mon": "Monday",
    "Tue": "Tuesday",
    "Wed": "Wednesday",
    "Thu": "Thursday",
    "Fri": "Friday",
    "Sat": "Saturday",
    "Sun": "Sunday"
  };
}
