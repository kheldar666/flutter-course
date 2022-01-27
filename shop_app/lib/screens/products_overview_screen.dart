import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/models/filter_option.dart';
import 'package:shop_app/providers/cart.dart';
import 'package:shop_app/screens/cart_screen.dart';
import 'package:shop_app/widgets/badge.dart';
import 'package:shop_app/widgets/products_grid.dart';

class ProductsOverviewScreen extends StatefulWidget {
  static const String routeName = '/products-overview';

  const ProductsOverviewScreen({Key? key}) : super(key: key);

  @override
  State<ProductsOverviewScreen> createState() => _ProductsOverviewScreenState();
}

class _ProductsOverviewScreenState extends State<ProductsOverviewScreen> {
  var _filterOptions = FilterOptions.all;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('The Shop App'),
          actions: [
            PopupMenuButton(
              icon: const Icon(Icons.more_vert),
              onSelected: (FilterOptions option) => _filterProducts(option),
              itemBuilder: (_) => [
                const PopupMenuItem(
                  child: Text('Only Favorites'),
                  value: FilterOptions.favorites,
                ),
                const PopupMenuItem(
                  child: Text('Show All'),
                  value: FilterOptions.all,
                )
              ],
            ),
            Consumer<Cart>(
              builder: (ctx, cart, childButton) => Badge(
                child: childButton ?? Container(),
                value: cart.count.toString(),
              ),
              child: IconButton(
                onPressed: () =>
                    Navigator.of(context).pushNamed(CartScreen.routeName),
                icon: const Icon(Icons.shopping_cart),
              ),
            ),
          ],
        ),
        body: ProductsGrid(_filterOptions),
      ),
    );
  }

  void _filterProducts(FilterOptions option) {
    setState(() {
      _filterOptions = option;
    });
  }
}
