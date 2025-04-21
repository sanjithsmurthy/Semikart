import 'package:flutter/material.dart';
import '../Components/products/products_l1.dart';
import '../Components/products/products_l2.dart';
import '../Components/products/products_l3.dart';

class ProductsNavigator extends StatelessWidget {
  final GlobalKey<NavigatorState> navigatorKey;

  const ProductsNavigator({super.key, required this.navigatorKey});

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: navigatorKey,
      initialRoute: 'l1',
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case 'l1':
            return MaterialPageRoute(builder: (_) => const ProductsL1Page());
          case 'l2':
            return MaterialPageRoute(builder: (_) => const ProductsL2Page());
          case 'l3':
            return MaterialPageRoute(builder: (_) => const ProductsL3Page());
          default:
            return MaterialPageRoute(builder: (_) => const ProductsL1Page());
        }
      },
    );
  }
}
