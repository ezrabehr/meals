import 'package:flutter/material.dart';
import 'package:meals/dummy_data.dart';

class MealDetailScreen extends StatelessWidget {
  const MealDetailScreen(this.toggleFavorite, this.isFavorite, {Key? key})
      : super(key: key);

  static const routeName = '/meal-detail';

  final Function toggleFavorite;
  final Function isFavorite;

//a function to create section title.
  Widget buildSectionTitle(String text, BuildContext context) {
    return Center(
      child: Container(
        margin: const EdgeInsets.symmetric(
          vertical: 10,
        ),
        child: Center(
          child: Text(
            text,
            style: Theme.of(context).textTheme.headline6,
          ),
        ),
      ),
    );
  }

//a function to create containers.
  Widget buildContainer(Widget child) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(10),
      ),
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(10),
      height: 150,
      width: 300,
      child: child,
    );
  }

//this is UI of the page, where we present all the info (how to make it, the ingrediants...)
  @override
  Widget build(BuildContext context) {
    final mealId = ModalRoute.of(context)!.settings.arguments as String;
    final selectedMeal = dummyMeals.firstWhere((meal) => meal.id == mealId);
    return Scaffold(
      appBar: AppBar(
        title: Text(selectedMeal.title),
      ),
      body: ListView(
        children: [
          SizedBox(
            height: 300,
            width: double.infinity,
            child: Image.network(
              selectedMeal.imageUrl,
              fit: BoxFit.cover,
            ),
          ),
          buildSectionTitle('Ingerdients', context),
          buildContainer(
            ListView.builder(
              itemBuilder: (context, index) => Card(
                color: Theme.of(context).splashColor,
                child: Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 5,
                      horizontal: 10,
                    ),
                    child: Text(selectedMeal.ingredients[index])),
              ),
              itemCount: selectedMeal.ingredients.length,
            ),
          ),
          buildSectionTitle('Steps', context),
          buildContainer(
            ListView.builder(
              itemBuilder: (context, index) => Column(
                children: [
                  ListTile(
                    leading: CircleAvatar(
                      child: Text('#${(index + 1)}'),
                    ),
                    title: Text(selectedMeal.steps[index]),
                  ),
                  const Divider(),
                ],
              ),
              itemCount: selectedMeal.steps.length,
            ),
          ),
        ],
      ),

      //the favorite button, to add the recipe to the favorite list.
      floatingActionButton: FloatingActionButton(
        child: Icon(
          isFavorite(mealId) ? Icons.star : Icons.star_border,
        ),
        onPressed: () => toggleFavorite(mealId),
      ),
    );
  }
}
