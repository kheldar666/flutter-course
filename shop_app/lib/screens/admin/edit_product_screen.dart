import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class EditProductScreen extends StatefulWidget {
  static const routeName = '/admin/edit-product';
  const EditProductScreen({Key? key}) : super(key: key);

  @override
  _EditProductScreenState createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Edit Product'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(15),
          child: Form(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Title'),
                    textInputAction: TextInputAction.next,
                  ),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Price'),
                    autocorrect: false,
                    keyboardType: Platform.isIOS
                        ? const TextInputType.numberWithOptions(
                            decimal: true, signed: true)
                        : TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(
                          RegExp(r'^\d+\.?\d{0,4}'))
                    ],
                    textInputAction: TextInputAction.next,
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
