import 'package:flutter/material.dart';
import 'package:shop_app/data/dummy_data.dart';
import 'package:shop_app/models/product.dart';
import 'package:shop_app/widgets/products_grid.dart';

class ProductsOverviewScreen extends StatelessWidget {
  static const String routeName = '/products-overview';

  ProductsOverviewScreen({Key? key}) : super(key: key);

  final List<Product> _loadedProducts = kDummyProducts;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('The Shop App'),
        ),
        body: const ProductsGrid(),
      ),
    );
  }
}
