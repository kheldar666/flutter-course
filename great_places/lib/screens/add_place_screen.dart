import 'dart:io';

import 'package:flutter/material.dart';
import 'package:great_places/models/place_location.dart';
import 'package:great_places/widgets/location_input.dart';
import 'package:provider/provider.dart';

import '/providers/great_places.dart';
import '/widgets/image_input.dart';

class AddPlaceScreen extends StatefulWidget {
  static const routeName = '/add-place';

  const AddPlaceScreen({Key? key}) : super(key: key);

  @override
  _AddPlaceScreenState createState() => _AddPlaceScreenState();
}

class _AddPlaceScreenState extends State<AddPlaceScreen> {
  final _titleTextController = TextEditingController();
  File? _pickedImage;
  PlaceLocation? _pickedLocation;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Add a new Place'),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    children: [
                      TextField(
                        decoration: const InputDecoration(
                          label: Text('Title'),
                        ),
                        controller: _titleTextController,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      ImageInput(_selectImage),
                      const SizedBox(
                        height: 10,
                      ),
                      LocationInput(_selectLocation),
                    ],
                  ),
                ),
              ),
            ),
            ElevatedButton.icon(
              onPressed: _savePlace,
              icon: const Icon(Icons.add),
              label: const Text('Add Place'),
            )
          ],
        ),
      ),
    );
  }

  void _selectImage(File image) {
    _pickedImage = image;
  }

  void _selectLocation(PlaceLocation location) {
    _pickedLocation = location;
  }

  void _savePlace() {
    if (_titleTextController.text.isEmpty ||
        _pickedImage == null ||
        _pickedLocation == null) {
      return;
    } else {
      final _greatPlaces = Provider.of<GreatPlaces>(context, listen: false);
      _greatPlaces.addPlace(
          _titleTextController.text, _pickedImage!, _pickedLocation!);
      Navigator.of(context).pop();
    }
  }
}
