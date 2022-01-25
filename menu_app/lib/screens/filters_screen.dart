import 'package:flutter/material.dart';
import 'package:menu_app/models/filters.dart';
import 'package:menu_app/screens/tabs_screen.dart';
import 'package:menu_app/widgets/main_drawer.dart';

class FiltersScreen extends StatefulWidget {
  static const String routeName = '/filters';
  final Function(Filters) saveFilters;

  const FiltersScreen(this.saveFilters, {Key? key}) : super(key: key);

  @override
  State<FiltersScreen> createState() => _FiltersScreenState();
}

class _FiltersScreenState extends State<FiltersScreen> {
  final _filters = Filters();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Your Filters'),
          actions: [
            IconButton(
              icon: const Icon(Icons.save),
              onPressed: () {
                widget.saveFilters(_filters);
                Navigator.of(context).popAndPushNamed(TabsScreen.routeName);
              },
            )
          ],
        ),
        drawer: const MainDrawer(),
        body: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              child: Text(
                'Adjust your meals selection',
                style: Theme.of(context).textTheme.headline1,
              ),
            ),
            Expanded(
              child: ListView(
                children: [
                  _buildSwitchList(
                    'Gluten Free',
                    'Only include gluten-free meals',
                    _filters.glutenFree,
                    (newValue) {
                      setState(() {
                        _filters.glutenFree = newValue;
                      });
                    },
                  ),
                  _buildSwitchList(
                    'Vegetarian',
                    'Only include vegetarian meals',
                    _filters.vegetarian,
                    (newValue) {
                      setState(() {
                        _filters.vegetarian = newValue;
                      });
                    },
                  ),
                  _buildSwitchList(
                    'Vegan',
                    'Only include vegan meals',
                    _filters.vegan,
                    (newValue) {
                      setState(() {
                        _filters.vegan = newValue;
                      });
                    },
                  ),
                  _buildSwitchList(
                    'Lactose Free',
                    'Only include lactose-free meals',
                    _filters.lactoseFree,
                    (newValue) {
                      setState(() {
                        _filters.lactoseFree = newValue;
                      });
                    },
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildSwitchList(
      String title, String description, bool value, Function(bool) onChanged) {
    return SwitchListTile(
        title: Text(title),
        subtitle: Text(description),
        activeColor: Theme.of(context).colorScheme.secondary,
        value: value,
        onChanged: onChanged);
  }
}
