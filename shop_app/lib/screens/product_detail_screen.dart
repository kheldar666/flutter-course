import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/models/product.dart';
import 'package:shop_app/providers/products_provider.dart';

class ProductDetailScreen extends StatelessWidget {
  static const String routeName = '/product-detail';

  const ProductDetailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var _productId = ModalRoute.of(context)?.settings.arguments as String;
    var _product = Provider.of<ProductsProvider>(context).findById(_productId);
    
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(_product.title),
        ),
      ),
    );
  }
}
