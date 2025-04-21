import 'package:flutter/material.dart';
import 'dart:async'; // Import for Future used in WillPopScope

import 'Components/search/product_search.dart';
import 'Components/profile/profile_screen.dart';
import 'Components/common/header.dart';
import 'Components/common/hamburger.dart';
import 'app_navigator.dart';

class BaseScaffold extends StatefulWidget {
  final int initialIndex;
  final ValueChanged<int>? onNavigationItemSelected;

  static final GlobalKey<_BaseScaffoldState> navigatorKey = GlobalKey<_BaseScaffoldState>();

  const BaseScaffold({
    super.key = const ValueKey('BaseScaffold'),
    this.initialIndex = 0,
    this.onNavigationItemSelected,
  });

  @override
  State<BaseScaffold> createState() => _BaseScaffoldState();
}

class _BaseScaffoldState extends State<BaseScaffold> {
  late int _selectedIndex;
  DateTime? _lastPressedAt;

  final List<Widget> _pages = [
    AppNavigator.homeNavigator(),
    AppNavigator.productsNavigator(),
    AppNavigator.searchNavigator(),
    AppNavigator.cartNavigator(),
    AppNavigator.profileNavigator(),
  ];

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.initialIndex;
  }

  void switchToTab(int index) {
    if (index >= 0 && index < _pages.length && _selectedIndex != index) {
      _popToFirstRouteInCurrentTab();
      setState(() {
        _selectedIndex = index;
      });
      widget.onNavigationItemSelected?.call(index);
    }
  }

  void _popToFirstRouteInCurrentTab() {
    final currentNavigatorKey = getNavigatorKeyForIndex(_selectedIndex);
    if (currentNavigatorKey?.currentState?.canPop() ?? false) {
      currentNavigatorKey!.currentState!.popUntil((route) => route.isFirst);
    }
  }

  GlobalKey<NavigatorState>? getNavigatorKeyForIndex(int index) {
    switch (index) {
      case 0:
        return AppNavigator.homeNavKey;
      case 1:
        return AppNavigator.productsNavKey;
      case 2:
        return AppNavigator.searchNavKey;
      case 3:
        return AppNavigator.cartNavKey;
      case 4:
        return AppNavigator.profileNavKey;
      default:
        return null;
    }
  }

  String? _getTitle(int index) {
    switch (index) {
      case 1:
        return 'Products';
      case 2:
        return 'Search';
      case 3:
        return 'Your Cart';
      case 4:
        return 'Profile';
      default:
        return null;
    }
  }

  Future<bool> _handleWillPop() async {
    final currentNavKey = getNavigatorKeyForIndex(_selectedIndex);
    final navState = currentNavKey?.currentState;

    if (navState != null && navState.canPop()) {
      navState.pop();
      setState(() {});
      return false;
    }

    if (_selectedIndex != 0) {
      switchToTab(0);
      return false;
    }

    final now = DateTime.now();
    if (_lastPressedAt == null || now.difference(_lastPressedAt!) > const Duration(seconds: 2)) {
      _lastPressedAt = now;
      _showExitPromptSnackbar();
      return false;
    } else {
      return true;
    }
  }

  void _showExitPromptSnackbar() {
    if (!mounted) return;
    ScaffoldMessenger.of(context).removeCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text(
          "Press back again to exit",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        duration: const Duration(seconds: 2),
        backgroundColor: Colors.white.withOpacity(0.85),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        margin: const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final bool canPopNested = getNavigatorKeyForIndex(_selectedIndex)?.currentState?.canPop() ?? false;
    final bool showHeaderBackButton = canPopNested || _selectedIndex != 0;

    return WillPopScope(
      onWillPop: _handleWillPop,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: Header(
          showBackButton: showHeaderBackButton,
          title: _getTitle(_selectedIndex),
          onBackPressed: () {
            final currentNavKey = getNavigatorKeyForIndex(_selectedIndex);
            final navState = currentNavKey?.currentState;

            if (navState != null && navState.canPop()) {
              navState.pop();
              setState(() {});
            } else if (_selectedIndex != 0) {
              switchToTab(0);
            }
          },
          onLogoTap: () {
            getNavigatorKeyForIndex(0)?.currentState?.popUntil((route) => route.isFirst);
            getNavigatorKeyForIndex(1)?.currentState?.popUntil((route) => route.isFirst);
            getNavigatorKeyForIndex(2)?.currentState?.popUntil((route) => route.isFirst);
            getNavigatorKeyForIndex(3)?.currentState?.popUntil((route) => route.isFirst);
            getNavigatorKeyForIndex(4)?.currentState?.popUntil((route) => route.isFirst);
            switchToTab(0);
          },
        ),
        drawer: const HamburgerMenu(),
        body: IndexedStack(
          index: _selectedIndex,
          children: _pages,
        ),
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          currentIndex: _selectedIndex,
          selectedItemColor: const Color(0xFFA51414),
          unselectedItemColor: Colors.grey,
          backgroundColor: Colors.white,
          onTap: switchToTab,
          items: [
            _buildNavItem(Icons.home, "Home", 0),
            _buildNavItem(Icons.inventory, "Products", 1),
            _buildNavItem(Icons.search, "Search", 2),
            _buildCartNavItem(Icons.shopping_cart, "Cart", 3),
            _buildNavItem(Icons.person, "Profile", 4),
          ],
        ),
      ),
    );
  }

  static BottomNavigationBarItem _buildNavItem(IconData icon, String label, int index) {
    return BottomNavigationBarItem(
      icon: Icon(icon),
      label: label,
    );
  }

  BottomNavigationBarItem _buildCartNavItem(IconData icon, String label, int index) {
    final cartItemCountProvider = ValueNotifier<int>(2);

    return BottomNavigationBarItem(
      icon: Stack(
        clipBehavior: Clip.none,
        children: [
          Icon(
            icon,
            size: 30,
          ),
          ValueListenableBuilder<int>(
            valueListenable: cartItemCountProvider,
            builder: (context, count, child) {
              if (count > 0) {
                return Positioned(
                  right: -4,
                  top: -4,
                  child: Container(
                    padding: const EdgeInsets.all(2),
                    decoration: const BoxDecoration(
                      color: Color(0xFFA51414),
                      shape: BoxShape.circle,
                    ),
                    constraints: const BoxConstraints(
                      minWidth: 18,
                      minHeight: 18,
                    ),
                    child: Text(
                      count.toString(),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                );
              }
              return const SizedBox.shrink();
            },
          ),
        ],
      ),
      label: label,
    );
  }
}
