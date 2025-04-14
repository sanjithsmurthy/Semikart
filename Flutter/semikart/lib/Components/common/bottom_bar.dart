import 'package:flutter/material.dart';
import '../cart/cart_page.dart'; // Import CartPage
import '../common/header.dart'; // Import the unified Header

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int _selectedIndex = 0;

  // List of pages for navigation
  final List<Widget> _pages = [
    const PlaceholderPage(title: 'Home Page'), // Placeholder for HomePage
    const PlaceholderPage(title: 'Products Page'), // Placeholder for ProductsPage
    const PlaceholderPage(title: 'Search Page'), // Placeholder for SearchPage
    CartPage(), // CartPage
    const PlaceholderPage(title: 'Profile Page'), // Placeholder for ProfilePage
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index; // Update the selected index
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Header(
        showBackButton: _selectedIndex != 0, // Show back button for non-home pages
        title: _getPageTitle(_selectedIndex), // Set the title based on the selected page
        onBackPressed: () {
          setState(() {
            _selectedIndex = 0; // Navigate back to HomePage
          });
        },
        onLogoTap: () {
          setState(() {
            _selectedIndex = 0; // Navigate to HomePage when logo is tapped
          });
        },
      ),
      body: IndexedStack(
        index: _selectedIndex,
        children: _pages, // Render the selected page
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex,
        selectedItemColor: const Color(0xFFA51414), // Updated selected item color to #A51414
        unselectedItemColor: Colors.grey, // Unselected item color
        backgroundColor: Colors.white, // Set the background color to white
        onTap: _onItemTapped,
        items: [
          const BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.inventory),
            label: 'Products',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.search), // Search icon
            label: 'Search',
          ),
          _buildCartNavItem(Icons.shopping_cart, "Cart", 3), // Cart with badge
          const BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }

  // Helper method to get the title for Header
  String? _getPageTitle(int index) {
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
        return null; // No title for HomePage
    }
  }

  // Cart Item with Badge
  BottomNavigationBarItem _buildCartNavItem(IconData icon, String label, int index) {
    return BottomNavigationBarItem(
      icon: Stack(
        clipBehavior: Clip.none, // Ensures the badge is not clipped
        children: [
          Icon(
            icon,
            color: _selectedIndex == index ? const Color(0xFFA51414) : Colors.grey,
            size: 30,
          ),
          ValueListenableBuilder<int>(
            valueListenable: cartItemCount, // Listen to cartItemCount
            builder: (context, count, child) {
              if (count > 0) {
                return Positioned(
                  right: -2, // Adjusted to align the badge inside the cart icon
                  top: -2, // Adjusted to align the badge inside the cart icon
                  child: Container(
                    padding: const EdgeInsets.all(5),
                    decoration: const BoxDecoration(
                      color: Color(0xFFA51414), // Badge color
                      shape: BoxShape.circle,
                    ),
                    constraints: const BoxConstraints(
                      minWidth: 20,
                      minHeight: 20,
                    ),
                    child: Text(
                      count.toString(),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
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

// Placeholder widget for pages that are not ready yet
class PlaceholderPage extends StatelessWidget {
  final String title;

  const PlaceholderPage({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        title,
        style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
      ),
    );
  }
}