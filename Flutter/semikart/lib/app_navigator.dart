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
import 'Components/search/product_search.dart';

// Profile
import 'Components/profile/profile_screen.dart';

import 'base_scaffold.dart';

class AppNavigator {
  static final homeNavKey = GlobalKey<NavigatorState>();
  static final productsNavKey = GlobalKey<NavigatorState>();
  static final searchNavKey = GlobalKey<NavigatorState>();
  static final cartNavKey = GlobalKey<NavigatorState>();
  static final profileNavKey = GlobalKey<NavigatorState>();

  // Convenience methods to switch tabs using the BaseScaffold state
  static void toHome() => BaseScaffold.navigatorKey.currentState?.switchToTab(0);
  static void toProducts() => BaseScaffold.navigatorKey.currentState?.switchToTab(1);
  static void toSearch() => BaseScaffold.navigatorKey.currentState?.switchToTab(2);
  static void toCart() => BaseScaffold.navigatorKey.currentState?.switchToTab(3);
  static void toProfile() => BaseScaffold.navigatorKey.currentState?.switchToTab(4);

  // --- Methods to push routes within specific navigators ---
  static void pushHomeRFQ() {
    // Use null-aware access ?.
    homeNavKey.currentState?.pushNamed('rfq');
  }

  static void pushProductsL2({Object? arguments}) {
    // Use null-aware access ?.
    productsNavKey.currentState?.pushNamed('l2', arguments: arguments);
  }

  static void pushProductsL3({Object? arguments}) {
    // Use null-aware access ?.
    productsNavKey.currentState?.pushNamed('l3', arguments: arguments);
  }

  static void pushProductsL4({Object? arguments}) {
    // Use null-aware access ?.
    productsNavKey.currentState?.pushNamed('l4', arguments: arguments);
  }

  static void pushCartPayment({Object? arguments}) {
    // Use null-aware access ?.
    cartNavKey.currentState?.pushNamed('payment', arguments: arguments);
  }

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

  /// Navigates to a specific tab and optionally pushes a route within that tab's navigator.
  static void goTo(int tabIndex, {String? routeName, Object? arguments}) {
    // Try accessing state slightly delayed to ensure BaseScaffold might have built
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final state = BaseScaffold.navigatorKey.currentState;

      if (state == null) {
        return;
      }

      // 1. Switch to the target tab
      state.switchToTab(tabIndex);

      // 2. If a routeName is provided, push it onto the tab's navigator stack
      if (routeName != null) {
        final navigatorKey = state.getNavigatorKeyForIndex(tabIndex);
        final navState = navigatorKey?.currentState;

        if (navState != null) {
          // Clear the current stack and push the desired route
          navState.pushNamedAndRemoveUntil(
            routeName,
            (route) => false, // Remove all previous routes
            arguments: arguments,
          );
        }
      }
    });
  }

  /// Switches to the Products tab (index 1) and pops its navigator to the first route ('l1').
  static void openProductsRootPage() {

    goTo(1);
  }

  /// Switches to the Home tab (index 0) and navigates to the RFQ page.
  static void openHomeRFQPage() {
    goTo(0, routeName: 'rfq'); // Switch to Home tab and push 'rfq' route
  }

  /// Switches to the Products tab (index 1) and navigates to the Request for Quote section.
  static void openProductsRFQPage() {
    goTo(1, routeName: 'rfq_products'); // Switch to Products tab and push 'rfq_products' route
  }
}