import 'dart:io';

import '/models/place_location.dart';
import 'package:uuid/uuid.dart';

class Place {
  late String? id;
  final String title;
  final PlaceLocation? location;
  final File image;

  Place({
    this.id,
    required this.title,
    required this.location,
    required this.image,
  }) {
    id ?? const Uuid().v4().toString();
  }
}
