import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:great_places/contants.dart';
import 'package:http/http.dart' as http;
import 'package:location/location.dart';

class LocationHelper {
  static Uri generateLocationPreviewImageUri(LatLng location) {
    return Uri.https(kGoogleMapBaseDomain, kGoogleMapStaticPath, {
      'center': '${location.latitude},${location.longitude}',
      'maptype': 'roadmap',
      'zoom': '16',
      'size': '600x300',
      'markers': 'color:red|label:C|${location.latitude},${location.longitude}',
      'key': dotenv.get('GOOGLE_MAPS_API_KEY'),
    });
  }

  static Future<String> getPlaceAddress(LatLng location) async {
    final uri = Uri.https(kGoogleMapBaseDomain, kGoogleMapGeocodingPath, {
      'latlng': '${location.latitude},${location.longitude}',
      'key': dotenv.get('GOOGLE_MAPS_API_KEY')
    });
    final response = await http.get(uri);
    return json.decode(response.body)['results'][0]['formatted_address'];
  }

  static Future<LocationData> getCurrentLocation() async {
    return Location().getLocation();
  }
}
