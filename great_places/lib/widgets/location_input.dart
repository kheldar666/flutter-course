import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:great_places/helpers/location_helper.dart';
import 'package:great_places/screens/map_screen.dart';

class LocationInput extends StatefulWidget {
  final Function(LatLng) onSelectLocation;
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
    final location = await LocationHelper.getCurrentLocation();
    final coordinates = LatLng(location.latitude!, location.longitude!);
    setState(() {
      _previewImageUri =
          LocationHelper.generateLocationPreviewImageUri(coordinates);
    });
    widget.onSelectLocation(coordinates);
  }

  Future<void> _selectOnMap() async {
    final selectedLocation = await Navigator.of(context).push<LatLng>(
      MaterialPageRoute(
        builder: (ctx) => const MapScreen(
          isSelecting: true,
        ),
      ),
    );
    if (selectedLocation == null) {
      return;
    }
    setState(() {
      _previewImageUri =
          LocationHelper.generateLocationPreviewImageUri(selectedLocation);
    });
    widget.onSelectLocation(selectedLocation);
  }
}
