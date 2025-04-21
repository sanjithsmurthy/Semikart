import 'package:flutter/material.dart';
import 'Components/cart/cart_page.dart';
import 'Components/search/product_search.dart';
import 'Components/profile/profile_screen.dart';
import 'Components/common/header.dart';
import 'Components/common/hamburger.dart';
import 'app_navigator.dart'; // <--- central navigation

class BaseScaffold extends StatefulWidget {
  final Widget? body;
  final int initialIndex;
  final ValueChanged<int>? onNavigationItemSelected;

  static final GlobalKey<_BaseScaffoldState> navigatorKey =
      GlobalKey<_BaseScaffoldState>();

  const BaseScaffold({
    super.key,
    this.body,
    this.initialIndex = 0,
    this.onNavigationItemSelected,
  });

  @override
  State<BaseScaffold> createState() => _BaseScaffoldState();
}

class _BaseScaffoldState extends State<BaseScaffold> {
  late int _selectedIndex;
  DateTime? _lastBackPressed;

  late List<Widget> _pages;

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.initialIndex;

    _pages = [
      AppNavigator.homeNavigator(),
      AppNavigator.productsNavigator(),
      AppNavigator.searchNavigator(),
      AppNavigator.cartNavigator(),
      AppNavigator.profileNavigator(),
    ];
  }

  void _onNavTap(int index) {
    setState(() {
      _selectedIndex = index;
    });
    widget.onNavigationItemSelected?.call(index);
  }

  void switchToTab(int index) {
    if (index >= 0 && index < _pages.length) {
      setState(() {
        _selectedIndex = index;
      });
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

  GlobalKey<NavigatorState>? _getNavigatorKeyForIndex(int index) {
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

  Future<bool> _handleWillPop() async {
    final currentNavKey = _getNavigatorKeyForIndex(_selectedIndex);

    if (currentNavKey?.currentState?.canPop() ?? false) {
      currentNavKey?.currentState?.pop();
      return false;
    }

    if (_selectedIndex != 0) {
      _onNavTap(0);
      return false;
    }

    final now = DateTime.now();
    if (_lastBackPressed == null ||
        now.difference(_lastBackPressed!) > const Duration(seconds: 2)) {
      _lastBackPressed = now;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Press back again to exit"),
          duration: Duration(seconds: 2),
          backgroundColor: Color(0xFFA51414),
        ),
      );
      return false;
    }

    return true;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _handleWillPop,
      child: Scaffold(
        key: BaseScaffold.navigatorKey,
        resizeToAvoidBottomInset: false,
        appBar: Header(
          showBackButton:
              (_getNavigatorKeyForIndex(_selectedIndex)?.currentState?.canPop() ?? false) ||
              _selectedIndex != 0,
          title: _getTitle(_selectedIndex),
          onBackPressed: () async {
            final currentNavKey = _getNavigatorKeyForIndex(_selectedIndex);

            if (currentNavKey?.currentState?.canPop() ?? false) {
              currentNavKey?.currentState?.pop();
              return;
            }

            if (_selectedIndex != 0) {
              _onNavTap(0);
              return;
            }

            final now = DateTime.now();
            if (_lastBackPressed == null ||
                now.difference(_lastBackPressed!) > const Duration(seconds: 2)) {
              _lastBackPressed = now;
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text("Press back again to exit"),
                  duration: Duration(seconds: 2),
                  backgroundColor: Color(0xFFA51414),
                ),
              );
              return;
            }

            Navigator.of(context).maybePop();
          },
          onLogoTap: () {
            AppNavigator.homeNavKey.currentState?.popUntil((route) => route.isFirst);
            AppNavigator.productsNavKey.currentState?.popUntil((route) => route.isFirst);
            AppNavigator.cartNavKey.currentState?.popUntil((route) => route.isFirst);
            AppNavigator.searchNavKey.currentState?.popUntil((route) => route.isFirst);
            AppNavigator.profileNavKey.currentState?.popUntil((route) => route.isFirst);
            _onNavTap(0);
          },
        ),
        drawer: const HamburgerMenu(),
        body: widget.body ??
            IndexedStack(
              index: _selectedIndex,
              children: _pages,
            ),
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          currentIndex: _selectedIndex,
          selectedItemColor: const Color(0xFFA51414),
          unselectedItemColor: Colors.grey,
          backgroundColor: Colors.white,
          onTap: _onNavTap,
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

  static BottomNavigationBarItem _buildNavItem(
      IconData icon, String label, int index) {
    return BottomNavigationBarItem(
      icon: Icon(icon),
      label: label,
    );
  }

  BottomNavigationBarItem _buildCartNavItem(
      IconData icon, String label, int index) {
    return BottomNavigationBarItem(
      icon: Stack(
        clipBehavior: Clip.none,
        children: [
          Icon(icon, size: 30),
          ValueListenableBuilder<int>(
            valueListenable: cartItemCount,
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
