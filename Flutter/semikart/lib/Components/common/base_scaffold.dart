import 'package:flutter/material.dart';
import 'package:semikart/Components/home/home_screen.dart';
import '../cart/cart_page.dart'; // Import CartPage
import '../products/products_l1.dart'; // Import ProductsL1Page
import 'header.dart'; // Import the unified Header
import 'hamburger.dart'; // Import the HamburgerMenu
import '../home/home_page.dart' as home_page; // Import HomePage with alias

final ValueNotifier<int> cartItemCount = ValueNotifier<int>(0); // Define cartItemCount

class BaseScaffold extends StatefulWidget {
  const BaseScaffold({super.key});

  @override
  State<BaseScaffold> createState() => _BaseScaffoldState();
}

class _BaseScaffoldState extends State<BaseScaffold> {
  int _selectedIndex = 0; // Track the currently selected tab

  // List of pages for navigation
  final List<Widget> _pages = [
    home_page.HomePage(), // Use the aliased HomePage widget
    const ProductsL1Page(), // Use ProductsL1Page from products_l1.dart
    const Center(child: Text('Search Page')), // Replace with your SearchPage widget
     CartPage(), // Use CartPage from cart.dart
    const Center(child: Text('Profile Page')), // Replace with your ProfilePage widget
  ];

  void _onNavTap(int index) {
    setState(() {
      _selectedIndex = index; // Update the selected index
    });
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
        return null; // Home = no title, just logo
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Header(
        showBackButton: _selectedIndex != 0,
        title: _getTitle(_selectedIndex),
        onBackPressed: () => _onNavTap(0), // Navigate back to Home
        onLogoTap: () => _onNavTap(0), // Navigate to Home when logo is tapped
      ),
      drawer: const HamburgerMenu(), // Attach the HamburgerMenu widget
      body: _pages[_selectedIndex], // Display the selected page
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex, // Highlight the active tab
        selectedItemColor: const Color(0xFFA51414), // Red for selected items
        unselectedItemColor: Colors.grey, // Grey for unselected items
        backgroundColor: Colors.white, // Set bottom bar color to white
        onTap: _onNavTap, // Handle tab switching
        items: [
          _buildNavItem(context, Icons.home, "Home", 0, _selectedIndex),
          _buildNavItem(context, Icons.inventory, "Products", 1, _selectedIndex),
          _buildNavItem(context, Icons.search, "Search", 2, _selectedIndex),
          _buildCartNavItem(context, Icons.shopping_cart, "Cart", 3, _selectedIndex),
          _buildNavItem(context, Icons.person, "Profile", 4, _selectedIndex),
        ],
      ),
    );
  }

  static BottomNavigationBarItem _buildNavItem(
      BuildContext context, IconData icon, String label, int index, int selectedIndex) {
    return BottomNavigationBarItem(
      icon: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (selectedIndex == index)
            Container(
              height: 3, // Height of the red line
              width: MediaQuery.of(context).size.width / 5, // Divide into 5 equal parts
              color: const Color(0xFFA51414), // Red color
            )
          else
            const SizedBox(height: 3), // Placeholder for unselected items
          Icon(
            icon,
            color: selectedIndex == index ? const Color(0xFFA51414) : Colors.grey,
          ),
        ],
      ),
      label: label,
    );
  }

  static BottomNavigationBarItem _buildCartNavItem(
      BuildContext context, IconData icon, String label, int index, int selectedIndex) {
    return BottomNavigationBarItem(
      icon: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (selectedIndex == index)
            Container(
              height: 3, // Height of the red line
              width: MediaQuery.of(context).size.width / 5, // Divide into 5 equal parts
              color: const Color(0xFFA51414), // Red color
            )
          else
            const SizedBox(height: 3), // Placeholder for unselected items
          Stack(
            clipBehavior: Clip.none,
            children: [
              Icon(
                icon,
                color: selectedIndex == index ? const Color(0xFFA51414) : Colors.grey,
              ),
              ValueListenableBuilder<int>(
                valueListenable: cartItemCount, // Listen to cartItemCount
                builder: (_, count, __) {
                  if (count > 0) {
                    return Positioned(
                      right: -2,
                      top: -2,
                      child: Container(
                        padding: const EdgeInsets.all(5),
                        decoration: const BoxDecoration(
                          color: Color(0xFFA51414),
                          shape: BoxShape.circle,
                        ),
                        child: Text(
                          '$count',
                          style: const TextStyle(color: Colors.white, fontSize: 12),
                        ),
                      ),
                    );
                  }
                  return const SizedBox.shrink(); // Hide badge if count is 0
                },
              ),
            ],
          ),
        ],
      ),
      label: label,
    );
  }
}