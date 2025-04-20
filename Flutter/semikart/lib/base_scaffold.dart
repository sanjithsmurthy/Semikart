import 'package:flutter/material.dart';
import 'Components/cart/cart_page.dart';
import 'Components/search/product_search.dart';
import 'Components/profile/profile_screen.dart';
import 'Components/common/header.dart';
import 'Components/common/hamburger.dart';
import 'Components/navigators/products_navigator.dart';
import 'Components/navigators/home_navigator.dart';

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
  final GlobalKey<NavigatorState> _homeNavKey = GlobalKey<NavigatorState>();
  final GlobalKey<NavigatorState> _productsNavKey = GlobalKey<NavigatorState>();

  late List<Widget> _pages;

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.initialIndex;

    _pages = [
      HomeNavigator(navigatorKey: _homeNavKey),
      ProductsNavigator(navigatorKey: _productsNavKey),
      ProductSearch(),
      CartPage(),
      const ProfileScreen(),
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

  Future<bool> _handleWillPop() async {
    final currentNavKey = _getNavigatorKeyForIndex(_selectedIndex);

    if (currentNavKey != null &&
        currentNavKey.currentState != null &&
        currentNavKey.currentState!.canPop()) {
      currentNavKey.currentState!.pop();
      return false;
    }

    return true;
  }

  GlobalKey<NavigatorState>? _getNavigatorKeyForIndex(int index) {
    switch (index) {
      case 0:
        return _homeNavKey;
      case 1:
        return _productsNavKey;
      default:
        return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _handleWillPop,
      child: Scaffold(
        key: BaseScaffold.navigatorKey, // <-- This connects the global key
        resizeToAvoidBottomInset: false,
        appBar: Header(
          showBackButton: _selectedIndex != 0,
          title: _getTitle(_selectedIndex),
          onBackPressed: () {
            final currentNavKey = _getNavigatorKeyForIndex(_selectedIndex);

            if (currentNavKey != null &&
                currentNavKey.currentState != null &&
                currentNavKey.currentState!.canPop()) {
              currentNavKey.currentState!.pop();
            } else if (_selectedIndex != 0) {
              _onNavTap(0);
            }
          },
          onLogoTap: () {
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
