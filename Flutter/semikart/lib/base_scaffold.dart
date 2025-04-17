import 'package:flutter/material.dart';
import 'Components/cart/cart_page.dart'; // Import CartPage to access cartItemCount
import 'Components/products/products_l1.dart'; // Import ProductsL1Page
import 'Components/common/header.dart'; // Import the unified Header
import 'Components/common/hamburger.dart'; // Import the HamburgerMenu
import 'Components/home/home_page.dart'; // Import the updated home_page.dart
import 'Components/profile/profile_screen.dart';
import 'Components/search/product_search.dart'; // Import ProductSearch for search functionality
// import 'Components/common/placeholder_page.dart'; // Assuming you have a placeholder page - Removed as file doesn't exist

class BaseScaffold extends StatefulWidget {
  final Widget? body; // Optional custom body
  final int initialIndex; // Optional initial index for bottom nav
  final ValueChanged<int>? onNavigationItemSelected; // Optional callback for nav item taps

  const BaseScaffold({
    super.key,
    this.body,
    this.initialIndex = 0, // Default to home page
    this.onNavigationItemSelected,
  });

  @override
  State<BaseScaffold> createState() => _BaseScaffoldState();
}

class _BaseScaffoldState extends State<BaseScaffold> {
  late int _selectedIndex; // Track the currently selected tab

  // List of pages for internal navigation (used if widget.body is null)
  final List<Widget> _pages = [
    const HomePageContent(), // Use the content widget from home_page.dart
    const ProductsL1Page(), // Products Page (Example)
    ProductSearch(), // Search Page (Using Flutter's Placeholder)
    CartPage(), // Cart Page
    const ProfileScreen(), // Profile Page
  ];

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.initialIndex; // Initialize with provided index
  }

  // Handles navigation bar taps
  void _onNavTap(int index) {
    setState(() {
      _selectedIndex = index;
    });
    widget.onNavigationItemSelected?.call(index); // Notify parent if callback is provided
  }

  // Determines the title for the Header based on the selected index
  String? _getTitle(int index) {
    // Only show titles for pages other than Home
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
        return null; // No title for Home (index 0)
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // This line is correctly set to prevent resizing,
      // which should keep the AppBar stationary.
      resizeToAvoidBottomInset: false,
      appBar: Header(
        showBackButton: _selectedIndex != 0,
        title: _getTitle(_selectedIndex),
        onBackPressed: () {
          // --- MODIFIED LOGIC ---
          if (_selectedIndex != 0) {
            // If not on the home page (index 0), navigate back to home
            _onNavTap(0);
          }
          // If already on the home page, the back button in the header does nothing.
          // The system back button (on Android) would handle exiting.
          // --- END MODIFICATION ---
        },
        onLogoTap: () {
          _onNavTap(0);
        },
      ),
      drawer: const HamburgerMenu(), // Add the hamburger menu drawer
      body: widget.body ?? IndexedStack( // Use provided body or internal IndexedStack
        index: _selectedIndex,
        children: _pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed, // Ensures all items are visible
        currentIndex: _selectedIndex,
        selectedItemColor: const Color(0xFFA51414), // Semikart red
        unselectedItemColor: Colors.grey,
        backgroundColor: Colors.white,
        onTap: _onNavTap, // Use the internal tap handler
        items: [
          _buildNavItem(Icons.home, "Home", 0),
          _buildNavItem(Icons.inventory, "Products", 1),
          _buildNavItem(Icons.search, "Search", 2),
          _buildCartNavItem(Icons.shopping_cart, "Cart", 3), // Cart with badge
          _buildNavItem(Icons.person, "Profile", 4),
        ],
      ),
    );
  }

  // Helper to build standard navigation items
  static BottomNavigationBarItem _buildNavItem(IconData icon, String label, int index) {
    // Note: Accessing _selectedIndex directly here isn't possible as it's static.
    // Color logic needs to be handled by the BottomNavigationBar itself based on currentIndex.
    return BottomNavigationBarItem(
      icon: Icon(icon),
      label: label,
    );
  }

  // Helper to build the Cart navigation item with a badge
  // Needs access to _selectedIndex, so it's not static
  BottomNavigationBarItem _buildCartNavItem(IconData icon, String label, int index) {
    return BottomNavigationBarItem(
      icon: Stack(
        clipBehavior: Clip.none,
        children: [
          Icon(
            icon,
            // Color is handled by selectedItemColor/unselectedItemColor
            size: 30,
          ),
          ValueListenableBuilder<int>(
            valueListenable: cartItemCount, // Listen to cartItemCount from CartPage
            builder: (context, count, child) {
              if (count > 0) {
                return Positioned(
                  right: -4,
                  top: -4,
                  child: Container(
                    padding: const EdgeInsets.all(2),
                    decoration: const BoxDecoration(
                      color: Color(0xFFA51414), // Badge color
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
              return const SizedBox.shrink(); // Hide badge if count is 0
            },
          ),
        ],
      ),
      label: label,
    );
  }
}