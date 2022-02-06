import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/models/edit_product.dart';
import 'package:shop_app/providers/product.dart';
import 'package:shop_app/providers/products.dart';

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
  var _isLoaded = false;
  var _isEditMode = false;
  var editedProduct = EditProduct();

  @override
  void initState() {
    super.initState();

    _imageUrlFocusNode.addListener(_updateImagePreview);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_isLoaded) {
      final productToEdit = ModalRoute.of(context)?.settings.arguments;
      if (productToEdit is Product) {
        editedProduct.title = productToEdit.title;
        editedProduct.description = productToEdit.description;
        editedProduct.imageUrl = productToEdit.imageUrl;
        editedProduct.price = productToEdit.price;
        editedProduct.id = productToEdit.id;
        _imageUrlController.text = editedProduct.imageUrl;
        _isEditMode = true;
      }
      _isLoaded = true;
    }
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
          title: _isEditMode
              ? const Text('Edit a Product')
              : const Text('Add a Product'),
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
                    initialValue: editedProduct.title,
                    textInputAction: TextInputAction.next,
                    validator: (title) {
                      String? error = 'Please input a title';
                      if (title != null && title.isNotEmpty) {
                        error = null;
                      }
                      return error;
                    },
                    onSaved: (title) {
                      editedProduct.title = title.toString();
                    },
                  ),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Price'),
                    initialValue: editedProduct.price.toString(),
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
                    validator: (price) {
                      try {
                        double.parse(price!);
                        return null;
                      } catch (_) {
                        return 'Input a valid price';
                      }
                    },
                    onSaved: (price) {
                      price != null
                          ? editedProduct.price = double.parse(price)
                          : editedProduct.price = 0;
                    },
                  ),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Description'),
                    initialValue: editedProduct.description,
                    maxLines: 3,
                    keyboardType: TextInputType.multiline,
                    validator: (description) {
                      String? error = 'Please input a description';
                      if (description != null && description.isNotEmpty) {
                        error = null;
                      }
                      return error;
                    },
                    onSaved: (description) {
                      editedProduct.description = description.toString();
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
                          validator: (imageUrl) {
                            String? error =
                                'Please input a valid url (.jpg, .jpeg or .png)';
                            if (_isImageUrlValid()) {
                              error = null;
                            }
                            return error;
                          },
                          onSaved: (imageUrl) {
                            _isImageUrlValid()
                                ? editedProduct.imageUrl = imageUrl.toString()
                                : editedProduct.imageUrl = '';
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
    var url = _imageUrlController.text.toLowerCase();
    if (Uri.parse(url).isAbsolute) {
      if (!url.endsWith('.jpg') &&
          !url.endsWith('.jpeg') &&
          !url.endsWith('.png')) {
        return false;
      }
      return true;
    } else {
      _imageUrlController.clear();
      return false;
    }
  }

  void _saveForm() {
    bool? isValid = _formKey.currentState?.validate();

    if (isValid != null && isValid) {
      _formKey.currentState?.save();
      Provider.of<Products>(context, listen: false)
          .addOrUpdateProduct(editedProduct);
      Navigator.of(context).pop();
    }
  }
}
