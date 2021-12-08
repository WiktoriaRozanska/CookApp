import 'package:flutter/material.dart';

class StepList extends StatelessWidget {
  List<String> steps;

  StepList({Key? key, required this.steps}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: Column(
        children: steps.map((step) {
          return ListTile(
            leading: CircleAvatar(
              backgroundColor: Theme.of(context).primaryColorLight,
              child: FittedBox(
                child: Text(
                  '${steps.indexOf(step) + 1}',
                  style: const TextStyle(color: Colors.white),
                ),
              ),
            ),
            title: Text(step),
          );
        }).toList(),
      ),
    );
  }
}
