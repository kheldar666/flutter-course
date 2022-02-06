import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '/providers/products.dart';
import '/screens/admin/edit_product_screen.dart';
import '/widgets/admin/manage_product_item.dart';
import '/widgets/shop_drawer.dart';

class ManageProductsScreen extends StatelessWidget {
  static const routeName = '/admin/products';

  const ManageProductsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var _products = Provider.of<Products>(context);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Manage Your Products'),
          actions: [
            IconButton(
              onPressed: () =>
                  Navigator.of(context).pushNamed(EditProductScreen.routeName),
              icon: const Icon(Icons.add),
            )
          ],
        ),
        drawer: const ShopDrawer(),
        body: RefreshIndicator(
          onRefresh: () => _refreshProducts(context),
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: ListView.builder(
              itemBuilder: (ctx, index) {
                return Column(
                  children: [
                    ManageProductItem(_products.products[index]),
                    const Divider(),
                  ],
                );
              },
              itemCount: _products.products.length,
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _refreshProducts(BuildContext context) async {
    await Provider.of<Products>(context, listen: false).fetchAndSetProducts();
  }
}
