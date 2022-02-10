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
  PlaceLocation? _initialLocation;
  LatLng? _pickedLocation;
  @override
  void initState() {
    super.initState();
    _initialLocation = widget.initialLocation;
    if (_initialLocation == null) {
      LocationHelper.getCurrentLocation().then((currentLocation) {
        setState(() {
          _initialLocation = PlaceLocation(
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
                  onPressed: _pickedLocation == null
                      ? null
                      : () {
                          Navigator.of(context).pop(_pickedLocation);
                        },
                  icon: const Icon(Icons.check)),
          ],
        ),
        body: _initialLocation == null
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : GoogleMap(
                initialCameraPosition: CameraPosition(
                  target: LatLng(
                    _initialLocation!.latitude,
                    _initialLocation!.longitude,
                  ),
                  zoom: 16,
                ),
                onTap: widget.isSelecting ? _selectLocation : null,
                markers: _pickedLocation == null
                    ? {}
                    : {
                        Marker(
                          markerId: MarkerId(DateTime.now.toString()),
                          position: _pickedLocation!,
                        )
                      },
              ),
      ),
    );
  }

  void _selectLocation(LatLng position) {
    setState(() {
      _pickedLocation = position;
    });
  }
}
