import 'package:flutter/material.dart';
import 'package:shop_app/screens/products_overview_screen.dart';

class CustomRoute<T> extends MaterialPageRoute<T> {
  CustomRoute({required WidgetBuilder builder, RouteSettings? settings})
      : super(builder: builder, settings: settings);

  @override
  Widget buildTransitions(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    if (settings.name == ProductsOverviewScreen.routeName) {
      return child;
    }
    return FadeTransition(
      opacity: animation,
      child: child,
    );
  }
}
