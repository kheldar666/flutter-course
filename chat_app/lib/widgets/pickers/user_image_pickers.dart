import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UserImagePicker extends StatefulWidget {
  final Function(File) pickImageCallback;
  const UserImagePicker(this.pickImageCallback, {Key? key}) : super(key: key);

  @override
  _UserImagePickerState createState() => _UserImagePickerState();
}

class _UserImagePickerState extends State<UserImagePicker> {
  File? _pickedImage;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: 40,
          backgroundColor: Colors.grey,
          backgroundImage:
              (_pickedImage != null) ? FileImage(_pickedImage!) : null,
        ),
        TextButton.icon(
          onPressed: () async {
            _pickImage();
          },
          icon: const Icon(Icons.image),
          label: const Text('Add image'),
        )
      ],
    );
  }

  Future<void> _pickImage() async {
    final pickedImage = await ImagePicker().pickImage(
      source: ImageSource.camera,
      imageQuality: 50,
      maxWidth: 150,
    );
    if (pickedImage != null) {
      setState(() {
        _pickedImage = File(pickedImage.path);
        widget.pickImageCallback(_pickedImage!);
      });
    }
  }
}
