//this is where we create the main category item page. (the fist page as you enter the app)
import 'package:flutter/material.dart';
import 'package:meals/screens/category_meals_screen.dart';

class CategoryItem extends StatelessWidget {
  final String title;
  final String id;
  final Color color;

//giving names for the route
  void selectCategory(BuildContext context) {
    Navigator.of(context).pushNamed(
      CategoryMealsScreen.routeName,
      arguments: {
        'id': id,
        'title': title,
      },
    );
  }

//the UI for the page.
  const CategoryItem(this.id, this.title, this.color, {Key? key})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (() => selectCategory(context)),
      splashColor: Theme.of(context).primaryColor,
      borderRadius: BorderRadius.circular(15),
      child: Container(
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              color.withOpacity(0.7),
              color,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Text(
          title,
          style: Theme.of(context).textTheme.headline6,
        ),
      ),
    );
  }
}
