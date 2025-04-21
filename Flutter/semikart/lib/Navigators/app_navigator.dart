import 'package:flutter/material.dart';
import '../base_scaffold.dart';
import '../Components/products/products_l1.dart';

class AppNavigator {
  static void goTo({required int tabIndex, String? routeName}) {
    debugPrint("AppNavigator.goTo(tabIndex: $tabIndex, routeName: $routeName)");

    final state = BaseScaffold.navigatorKey.currentState;

    if (state == null) {
      debugPrint("BaseScaffold.navigatorKey.currentState is NULL");
      return;
    }

    state.switchToTab(tabIndex);

    if (routeName != null) {
      Future.delayed(const Duration(milliseconds: 100), () {
        final navKey = state.getNavigatorKeyForTab(tabIndex);
        if (navKey == null) {
          debugPrint("No navigator for tab $tabIndex");
        } else {
          debugPrint("Pushing route: $routeName");
          navKey.currentState?.pushNamed(routeName);
        }
      });
    }
  }
}
