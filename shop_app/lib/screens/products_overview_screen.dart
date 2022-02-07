import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/products.dart';

import '/models/filter_option.dart';
import '/providers/cart.dart';
import '/screens/cart_screen.dart';
import '/widgets/badge.dart';
import '/widgets/products_grid.dart';
import '/widgets/shop_drawer.dart';

class ProductsOverviewScreen extends StatefulWidget {
  static const String routeName = '/products-overview';

  const ProductsOverviewScreen({Key? key}) : super(key: key);

  @override
  State<ProductsOverviewScreen> createState() => _ProductsOverviewScreenState();
}

class _ProductsOverviewScreenState extends State<ProductsOverviewScreen> {
  var _filterOptions = FilterOptions.all;
  var _isLoading = false;
  @override
  void initState() {
    super.initState();
    _isLoading = true;
    Provider.of<Products>(context, listen: false)
        .fetchAndSetProducts()
        .then((_) {
      setState(() {
        _isLoading = false;
      });
    });
  }

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
                value: cart.countQuantity.toString(),
              ),
              child: IconButton(
                onPressed: () =>
                    Navigator.of(context).pushNamed(CartScreen.routeName),
                icon: const Icon(Icons.shopping_cart),
              ),
            ),
          ],
        ),
        drawer: const ShopDrawer(),
        body: _isLoading
            ? const Center(child: CircularProgressIndicator())
            : RefreshIndicator(
                child: ProductsGrid(_filterOptions),
                onRefresh: _refreshProducts,
              ),
      ),
    );
  }

  void _filterProducts(FilterOptions option) {
    setState(() {
      _filterOptions = option;
    });
  }

  Future<void> _refreshProducts() async {
    await Provider.of<Products>(context, listen: false).fetchAndSetProducts();
  }
}
