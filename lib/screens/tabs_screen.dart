// import 'package:flutter/material.dart';
// import 'package:meals/screens/favorites_screen.dart';
// import 'categories_screen.dart';

// class TabScreen extends StatefulWidget {
//   const TabScreen({Key? key}) : super(key: key);

//   @override
//   State<TabScreen> createState() => _TabScreenState();
// }

// class _TabScreenState extends State<TabScreen> {
//   @override
//   Widget build(BuildContext context) {
//     //DefaultTabController - automatically changes between the differant bars (favorites and categories)
//     return DefaultTabController(
//       length: 2,
//       initialIndex: 1,
//       child: Scaffold(
//         appBar: AppBar(
//           title: const Text('Meals'),
//           bottom: const TabBar(tabs: <Widget>[
//             Tab(
//               icon: Icon(Icons.category),
//               text: 'Categories',
//             ),
//             Tab(
//               icon: Icon(Icons.star),
//               text: 'Favorites',
//             ),
//           ]),
//         ),
//         body: const TabBarView(
//           children: [
//             CategoriesScreen(),
//             FavoritesScreen(),
//           ],
//         ),
//       ),
//     );
//   }
// }

//^^^^^if you want the categories/favorites bar to be on the top^^^^^

// the is where we created the categories/favorites buttons (at the bottom of the screen)
import 'package:flutter/material.dart';
import 'package:meals/models/meal.dart';
import 'package:meals/screens/categories_screen.dart';
import 'package:meals/screens/favorites_screen.dart';
import 'package:meals/widgets/main_drawer.dart';

class TabScreen extends StatefulWidget {
  const TabScreen(this.favoriteMeals, {Key? key}) : super(key: key);

  final List<Meal> favoriteMeals;

  @override
  State<TabScreen> createState() => _TabScreenState();
}

class _TabScreenState extends State<TabScreen> {
  late List<Map<String, Object>> _pages;

  @override
  //we wrap the '_pages' in the initState, so that we can pass the 'widget' property.
  void initState() {
    _pages = [
      {
        'title': 'Categories',
        'page': const CategoriesScreen(),
      },
      {
        'title': 'Favorites',
        'page': FavoritesScreen(widget.favoriteMeals),
      }
    ];
    super.initState();
  }

//this is so that the icon can change from a empty start to a full star.
  int _selectedPageIndex = 0;

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

//creating the icons with the navigation for the buttons.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_pages[_selectedPageIndex]['title'] as String),
      ),
      drawer: const Drawer(
        child: MainDrawer(),
      ),
      body: _pages[_selectedPageIndex]['page'] as Widget,
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectPage,
        backgroundColor: Theme.of(context).primaryColor,
        unselectedItemColor: Colors.white,
        selectedItemColor: const Color.fromARGB(255, 205, 204, 204),
        currentIndex: _selectedPageIndex,
        type: BottomNavigationBarType
            .shifting, //gives it the effect when changing page.
        items: [
          BottomNavigationBarItem(
            backgroundColor: Theme.of(context).primaryColor,
            icon: const Icon(Icons.category),
            label: 'Categories',
          ),
          BottomNavigationBarItem(
            backgroundColor: Theme.of(context).primaryColor,
            icon: const Icon(Icons.star),
            label: 'Favorites',
          ),
        ],
      ),
    );
  }
}
