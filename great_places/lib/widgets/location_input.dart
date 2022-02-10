import 'package:flutter/material.dart';
import 'package:location/location.dart';

class LocationInput extends StatefulWidget {
  const LocationInput({Key? key}) : super(key: key);

  @override
  _LocationInputState createState() => _LocationInputState();
}

class _LocationInputState extends State<LocationInput> {
  String? _previewImageUrl;
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
          child: _previewImageUrl == null
              ? const Center(
                  child: Text(
                  'No Location Chosen',
                  textAlign: TextAlign.center,
                ))
              : Image.network(
                  _previewImageUrl!,
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
              onPressed: () {},
              icon: Icon(
                Icons.location_on,
                color: _theme.primaryColor,
              ),
              label: Text(
                'Select Location',
                style: TextStyle(color: _theme.primaryColor),
              ),
            ),
          ],
        )
      ],
    );
  }

  Future<void> _getCurrentUserLocation() async {
    final location = await Location().getLocation();
    print(location);
  }
}
