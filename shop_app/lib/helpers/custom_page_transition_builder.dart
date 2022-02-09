import 'package:flutter/material.dart';
import 'package:shop_app/screens/products_overview_screen.dart';

class CustomPageTransitionBuilder extends PageTransitionsBuilder {
  @override
  Widget buildTransitions<T>(
    PageRoute<T> route,
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    if (route.settings.name == ProductsOverviewScreen.routeName) {
      return child;
    }
    return FadeTransition(
      opacity: animation,
      child: child,
    );
  }
}
