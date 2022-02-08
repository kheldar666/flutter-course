import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';

import '/providers/auth.dart';
import '/providers/cart.dart';
import '/providers/orders.dart';
import '/providers/products.dart';
import '/screens/admin/edit_product_screen.dart';
import '/screens/admin/manage_products_screen.dart';
import '/screens/auth_screen.dart';
import '/screens/cart_screen.dart';
import '/screens/order_screen.dart';
import '/screens/product_detail_screen.dart';
import '/screens/products_overview_screen.dart';
import '/screens/splash_screen.dart';
import '/shop_theme.dart';

Future main() async {
  await dotenv.load(fileName: ".env");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (ctx) => Auth()),
        ChangeNotifierProxyProvider<Auth, Products>(
            create: (ctx) => Products(null, '', []),
            update: (ctx, auth, previousProducts) => Products(
                  auth.token,
                  auth.userId,
                  previousProducts != null ? previousProducts.products : [],
                )),
        ChangeNotifierProvider(create: (ctx) => Cart()),
        ChangeNotifierProxyProvider<Auth, Orders>(
          create: (ctx) => Orders(null, '', []),
          update: (ctx, auth, previousOrders) => Orders(
            auth.token,
            auth.userId,
            previousOrders != null ? previousOrders.orders : [],
          ),
        ),
      ],
      child: Consumer<Auth>(
        builder: (ctx, authData, _) {
          return MaterialApp(
            title: 'The Shop App',
            theme: ShopTheme.android(),
            home: authData.isAuth
                ? const ProductsOverviewScreen()
                : FutureBuilder(
                    future: authData.tryAutoLogin(),
                    builder: (ctx, authResultSnapshot) {
                      if (authResultSnapshot.connectionState ==
                          ConnectionState.waiting) {
                        return const SplashScreen();
                      } else {
                        return const AuthScreen();
                      }
                    }),
            routes: {
              ProductsOverviewScreen.routeName: (ctx) =>
                  const ProductsOverviewScreen(),
              ProductDetailScreen.routeName: (ctx) =>
                  const ProductDetailScreen(),
              CartScreen.routeName: (ctx) => const CartScreen(),
              OrdersScreen.routeName: (ctx) => const OrdersScreen(),
              ManageProductsScreen.routeName: (ctx) =>
                  const ManageProductsScreen(),
              EditProductScreen.routeName: (ctx) => const EditProductScreen(),
              AuthScreen.routeName: (ctx) => const AuthScreen(),
            },
            debugShowCheckedModeBanner: false,
          );
        },
      ),
    );
  }
}
