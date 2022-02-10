import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:great_places/helpers/location_helper.dart';

class PlaceLocation {
  final double latitude;
  final double longitude;
  late String address;

  PlaceLocation({
    required this.latitude,
    required this.longitude,
    this.address = '',
  }) {
    if (address.isEmpty) {
      LocationHelper.getPlaceAddress(latlng).then((add) {
        address = add;
      });
    }
  }

  LatLng get latlng => LatLng(latitude, longitude);

  factory PlaceLocation.fromJson(Map<String, dynamic> json) => PlaceLocation(
        latitude: (json['latitude'] as num).toDouble(),
        longitude: (json['longitude'] as num).toDouble(),
        address: json['address'],
      );

  Map<String, dynamic> toJson() => <String, dynamic>{
        'latitude': latitude,
        'longitude': longitude,
        'address': address,
      };
}
