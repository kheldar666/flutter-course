import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/screens/auth_screen.dart';

import '/providers/cart.dart';
import '/providers/orders.dart';
import '/providers/products.dart';
import '/screens/admin/edit_product_screen.dart';
import '/screens/admin/manage_products_screen.dart';
import '/screens/cart_screen.dart';
import '/screens/order_screen.dart';
import '/screens/product_detail_screen.dart';
import '/screens/products_overview_screen.dart';
import '/shop_theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (ctx) => Products()),
        ChangeNotifierProvider(create: (ctx) => Cart()),
        ChangeNotifierProvider(create: (ctx) => Orders()),
      ],
      child: MaterialApp(
        title: 'The Shop App',
        theme: ShopTheme.android(),
        initialRoute: AuthScreen.routeName,
        routes: {
          ProductsOverviewScreen.routeName: (ctx) =>
              const ProductsOverviewScreen(),
          ProductDetailScreen.routeName: (ctx) => const ProductDetailScreen(),
          CartScreen.routeName: (ctx) => const CartScreen(),
          OrdersScreen.routeName: (ctx) => const OrdersScreen(),
          ManageProductsScreen.routeName: (ctx) => const ManageProductsScreen(),
          EditProductScreen.routeName: (ctx) => const EditProductScreen(),
          AuthScreen.routeName: (ctx) => const AuthScreen(),
        },
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
