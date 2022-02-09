import 'package:flutter/material.dart';
import 'package:great_places/providers/great_places.dart';
import 'package:great_places/screens/add_place_screen.dart';
import 'package:provider/provider.dart';

class PlacesListScreen extends StatelessWidget {
  const PlacesListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Your Places'),
          actions: [
            IconButton(
                onPressed: () =>
                    Navigator.of(context).pushNamed(AddPlaceScreen.routeName),
                icon: const Icon(Icons.add))
          ],
        ),
        body: Consumer<GreatPlaces>(
          builder: (
            ctx,
            greatPlaces,
            child,
          ) =>
              greatPlaces.places.isNotEmpty
                  ? ListView.builder(
                      itemCount: greatPlaces.places.length,
                      itemBuilder: (ctx, index) => ListTile(
                        leading: CircleAvatar(
                          backgroundImage:
                              FileImage(greatPlaces.places[index].image),
                        ),
                        title: Text(greatPlaces.places[index].title),
                      ),
                    )
                  : child!,
          child: const Center(
            child: Text('You don\'t have Places yet. Add some !'),
          ),
        ),
      ),
    );
  }
}
