import 'package:flutter/material.dart';
import 'package:great_places/models/place.dart';
import 'package:great_places/screens/map_screen.dart';

class PlaceDetailScreen extends StatelessWidget {
  static const routeName = '/place-detail';

  const PlaceDetailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final place = ModalRoute.of(context)?.settings.arguments as Place;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(place.title),
        ),
        body: Column(
          children: [
            SizedBox(
              height: 250,
              width: double.infinity,
              child: Image.file(
                place.image,
                fit: BoxFit.cover,
                width: double.infinity,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              place.location.address,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 20,
                color: Colors.grey,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            TextButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (ctx) => MapScreen(
                        initialLocation: place.location,
                        isSelecting: false,
                      ),
                    ),
                  );
                },
                child: Text(
                  'View on the Map',
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
