import 'package:flutter/material.dart';
import '../Components/cart/cart_page.dart';
import '../Components/cart/payment_page.dart'; 
// Dialogs like PaymentProgress and PaymentFailedDialog are typically shown 
// over existing pages using showDialog, not navigated to as separate routes.
// Therefore, they are not included in the navigator's routes.

class CartNavigator extends StatelessWidget {
  final GlobalKey<NavigatorState> navigatorKey;

  const CartNavigator({super.key, required this.navigatorKey});

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: navigatorKey,
      initialRoute: 'cart', // Default route is cart_page.dart
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case 'payment':
            // Navigates to the payment page (EditPage from payment_page.dart)
            return MaterialPageRoute(builder: (_) => const EditPage()); 
          case 'cart':
          default:
            // Default route is the main cart page
            return MaterialPageRoute(builder: (_) => CartPage()); 
        }
      },
    );
  }
}