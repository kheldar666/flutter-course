import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/cart.dart';
import 'package:shop_app/providers/products.dart';
import 'package:shop_app/screens/product_detail_screen.dart';
import 'package:shop_app/screens/products_overview_screen.dart';
import 'package:shop_app/shop_theme.dart';

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
      ],
      child: MaterialApp(
        title: 'The Shop App',
        theme: ShopTheme.android(),
        initialRoute: ProductsOverviewScreen.routeName,
        routes: {
          ProductsOverviewScreen.routeName: (ctx) =>
              const ProductsOverviewScreen(),
          ProductDetailScreen.routeName: (ctx) => const ProductDetailScreen(),
        },
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
