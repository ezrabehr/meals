//this is where the favorite page is created.
import 'package:flutter/material.dart';

import 'package:meals/models/meal.dart';

import '../widgets/meal_item.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen(this.favoriteMeals, {Key? key}) : super(key: key);
  final List<Meal> favoriteMeals;
  @override
  Widget build(BuildContext context) {
    if (favoriteMeals.isEmpty) {
      return const Center(
        child: (Text('You have no favorites yet - start adding some!')),
      );
    } else {
      return ListView.builder(
        itemBuilder: ((context, index) {
          return MealItem(
            //returns the favorite meals
            favoriteMeals[index].id,
            favoriteMeals[index].title,
            favoriteMeals[index].imageUrl,
            favoriteMeals[index].duration,
            favoriteMeals[index].complexity,
            favoriteMeals[index].affordability,
          );
        }),
        itemCount: favoriteMeals.length,
      );
    }
  }
}
