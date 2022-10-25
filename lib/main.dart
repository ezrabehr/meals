//this is the main page, where we pass all the info, cus all the pages are linkes to here.
import 'package:flutter/material.dart';
import 'package:meals/dummy_data.dart';
import 'package:meals/models/meal.dart';
import 'package:meals/screens/category_meals_screen.dart';
import 'package:meals/screens/meal_detail_screen.dart';
import 'package:meals/screens/settings_screen.dart';
import 'package:meals/screens/tabs_screen.dart';
import 'screens/categories_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Map<String, bool> _filters = {
    'gluten': false,
    'lactose': false,
    'vegan': false,
    'vegetarian': false,
  };

  List<Meal> _availableMeals = dummyMeals;
  final List<Meal> _favoritesMeals = [];

  void _setFilters(Map<String, bool> filterData) {
    //checking if the toggles are true of false.
    setState(() {
      _filters = filterData;
      _availableMeals = dummyMeals.where((meal) {
        if ((_filters['gluten'] ?? false) && !meal.isGlutenFree) {
          return false;
        }
        if ((_filters['lactose'] ?? false) && !meal.isLactoseFree) {
          return false;
        }
        if ((_filters['vegan'] ?? false) && !meal.isVegan) {
          return false;
        }
        if ((_filters['vegetarian'] ?? false) && !meal.isVegetarian) {
          return false;
        }
        return true;
      }).toList();
    });
  }

//deciding if to add or to remove the meal for the favorite list.
  void _toggleFavorite(String mealId) {
    final existingIndex =
        _favoritesMeals.indexWhere((meal) => meal.id == mealId);
    if (existingIndex >= 0) {
      setState(() {
        _favoritesMeals.removeAt(existingIndex);
      });
    } else {
      setState(() {
        _favoritesMeals.add(
          dummyMeals.firstWhere((meal) => meal.id == mealId),
        );
      });
    }
  }

//checks if the meal is in the favorite list.
  bool _isMealFavorite(String id) {
    return _favoritesMeals.any((meal) => meal.id == id);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        //debugShowCheckedModeBanner - takes off the demo ribbon on the side of the page.
        debugShowCheckedModeBanner: false,
        title: 'DeliMeals',
        theme: ThemeData(
          primarySwatch: Colors.pink,
          splashColor: Colors.redAccent,
          canvasColor: const Color.fromARGB(255, 249, 136, 185),
          fontFamily: 'RobotoCondensed',
          textTheme: ThemeData.light().textTheme.copyWith(
                bodyText1: const TextStyle(
                  color: Color.fromRGBO(20, 51, 51, 1),
                ),
                bodyText2: const TextStyle(
                  color: Color.fromRGBO(20, 51, 51, 1),
                ),
                headline6: const TextStyle(
                  fontSize: 20,
                  fontFamily: 'Raleway',
                  fontWeight: FontWeight.bold,
                ),
              ),
        ),

        //this is where all the passing data is, very important to remember.
        //home: marks the opening screen
        initialRoute: '/', //default is '/'
        routes: {
          '/': (context) => TabScreen(_favoritesMeals),
          CategoryMealsScreen.routeName: ((context) =>
              CategoryMealsScreen(_availableMeals)),
          MealDetailScreen.routeName: ((context) =>
              MealDetailScreen(_toggleFavorite, _isMealFavorite)),
          SettingsScreen.routeName: ((context) =>
              SettingsScreen(_setFilters, _filters)),
        },
        //onGenerateRoute - if you call a wrong route.
        onGenerateRoute: (settings) {
          return MaterialPageRoute(
            builder: ((context) => const CategoriesScreen()),
          );
        },
        //onUnknownRoute- if nothing is good, it will call this page (fallback page)
        onUnknownRoute: (settings) {
          return MaterialPageRoute(
            builder: ((context) => const CategoriesScreen()),
          );
        });
  }
}
