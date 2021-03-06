import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/screens/order_screen.dart';

import '/providers/auth.dart';
import '/screens/admin/manage_products_screen.dart';
import '/screens/products_overview_screen.dart';

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
            leading: const Icon(Icons.payment),
            title: const Text('Your Orders'),
            onTap: () => Navigator.of(context)
                .pushReplacementNamed(OrdersScreen.routeName),
            // onTap: () => Navigator.of(context).pushReplacement(
            //     CustomRoute(builder: (ctx) => const OrdersScreen())),
          ),
          ListTile(
            leading: const Icon(Icons.edit),
            title: const Text('Manage Your Products'),
            onTap: () => Navigator.of(context)
                .pushReplacementNamed(ManageProductsScreen.routeName),
          ),
          ListTile(
            leading: const Icon(Icons.exit_to_app),
            title: const Text('Logout'),
            onTap: () {
              Provider.of<Auth>(context, listen: false).logout();
            },
          )
        ],
      ),
    );
  }
}
