import 'package:flutter/material.dart';
import 'Components/search/product_search.dart';
import 'Components/profile/profile_screen.dart';
import 'Components/common/header.dart';
import 'Components/common/hamburger.dart';
import 'Navigators/products_navigator.dart';
import 'navigators/home_navigator.dart';
import 'navigators/cart_navigator.dart';
import 'Components/cart/cart_page.dart'; // For cartItemCount
import 'components/products/products_l1.dart'; // For ProductsL1Page
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


// Public method to allow tab + page navigation from anywhere
static void openProductsL1FromAnywhere() {
  final state = navigatorKey.currentState;
  if (state is _BaseScaffoldState) {
    state.switchToTab(1);

    Future.delayed(const Duration(milliseconds: 100), () {
      final navKey = state.productsNavKey;
      if (navKey.currentState != null) {
        navKey.currentState!.push(
          MaterialPageRoute(builder: (_) => const ProductsL1Page()),
        );
      }
    });
  }
}

static void navigateToProductsL1Tab() {
    final state = navigatorKey.currentState;
    if (state is _BaseScaffoldState) {
      state.switchToTab(1); // Products tab

      Future.delayed(const Duration(milliseconds: 100), () {
        final navKey = state.productsNavKey;
        navKey.currentState?.pushNamed('products_l1');
      });
    }
  }

}

class _BaseScaffoldState extends State<BaseScaffold> {
  late int _selectedIndex;

  final GlobalKey<NavigatorState> _homeNavKey = GlobalKey<NavigatorState>();
  final GlobalKey<NavigatorState> productsNavKey = GlobalKey<NavigatorState>(); // ✅ Made public
  final GlobalKey<NavigatorState> _cartNavKey = GlobalKey<NavigatorState>();

  late List<Widget> _pages;
  DateTime? _lastPressedAt;

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.initialIndex;

    _pages = [
      HomeNavigator(navigatorKey: _homeNavKey),
      ProductsNavigator(navigatorKey: productsNavKey),
      ProductSearch(),
      CartNavigator(navigatorKey: _cartNavKey),
      const ProfileScreen(),
    ];
  }

  GlobalKey<NavigatorState>? getNavigatorKeyForTab(int index) {
  switch (index) {
    case 0:
      return _homeNavKey;
    case 1:
      return productsNavKey;
    case 2:
      return null; // Search has no nested navigator
    case 3:
      return _cartNavKey;
    case 4:
      return null; // Profile has no nested navigator
    default:
      return null;
  }
}


  void _onNavTap(int index) {
    setState(() {
      _selectedIndex = index;
    });
    widget.onNavigationItemSelected?.call(index);
  }

  void switchToTab(int index) {
  debugPrint("Switching to tab: $index");

  if (index >= 0 && index < _pages.length) {
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

    if (currentNavKey?.currentState?.canPop() ?? false) {
      currentNavKey?.currentState?.pop();
      return false;
    }

    if (_selectedIndex != 0) {
      setState(() {
        _selectedIndex = 0;
      });
      return false;
    }

    if (_lastPressedAt == null ||
        DateTime.now().difference(_lastPressedAt!) > const Duration(seconds: 2)) {
      _lastPressedAt = DateTime.now();
      _showExitPromptSnackbar();
      return false;
    } else {
      return true;
    }
  }

  void _showExitPromptSnackbar() {
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
        backgroundColor: Colors.white.withOpacity(0.7),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        margin: const EdgeInsets.symmetric(horizontal: 50, vertical: 10),
        padding: const EdgeInsets.all(16),
      ),
    );
  }

  GlobalKey<NavigatorState>? _getNavigatorKeyForIndex(int index) {
    switch (index) {
    case 0:
      return _homeNavKey;
    case 1:
      return productsNavKey;
    case 2:
      return null; // Search doesn't have a nested navigator
    case 3:
      return _cartNavKey;
    case 4:
      return null; // Profile doesn't have a nested navigator
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
          showBackButton: (_getNavigatorKeyForIndex(_selectedIndex)?.currentState?.canPop() ?? false) || _selectedIndex != 0,
          title: _getTitle(_selectedIndex),
          onBackPressed: () {
            final currentNavKey = _getNavigatorKeyForIndex(_selectedIndex);
            if (currentNavKey?.currentState?.canPop() ?? false) {
              currentNavKey?.currentState?.pop();
            } else if (_selectedIndex != 0) {
              _onNavTap(0);
            }
          },
          onLogoTap: () {
            _homeNavKey.currentState?.popUntil((route) => route.isFirst);
            productsNavKey.currentState?.popUntil((route) => route.isFirst);
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

  static BottomNavigationBarItem _buildNavItem(IconData icon, String label, int index) {
    return BottomNavigationBarItem(
      icon: Icon(icon),
      label: label,
    );
  }

  BottomNavigationBarItem _buildCartNavItem(IconData icon, String label, int index) {
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
