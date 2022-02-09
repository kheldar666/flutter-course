import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart' as syspath;

class ImageInput extends StatefulWidget {
  final void Function(File) onSelectImageCallback;
  const ImageInput(this.onSelectImageCallback, {Key? key}) : super(key: key);

  @override
  _ImageInputState createState() => _ImageInputState();
}

class _ImageInputState extends State<ImageInput> {
  File? _storedImage;
  @override
  Widget build(BuildContext context) {
    var _theme = Theme.of(context);
    return Row(
      children: [
        Container(
          width: 150,
          height: 100,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.grey,
              width: 1,
            ),
          ),
          child: _storedImage != null
              ? Image.file(
                  _storedImage!,
                  fit: BoxFit.cover,
                  width: double.infinity,
                )
              : const Text(
                  'No Image Taken.',
                  textAlign: TextAlign.center,
                ),
        ),
        const SizedBox(
          width: 10,
        ),
        Expanded(
          child: TextButton.icon(
            onPressed: _takePicture,
            icon: Icon(
              Icons.camera,
              color: _theme.primaryColor,
            ),
            label: Text(
              'Take Picture',
              style: TextStyle(color: _theme.primaryColor),
            ),
          ),
        )
      ],
    );
  }

  Future<void> _takePicture() async {
    final appDir = await syspath.getApplicationDocumentsDirectory();

    final imageFile = await ImagePicker().pickImage(
      source: ImageSource.camera,
      maxWidth: 600,
      preferredCameraDevice: CameraDevice.rear,
    );

    if (imageFile != null) {
      final fileName = path.basename(imageFile.path);
      setState(() {
        _storedImage = File(imageFile.path);
      });
      final savedImage = await _storedImage!.copy('${appDir.path}/$fileName');
      widget.onSelectImageCallback(savedImage);
    }
  }
}
