import 'package:flutter/material.dart';
import 'package:shop_app/screens/admin/manage_products_screen.dart';
import 'package:shop_app/screens/order_screen.dart';
import 'package:shop_app/screens/products_overview_screen.dart';

class ShopDrawer extends StatelessWidget {
  const ShopDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          AppBar(
            title: const Text('Hello Friend'),
            automaticallyImplyLeading: false,
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.shop),
            title: const Text('Shop'),
            onTap: () => Navigator.of(context)
                .pushReplacementNamed(ProductsOverviewScreen.routeName),
          ),
          ListTile(
            leading: const Icon(Icons.shopping_cart),
            title: const Text('Your Orders'),
            onTap: () => Navigator.of(context)
                .pushReplacementNamed(OrdersScreen.routeName),
          ),
          ListTile(
            leading: const Icon(Icons.edit),
            title: const Text('Manage Your Products'),
            onTap: () => Navigator.of(context)
                .pushReplacementNamed(ManageProductsScreen.routeName),
          )
        ],
      ),
    );
  }
}
