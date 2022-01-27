import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/products.dart';
import 'package:shop_app/widgets/product_item.dart';

class ProductsGrid extends StatelessWidget {
  const ProductsGrid({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _products = Provider.of<Products>(context);
    return GridView.builder(
      padding: const EdgeInsets.all(10),
      itemBuilder: (ctx, index) {
        return ChangeNotifierProvider(
          create: (c){return _products.products[index];},
          child: const ProductItem(),
        );
      },
      itemCount: _products.products.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 3 / 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
    );
  }
}
