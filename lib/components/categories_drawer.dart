import 'package:cook_app/screens/recepies/filters.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';

class CategoriesDrawer extends StatelessWidget {
  Function addOrRemove;

  CategoriesDrawer({Key? key, required this.addOrRemove}) : super(key: key);

  Widget buildListTile(
      String title, IconData iconData, VoidCallback tapHandler) {
    return ListTile(
      leading: Icon(
        iconData,
        size: 26,
      ),
      title: Text(title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          )),
      onTap: tapHandler,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          Container(
            height: 120,
            width: double.infinity,
            padding: const EdgeInsets.all(15),
            alignment: Alignment.center,
            color: Theme.of(context).primaryColor,
            child: const Text(
              'Cooking up!',
              style: TextStyle(
                  fontWeight: FontWeight.w900,
                  color: Colors.white,
                  fontSize: 24),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          buildListTile('Filters', Icons.filter_alt_outlined, () {
            Navigator.of(context)
                .pushNamed(FiltersScreen.routeName, arguments: addOrRemove);
          }),
          buildListTile('My recipes', Icons.book, () {
            Navigator.of(context)
                .pushNamed(FiltersScreen.routeName, arguments: addOrRemove);
          }),
          Expanded(child: Container()),
          // decoration
          SvgPicture.asset(
            'assets/images/undraw_barbecue_3x93.svg',
            width: 120,
            height: 120,
            fit: BoxFit.contain,
          ),
          const SizedBox(
            height: 80,
          )
        ],
      ),
    );
  }
}
