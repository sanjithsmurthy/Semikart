import 'dart:developer';
import 'package:flutter/material.dart';
import 'Components/rfq_bom/rfq_full.dart'; // Import RFQFullPage

import 'Components/common/header.dart';
import 'Components/common/hamburger.dart';
import 'app_navigator.dart'; // Import the central navigator setup

final cartItemCountProvider = ValueNotifier<int>(0); // Temporary placeholder - Replace with Riverpod

class BaseScaffold extends StatefulWidget {
  final int initialIndex;
  final ValueChanged<int>? onNavigationItemSelected;

  // Restore the static key
  static final GlobalKey<_BaseScaffoldState> navigatorKey = GlobalKey<_BaseScaffoldState>();

  const BaseScaffold({
    // Use the static key as the default key for the instance
    super.key /*= navigatorKey*/, // Keep super.key, don't assign static key here by default
    this.initialIndex = 0,
    this.onNavigationItemSelected,
  });

  @override
  State<BaseScaffold> createState() => _BaseScaffoldState();
}

class _BaseScaffoldState extends State<BaseScaffold> {
  late int _selectedIndex;
  bool _showRFQOverlay = false;
  DateTime? _lastPressedAt;
  late final List<Widget> _pages;

  @override
  void initState() {
    // log("🔔 Initializing BaseScaffold State..."); // Remove log
    super.initState();
    _selectedIndex = widget.initialIndex;
    cartItemCountProvider.addListener(_updateCartBadge);
    _pages = [
      AppNavigator.homeNavigator(),
      AppNavigator.productsNavigator(),
      AppNavigator.searchNavigator(),
      AppNavigator.cartNavigator(),
      AppNavigator.profileNavigator(),
    ];
    // log("🔔 BaseScaffold State: _pages initialized."); // Remove log
  }

  @override
  void dispose() {
    cartItemCountProvider.removeListener(_updateCartBadge);
    super.dispose();
  }

  void _updateCartBadge() {}

  void _toggleRFQOverlay() {
    setState(() {
      _showRFQOverlay = !_showRFQOverlay;
    });
  }

  void switchToTab(int index) {
    if (index >= 0 && index < _pages.length && _selectedIndex != index) {
      _popToFirstRouteInCurrentTab();
      setState(() {
        _selectedIndex = index;
      });
      widget.onNavigationItemSelected?.call(index);
    } else if (_selectedIndex == index) {
      _popToFirstRouteInCurrentTab();
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
    if (_showRFQOverlay) {
      setState(() {
        _showRFQOverlay = false;
      });
      return false;
    }

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
          textAlign: TextAlign.center,
        ),
        duration: const Duration(seconds: 2),
        backgroundColor: Colors.white.withOpacity(0.9),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        margin: const EdgeInsets.only(bottom: 80, left: 60, right: 60),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // log("🏗️ Building BaseScaffold..."); // Remove log

    // --- Restore Original Build Method --- 
    final bool canPopNested = getNavigatorKeyForIndex(_selectedIndex)?.currentState?.canPop() ?? false;
    final bool showHeaderBackButton = canPopNested || _selectedIndex != 0;

    return WillPopScope(
      onWillPop: _handleWillPop,
      child: Stack(
        children: [
          Scaffold(
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
                for (var key in [
                  AppNavigator.homeNavKey,
                  AppNavigator.productsNavKey,
                  AppNavigator.searchNavKey,
                  AppNavigator.cartNavKey,
                  AppNavigator.profileNavKey,
                ]) {
                  key.currentState?.popUntil((route) => route.isFirst);
                }
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
              unselectedItemColor: Colors.grey.shade600,
              backgroundColor: Colors.white,
              selectedFontSize: 12,
              unselectedFontSize: 12,
              onTap: switchToTab,
              items: [
                _buildNavItem(Icons.home_outlined, Icons.home, "Home", 0),
                _buildNavItem(Icons.inventory_2_outlined, Icons.inventory_2, "Products", 1),
                _buildNavItem(Icons.search_outlined, Icons.search, "Search", 2),
                _buildCartNavItem(Icons.shopping_cart_outlined, Icons.shopping_cart, "Cart", 3),
                _buildNavItem(Icons.person_outline, Icons.person, "Profile", 4),
              ],
            ),
            floatingActionButton: !_showRFQOverlay
                ? FloatingActionButton(
                    onPressed: _toggleRFQOverlay,
                    backgroundColor: const Color(0xFFA51414), // Red background
                    child: const Text(
                      "RFQ", // Display "RFQ" instead of an icon
                      style: TextStyle(
                        color: Colors.white, // White text for visibility
                        fontWeight: FontWeight.bold, // Bold text for emphasis
                        fontSize: 16, // Font size for better readability
                      ),
                    ),
                  )
                : null,
          ),
          if (_showRFQOverlay)
            Positioned.fill(
              child: Material(
                color: Colors.black.withOpacity(0.5), // Semi-transparent black overlay
                child: Stack(
                  children: [
                    // Close Icon Positioned Slightly Down
                    Align(
                      alignment: Alignment.topRight,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 50, right: 16), // Adjusted top padding to bring the icon down
                        child: IconButton(
                          icon: const Icon(
                            Icons.close,
                            color: Colors.white, // Set the color to white for visibility
                            size: 32, // Slightly larger size for better visibility
                          ),
                          onPressed: _toggleRFQOverlay, // Close overlay on press
                        ),
                      ),
                    ),
                    // RFQ Content with Reduced Height, Width, and Adjusted Position
                    Center(
                      child: Container(
                        constraints: BoxConstraints(
                          maxHeight: MediaQuery.of(context).size.height * 0.7, // Reduce height to 70% of the screen height
                          maxWidth: MediaQuery.of(context).size.width * 0.9, // Reduce width to 90% of the screen width
                        ),
                        padding: const EdgeInsets.all(16), // Add padding for content
                        decoration: BoxDecoration(
                          color: Colors.white, // White background for the overlay content
                          borderRadius: BorderRadius.circular(12), // Rounded corners
                        ),
                        child: Column(
                          children: [
                            Expanded(
                              child: RFQFullPage(),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
        ],
      ),
    );
    // --- END Restore --- 
  }

  BottomNavigationBarItem _buildNavItem(IconData outlinedIcon, IconData filledIcon, String label, int index) {
    return BottomNavigationBarItem(
      icon: Icon(_selectedIndex == index ? filledIcon : outlinedIcon),
      label: label,
    );
  }

  BottomNavigationBarItem _buildCartNavItem(IconData outlinedIcon, IconData filledIcon, String label, int index) {
    return BottomNavigationBarItem(
      icon: Stack(
        clipBehavior: Clip.none,
        children: [
          Icon(
            _selectedIndex == index ? filledIcon : outlinedIcon,
            size: 28,
          ),
          ValueListenableBuilder<int>(
            valueListenable: cartItemCountProvider,
            builder: (context, count, child) {
              if (count > 0) {
                return Positioned(
                  right: -6,
                  top: -4,
                  child: Container(
                    padding: const EdgeInsets.all(2),
                    decoration: const BoxDecoration(
                      color: Color(0xFFA51414),
                      shape: BoxShape.circle,
                    ),
                    constraints: const BoxConstraints(
                      minWidth: 16,
                      minHeight: 16,
                    ),
                    child: Text(
                      count > 9 ? '9+' : count.toString(),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 10,
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

  void openOrderHistory() {
    switchToTab(4); // Switch to the Profile tab (index 4)
    AppNavigator.pushOrderHistory(); // Push the OrderHistory page within the Profile tab
  }
}