import 'package:flutter/material.dart';

// Home & RFQ
import 'Components/home/home_page.dart';
import 'Components/rfq_bom/rfq_full.dart';

// Products
import 'Components/products/products_l1.dart';
import 'Components/products/products_l2.dart';
import 'Components/products/products_l3.dart';

// Cart
import 'Components/cart/cart_page.dart';
import 'Components/cart/payment_page.dart';

// Search
import 'Components/search/product_search.dart'; // Add more pages if needed

// Profile
import 'Components/profile/profile_screen.dart';


import 'base_scaffold.dart';

class AppNavigator {
  // Navigator keys for each bottom nav tab
  static final homeNavKey     = GlobalKey<NavigatorState>();
  static final productsNavKey = GlobalKey<NavigatorState>();
  static final searchNavKey   = GlobalKey<NavigatorState>();
  static final cartNavKey     = GlobalKey<NavigatorState>();
  static final profileNavKey  = GlobalKey<NavigatorState>();

  // Switch bottom tab
  static void switchToTab(int index) {
    BaseScaffold.navigatorKey.currentState?.switchToTab(index);
  }

  static void toHome()     => switchToTab(0);
  static void toProducts() => switchToTab(1);
  static void toSearch()   => switchToTab(2);
  static void toCart()     => switchToTab(3);
  static void toProfile()  => switchToTab(4);

  // Navigation functions for subroutes
  static void pushHomeRFQ() {
    homeNavKey.currentState?.pushNamed('rfq');
  }

  static void pushProductsL2() {
    productsNavKey.currentState?.pushNamed('l2');
  }

  static void pushProductsL3() {
    productsNavKey.currentState?.pushNamed('l3');
  }

  static void pushCartPayment() {
    cartNavKey.currentState?.pushNamed('payment');
  }

  static void pushSearchExample(String query) {
    searchNavKey.currentState?.pushNamed('results', arguments: query);
  }

  static void pushProfileEdit() {
    profileNavKey.currentState?.pushNamed('edit');
  }

  // Each navigator widget — used in BaseScaffold
  static Widget homeNavigator() => Navigator(
        key: homeNavKey,
        initialRoute: 'home',
        onGenerateRoute: (settings) {
          switch (settings.name) {
            case 'rfq':
              return MaterialPageRoute(builder: (_) => const RFQFullPage());
            case 'home':
            default:
              return MaterialPageRoute(builder: (_) => const HomePageContent());
          }
        },
      );

  static Widget productsNavigator() => Navigator(
        key: productsNavKey,
        initialRoute: 'l1',
        onGenerateRoute: (settings) {
          switch (settings.name) {
            case 'l2':
              return MaterialPageRoute(builder: (_) => const ProductsL2Page());
            case 'l3':
              return MaterialPageRoute(builder: (_) => const ProductsL3Page());
            case 'l1':
            default:
              return MaterialPageRoute(builder: (_) => const ProductsL1Page());
          }
        },
      );

  static Widget searchNavigator() => Navigator(
        key: searchNavKey,
        initialRoute: 'search',
        onGenerateRoute: (settings) {
          switch (settings.name) {
            // case 'results':
            //   final query = settings.arguments as String;
            //   return MaterialPageRoute(
            //       builder: (_) => ProductSearch(initialQuery: query));
            case 'search':
            default:
              return MaterialPageRoute(builder: (_) => const ProductSearch());
          }
        },
      );

  static Widget cartNavigator() => Navigator(
        key: cartNavKey,
        initialRoute: 'cart',
        onGenerateRoute: (settings) {
          switch (settings.name) {
            case 'payment':
              return MaterialPageRoute(builder: (_) => const EditPage());
            case 'cart':
            default:
              return MaterialPageRoute(builder: (_) => CartPage());
          }
        },
      );

  static Widget profileNavigator() => Navigator(
        key: profileNavKey,
        initialRoute: 'profile',
        onGenerateRoute: (settings) {
          switch (settings.name) {
            
            case 'profile':
            default:
              return MaterialPageRoute(builder: (_) => const ProfileScreen());
          }
        },
      );

      static void openProductsL1FromAnywhere() {
  // Step 1: Switch to Products Tab
  BaseScaffold.navigatorKey.currentState?.switchToTab(1);

  // Step 2: Wait till the Products tab's widget tree is built
  Future.delayed(Duration.zero, () {
    // Safety check: has navigator mounted
    final productsNavigator = productsNavKey.currentState;
    if (productsNavigator != null) {
      productsNavigator.popUntil((route) => route.isFirst);
    } else {
      debugPrint('productsNavKey not ready yet');
    }
  });
}


}
