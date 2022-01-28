import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/products.dart';
import 'package:shop_app/screens/admin/edit_product_screen.dart';
import 'package:shop_app/widgets/admin/manage_product_item.dart';
import 'package:shop_app/widgets/shop_drawer.dart';

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
                onPressed: () => Navigator.of(context)
                    .pushNamed(EditProductScreen.routeName),
                icon: const Icon(Icons.add),
              )
            ],
          ),
          drawer: const ShopDrawer(),
          body: Padding(
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
          )),
    );
  }
}
