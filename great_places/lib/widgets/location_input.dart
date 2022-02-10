import 'package:flutter/material.dart';
import 'package:great_places/helpers/location_helper.dart';
import 'package:great_places/models/place_location.dart';
import 'package:great_places/screens/map_screen.dart';

class LocationInput extends StatefulWidget {
  final Function(PlaceLocation) onSelectLocation;
  const LocationInput(this.onSelectLocation, {Key? key}) : super(key: key);

  @override
  _LocationInputState createState() => _LocationInputState();
}

class _LocationInputState extends State<LocationInput> {
  Uri? _previewImageUri;
  @override
  Widget build(BuildContext context) {
    var _theme = Theme.of(context);
    return Column(
      children: [
        Container(
          height: 170,
          width: double.infinity,
          alignment: Alignment.center,
          decoration:
              BoxDecoration(border: Border.all(color: Colors.grey, width: 1)),
          child: _previewImageUri == null
              ? const Center(
                  child: Text(
                  'No Location Chosen',
                  textAlign: TextAlign.center,
                ))
              : Image.network(
                  _previewImageUri!.toString(),
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton.icon(
              onPressed: _getCurrentUserLocation,
              icon: Icon(
                Icons.location_on,
                color: _theme.primaryColor,
              ),
              label: Text(
                'Current Location',
                style: TextStyle(color: _theme.primaryColor),
              ),
            ),
            TextButton.icon(
              onPressed: _selectOnMap,
              icon: Icon(
                Icons.map,
                color: _theme.primaryColor,
              ),
              label: Text(
                'Select on Map',
                style: TextStyle(color: _theme.primaryColor),
              ),
            ),
          ],
        )
      ],
    );
  }

  Future<void> _getCurrentUserLocation() async {
    final locationData = await LocationHelper.getCurrentLocation();
    final placeLocation = PlaceLocation(
        latitude: locationData.latitude!, longitude: locationData.longitude!);
    setState(() {
      _previewImageUri =
          LocationHelper.generateLocationPreviewImageUri(placeLocation.latlng);
    });
    widget.onSelectLocation(placeLocation);
  }

  Future<void> _selectOnMap() async {
    final selectedPlaceLocation =
        await Navigator.of(context).push<PlaceLocation>(
      MaterialPageRoute(
        builder: (ctx) => const MapScreen(
          isSelecting: true,
        ),
      ),
    );
    if (selectedPlaceLocation == null) {
      return;
    }
    setState(() {
      _previewImageUri = LocationHelper.generateLocationPreviewImageUri(
          selectedPlaceLocation.latlng);
    });
    widget.onSelectLocation(selectedPlaceLocation);
  }
}
