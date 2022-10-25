import 'package:flutter/material.dart';
import 'package:meals/models/meal.dart';
import 'package:meals/widgets/meal_item.dart';

class CategoryMealsScreen extends StatefulWidget {
  static const routeName = '/category-meals';

  final List<Meal> availableMeals;

  const CategoryMealsScreen(this.availableMeals, {Key? key}) : super(key: key);

  @override
  State<CategoryMealsScreen> createState() => _CategoryMealsScreenState();
}

class _CategoryMealsScreenState extends State<CategoryMealsScreen> {
  String? categoryTitle = 'potatoes';
  late List<Meal> displayedMeals;
  @override
  
  @override
  //runs after a dependencie changed.
  //displays the catergories 
  void didChangeDependencies() {
    final routeArgs =
        ModalRoute.of(context)!.settings.arguments as Map<String, String>;
    final catergoryId = routeArgs['id'];
    categoryTitle = routeArgs['title'];
    displayedMeals = widget.availableMeals.where(
      (meal) {
        return meal.categories.contains(catergoryId);
      },
    ).toList();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(categoryTitle!),
      ),
      body: Container(
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
        //builder - only renders what's on the screen
        child: ListView.builder(
          itemBuilder: ((context, index) {
            return MealItem(
              displayedMeals[index].id,
              displayedMeals[index].title,
              displayedMeals[index].imageUrl,
              displayedMeals[index].duration,
              displayedMeals[index].complexity,
              displayedMeals[index].affordability,
            );
          }),
          itemCount: displayedMeals.length,
        ),
      ),
    );
  }
}
