import 'dart:ui';

import 'package:cook_app/models/recipe_item.dart';
import 'package:cook_app/screens/recepies/recipe.dart';
import 'package:flutter/material.dart';

class RecipeIcon extends StatelessWidget {
  final RecipeItem recipeItem;

  RecipeIcon({Key? key, required this.recipeItem}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context)
            .popAndPushNamed(RecipeScreen.routeName, arguments: recipeItem);
      },
      child: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(15),
                topRight: Radius.circular(15),
              ),
              child: Image.network(
                  "https://domowe-wypieki.com/wp-content/uploads/2019/08/p%C3%B3lkule-413x247.jpg",
                  height: 200,
                  width: double.infinity,
                  fit: BoxFit.cover), //Image.asset -> locally
            ),
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                border: Border.all(color: Theme.of(context).primaryColorLight),
                borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(15),
                    bottomRight: Radius.circular(15)),
                color: Theme.of(context).primaryColorLight,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    flex: 3,
                    child: Text(
                      recipeItem.title,
                      style: TextStyle(
                        fontSize: 20,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                  Flexible(
                    child: Row(
                      children: [
                        const Icon(
                          Icons.timer,
                          color: Colors.teal,
                        ),
                        Text('${recipeItem.time}\'')
                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
