import 'package:flutter/material.dart';
import 'package:shop_app/data/dummy_data.dart';
import 'package:shop_app/models/product.dart';
import 'package:shop_app/widgets/product_item.dart';

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
        body: GridView.builder(
          padding: const EdgeInsets.all(10),
          itemBuilder: (ctx, index) => ProductItem(_loadedProducts[index]),
          itemCount: _loadedProducts.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 3 / 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
          ),
        ),
      ),
    );
  }
}
