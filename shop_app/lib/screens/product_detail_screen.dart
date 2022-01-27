import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/products_provider.dart';

class ProductDetailScreen extends StatelessWidget {
  static const String routeName = '/product-detail';

  const ProductDetailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var _productId = ModalRoute.of(context)?.settings.arguments as String;

    //Listen set to false will avoid to trigger the build method if the product changes
    var _product = Provider.of<ProductsProvider>(context, listen: false).findById(_productId);

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(_product.title),
        ),
      ),
    );
  }
}
