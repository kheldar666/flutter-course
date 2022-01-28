import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/products.dart';
import 'package:shop_app/widgets/shop_drawer.dart';
import 'package:shop_app/widgets/user_product_item.dart';

class UserProductsScreen extends StatelessWidget {
  static const routeName = '/admin/products';

  const UserProductsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var _products = Provider.of<Products>(context);
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            title: const Text('Manage Your Products'),
            actions: [
              IconButton(
                onPressed: () {},
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
                    UserProductItem(_products.products[index]),
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
