import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/models/filter_option.dart';
import 'package:shop_app/providers/products.dart';
import 'package:shop_app/widgets/product_item.dart';

class ProductsGrid extends StatelessWidget {
  final FilterOptions filterOption;
  const ProductsGrid(this.filterOption, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _products = Provider.of<Products>(context);
    return GridView.builder(
      padding: const EdgeInsets.all(10),
      itemBuilder: (_, index) {
        return ChangeNotifierProvider.value(
          value: _products.getProducts(filterOption)[index],
          child: const ProductItem(),
        );
      },
      itemCount: _products.getProducts(filterOption).length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 3 / 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
    );
  }
}
