//this is the page where the categories screen is made.

import 'package:flutter/material.dart';

import '../dummy_data.dart';
import '../widgets/category_item.dart';


class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      //creating the background gradiant (pink->white)
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.pinkAccent,
            Colors.white,
          ],
        ),
      ),
      child: GridView(
        padding: const EdgeInsets.all(25),
        //gridDelegate - let's you decide how the grid is going to look like
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 200,
          childAspectRatio: 3 / 2,
          crossAxisSpacing: 20,
          mainAxisSpacing: 20,
        ),
        children: dummyCategories
            .map((catData) =>
                CategoryItem(catData.id, catData.title, catData.color))
            .toList(),
      ),
    );
  }
}
