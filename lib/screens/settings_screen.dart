//make the categorie go away if there is no meal in it.
//add an option to add new recipies.


//this page is the settings page, where we toggle the gluten, vegetarian, vegan and lactose toggles.
import 'package:flutter/material.dart';
import 'package:meals/widgets/main_drawer.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen(this.saveFilters, this.currentFilters, {Key? key})
      : super(key: key);

  static const routeName = '/settings';

  final Function saveFilters;
  final Map<String, bool> currentFilters;

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _glutenFree = false;
  bool _vegetarian = false;
  bool _vegan = false;
  bool _lactoseFree = false;

  @override
  void initState() {
    _glutenFree = widget.currentFilters['gluten']!;
    _vegan = widget.currentFilters['vegan']!;
    _vegetarian = widget.currentFilters['vegetarian']!;
    _lactoseFree = widget.currentFilters['lactose']!;
    super.initState();
  }
  //a function to create a switch list tile.
  Widget _buildSwitchListTile(
    String name,
    String subtitle,
    bool value,
    Function(bool) updateValue,
  ) {
    //SwitchListTile - is good for when you wan to have text + a switch
    return SwitchListTile(
      title: Text(
        name,
        style: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
      subtitle: Text(subtitle),
      value: value,
      onChanged: updateValue,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('settings'),
        actions: [
          IconButton(
            onPressed: () {
              final selectedFilters = {
                'gluten': _glutenFree,
                'lactose': _lactoseFree,
                'vegan': _vegan,
                'vegetarian': _vegetarian,
              };
              widget.saveFilters(selectedFilters);
              Navigator.of(context).pushReplacementNamed('/');
            },
            icon: const Icon(Icons.save),
          ),
        ],
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
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              child: Text(
                'Adjust your meal selection.',
                style: Theme.of(context).textTheme.headline6,
              ),
            ),
            Expanded(
              child: ListView(
                children: [
                  _buildSwitchListTile(
                    'Gluten Free',
                    'Only include gluten free meals.',
                    _glutenFree,
                    (context) {
                      setState(() {
                        _glutenFree = context;
                      });
                    },
                  ),
                  _buildSwitchListTile(
                    'Vegetarian',
                    'Only includes vegetarian meals.',
                    _vegetarian,
                    (context) {
                      setState(() {
                        _vegetarian = context;
                      });
                    },
                  ),
                  _buildSwitchListTile(
                    'Vegan',
                    'Only includes vegan meals.',
                    _vegan,
                    (context) {
                      setState(() {
                        _vegan = context;
                      });
                    },
                  ),
                  _buildSwitchListTile(
                    'Lactose Free',
                    'Only includes lactose free meals.',
                    _lactoseFree,
                    (context) {
                      setState(() {
                        _lactoseFree = context;
                      });
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      drawer: const MainDrawer(),
    );
  }
}
