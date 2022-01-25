import 'package:flutter/material.dart';
import 'package:menu_app/models/filters.dart';
import 'package:menu_app/screens/tabs_screen.dart';
import 'package:menu_app/widgets/main_drawer.dart';

class FiltersScreen extends StatefulWidget {
  static const String routeName = '/filters';
  final Filters filters;
  final Function(Filters) saveFilters;

  const FiltersScreen(this.filters, this.saveFilters, {Key? key})
      : super(key: key);

  @override
  State<FiltersScreen> createState() => _FiltersScreenState();
}

class _FiltersScreenState extends State<FiltersScreen> {
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
                widget.saveFilters(widget.filters);
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
                    widget.filters.glutenFree,
                    (newValue) {
                      setState(() {
                        widget.filters.glutenFree = newValue;
                      });
                    },
                  ),
                  _buildSwitchList(
                    'Vegetarian',
                    'Only include vegetarian meals',
                    widget.filters.vegetarian,
                    (newValue) {
                      setState(() {
                        widget.filters.vegetarian = newValue;
                      });
                    },
                  ),
                  _buildSwitchList(
                    'Vegan',
                    'Only include vegan meals',
                    widget.filters.vegan,
                    (newValue) {
                      setState(() {
                        widget.filters.vegan = newValue;
                      });
                    },
                  ),
                  _buildSwitchList(
                    'Lactose Free',
                    'Only include lactose-free meals',
                    widget.filters.lactoseFree,
                    (newValue) {
                      setState(() {
                        widget.filters.lactoseFree = newValue;
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
