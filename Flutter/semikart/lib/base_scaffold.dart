import 'package:flutter/material.dart';
// Removed direct import of CartPage as it's now handled by CartNavigator
// import 'Components/cart/cart_page.dart'; 
import 'Components/search/product_search.dart';
import 'Components/profile/profile_screen.dart';
import 'Components/common/header.dart';
import 'Components/common/hamburger.dart';
import 'Components/Navigators/products_navigator.dart';
import 'Components/navigators/home_navigator.dart';
import 'Components/navigators/cart_navigator.dart';
import 'Components/cart/cart_page.dart'; // Keep this for cartItemCount

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
  final GlobalKey<NavigatorState> _cartNavKey = GlobalKey<NavigatorState>(); // Add key for CartNavigator

  late List<Widget> _pages;

  DateTime? _lastPressedAt;

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.initialIndex;

    _pages = [
      HomeNavigator(navigatorKey: _homeNavKey),
      ProductsNavigator(navigatorKey: _productsNavKey),
      ProductSearch(),
      CartNavigator(navigatorKey: _cartNavKey), // Use CartNavigator here
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
      // Clear current tab stack before switching
      final currentNavKey = _getNavigatorKeyForIndex(_selectedIndex);
      if (currentNavKey?.currentState?.canPop() ?? false) {
        currentNavKey?.currentState?.popUntil((route) => route.isFirst);
      }

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

    // Pop inside current tab if possible
    if (currentNavKey?.currentState?.canPop() ?? false) {
      currentNavKey?.currentState?.pop();
      return false;
    }

    // If on Products, Search, Cart, or Profile, go to Home tab
    if (_selectedIndex != 0) {
      setState(() {
        _selectedIndex = 0;
      });
      return false;
    }

    // If on Home tab, handle back press with timer functionality
    if (_lastPressedAt == null ||
        DateTime.now().difference(_lastPressedAt!) > Duration(seconds: 2)) {
      // Show custom styled snackbar and reset timer
      _lastPressedAt = DateTime.now();
      _showExitPromptSnackbar();
      return false; // Prevent app from closing
    } else {
      // If within 2 seconds, exit the app
      return true; // Allow exit
    }
  }

  void _showExitPromptSnackbar() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          "Press back again to exit",
          style: TextStyle(
            color: Colors.black, // Set text color to black
            fontWeight: FontWeight.bold,
          ),
        ),
        duration: Duration(seconds: 2),
        backgroundColor: Colors.white.withOpacity(0.7), // Transparent white background
        behavior: SnackBarBehavior.floating, // Floating style for modern look
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10), // Rounded corners
        ),
        margin: EdgeInsets.symmetric(horizontal: 50, vertical: 10), // Centered and more spaced
        padding: EdgeInsets.all(16), // Custom padding inside snackbar
      ),
    );
  }

  GlobalKey<NavigatorState>? _getNavigatorKeyForIndex(int index) {
    switch (index) {
      case 0:
        return _homeNavKey;
      case 1:
        return _productsNavKey;
      case 3: // Add case for CartNavigator
        return _cartNavKey;
      default:
        return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _handleWillPop,
      child: Scaffold(
        key: BaseScaffold.navigatorKey,
        resizeToAvoidBottomInset: false,
        appBar: Header(
          // Show back button if not on the root of the current navigator OR if not on the home tab (index 0)
          showBackButton: (_getNavigatorKeyForIndex(_selectedIndex)?.currentState?.canPop() ?? false) || _selectedIndex != 0,
          title: _getTitle(_selectedIndex),
          onBackPressed: () {
            final currentNavKey = _getNavigatorKeyForIndex(_selectedIndex);

            if (currentNavKey?.currentState?.canPop() ?? false) {
              currentNavKey?.currentState?.pop();
            } else if (_selectedIndex != 0) {
              // If cannot pop within the navigator, go back to the home tab
              _onNavTap(0);
            }
          },
          onLogoTap: () {
             // Reset all navigators and go to home tab
            _homeNavKey.currentState?.popUntil((route) => route.isFirst);
            _productsNavKey.currentState?.popUntil((route) => route.isFirst);
            _cartNavKey.currentState?.popUntil((route) => route.isFirst);
            _onNavTap(0);
          },
        ),
        drawer: const HamburgerMenu(),
        body: widget.body ?? IndexedStack(
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
