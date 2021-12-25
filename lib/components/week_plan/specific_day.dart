import 'package:cook_app/models/day.dart';
import 'package:flutter/material.dart';

class SpecificDay extends StatelessWidget {
  Day day;

  SpecificDay({Key? key, required this.day}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      child: Column(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              '${shortToFullNameMap[day.name]}',
              style: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 19),
            ),
          ),
          Divider(
            color: Theme.of(context).primaryColor,
          ),
          ...day.recipes
              .map((recipe) => ListTile(
                    leading: const CircleAvatar(
                      backgroundImage: NetworkImage(
                          "https://domowe-wypieki.com/wp-content/uploads/2019/08/p%C3%B3lkule-413x247.jpg"),
                    ),
                    title: Text(recipe.title),
                  ))
              .toList(),
        ],
      ),
    );
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
