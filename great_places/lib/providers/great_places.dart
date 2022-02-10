import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:great_places/models/place_location.dart';

import '/helpers/db_helper.dart';
import '/models/place.dart';

class GreatPlaces with ChangeNotifier {
  List<Place> _places = [];

  List<Place> get places => [..._places];

  void addPlace(String title, File image, PlaceLocation location) {
    final newPlace = Place(
      title: title,
      image: image,
      location: location,
    );
    _places.add(newPlace);
    DbHelper.insert(DbHelper.kPlacesTable, {
      'id': newPlace.id,
      'title': newPlace.title,
      'image': newPlace.image.path,
      'address': json.encode(newPlace.location.toJson()),
    });
    notifyListeners();
  }

  Future<void> fetchAndSetPlaces() async {
    final dataList = await DbHelper.select(DbHelper.kPlacesTable);
    _places = dataList
        .map((data) => Place(
              id: data['id'],
              title: data['title'],
              image: File(data['image']),
              location: PlaceLocation.fromJson(json.decode(data['address'])),
            ))
        .toList();
  }
}
