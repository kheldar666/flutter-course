import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:great_places/helpers/location_helper.dart';
import 'package:great_places/models/place_location.dart';

class MapScreen extends StatefulWidget {
  final PlaceLocation? initialLocation;
  final bool isSelecting;

  const MapScreen({this.initialLocation, this.isSelecting = false, Key? key})
      : super(key: key);

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  PlaceLocation? _location;

  @override
  void initState() {
    super.initState();
    _location = widget.initialLocation;
    if (_location == null) {
      LocationHelper.getCurrentLocation().then((currentLocation) {
        setState(() {
          _location = PlaceLocation(
              latitude: currentLocation.latitude!,
              longitude: currentLocation.longitude!);
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Your Map'),
          actions: [
            if (widget.isSelecting)
              IconButton(
                onPressed: _location == null
                    ? null
                    : () {
                        Navigator.of(context).pop(_location);
                      },
                icon: const Icon(Icons.check),
              ),
          ],
        ),
        body: _location == null
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : GoogleMap(
                initialCameraPosition: CameraPosition(
                  target: LatLng(
                    _location!.latitude,
                    _location!.longitude,
                  ),
                  zoom: 16,
                ),
                onTap: widget.isSelecting ? _selectLocation : null,
                markers: _location == null
                    ? {}
                    : {
                        Marker(
                          markerId: MarkerId(DateTime.now.toString()),
                          position: _location!.latlng,
                        )
                      },
              ),
      ),
    );
  }

  void _selectLocation(LatLng position) {
    setState(() {
      _location = PlaceLocation(
        latitude: position.latitude,
        longitude: position.longitude,
      );
    });
  }
}
