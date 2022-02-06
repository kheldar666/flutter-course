import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shop_app/models/edit_product.dart';

class EditProductScreen extends StatefulWidget {
  static const routeName = '/admin/edit-product';
  const EditProductScreen({Key? key}) : super(key: key);

  @override
  _EditProductScreenState createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  final _imageUrlController = TextEditingController();
  final _imageUrlFocusNode = FocusNode();
  final _formKey = GlobalKey<FormState>();
  var newProduct = EditProduct();

  @override
  void initState() {
    super.initState();
    _imageUrlFocusNode.addListener(_updateImagePreview);
  }

  @override
  void dispose() {
    super.dispose();
    // That prevents memory leaks
    _imageUrlController.dispose();
    _imageUrlFocusNode.removeListener(_updateImagePreview);
    _imageUrlFocusNode.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Edit Product'),
          actions: [
            IconButton(
              onPressed: _saveForm,
              icon: const Icon(Icons.save),
            )
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(15),
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Title'),
                    textInputAction: TextInputAction.next,
                    onSaved: (title) {
                      newProduct.title = title.toString();
                    },
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
                    onSaved: (price) {
                      price != null
                          ? newProduct.price = double.parse(price)
                          : newProduct.price = 0;
                    },
                  ),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Description'),
                    maxLines: 3,
                    keyboardType: TextInputType.multiline,
                    onSaved: (description) {
                      newProduct.description = description.toString();
                    },
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 100,
                        height: 100,
                        margin: const EdgeInsets.only(
                          top: 8,
                          right: 10,
                        ),
                        decoration: BoxDecoration(
                          border: Border.all(
                            width: 1,
                            color: Colors.grey,
                          ),
                        ),
                        child: !_isImageUrlValid()
                            ? const Center(child: Text('Enter URL'))
                            : Image.network(
                                _imageUrlController.text,
                                fit: BoxFit.cover,
                              ),
                      ),
                      Expanded(
                        child: TextFormField(
                          decoration:
                              const InputDecoration(labelText: 'Image URL'),
                          // http://www.i2clipart.com/cliparts/8/3/d/c/clipart-book-256x256-83dc.png
                          keyboardType: TextInputType.url,
                          textInputAction: TextInputAction.done,
                          controller: _imageUrlController,
                          focusNode: _imageUrlFocusNode,
                          onFieldSubmitted: (_) {
                            _saveForm();
                          },
                          onEditingComplete: () {
                            setState(() {});
                          },
                          onSaved: (imageUrl) {
                            _isImageUrlValid()
                                ? newProduct.imageUrl = imageUrl.toString()
                                : newProduct.imageUrl = '';
                          },
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _updateImagePreview() {
    if (!_imageUrlFocusNode.hasFocus) {
      setState(() {});
    }
  }

  bool _isImageUrlValid() {
    if (Uri.parse(_imageUrlController.text).isAbsolute) {
      return true;
    } else {
      _imageUrlController.clear();
      return false;
    }
  }

  void _saveForm() {
    _formKey.currentState?.save();
    print(newProduct.toString());
  }
}
