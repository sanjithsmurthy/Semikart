import 'package:flutter/material.dart';
import '../cart/cart_page.dart'; // Import CartPage
import '../common/header.dart'; // Import Header for HomePage
import '../common/header_withback.dart'; // Import HeaderWithBack for other pages
import '../cart/cart_page.dart'; // Import cartItemCount for badge updates

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
      appBar: _selectedIndex == 0
          ? const Header() // Use Header for HomePage
          : CombinedAppBar(
              title: _getPageTitle(_selectedIndex), // Use CombinedAppBar for other pages
              onBackPressed: () {
                setState(() {
                  _selectedIndex = 0; // Navigate back to HomePage
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
          _buildCartNavItem(Icons.shopping_cart, "Cart", 2), // Cart with badge
          const BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }

  // Helper method to get the title for CombinedAppBar
  String _getPageTitle(int index) {
    switch (index) {
      case 1:
        return 'Products';
      case 2:
        return 'Your Cart';
      case 3:
        return 'Profile';
      default:
        return '';
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

class Header extends StatelessWidget implements PreferredSizeWidget {
  const Header({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity, // Ensure the header fills the entire screen width
      color: Colors.white,
      height: 66.0, // Increased height to accommodate additional padding
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 5.0), // Added vertical padding
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Menu Icon
          IconButton(
            icon: const Icon(Icons.menu, color: Colors.black),
            iconSize: 35.0,
            onPressed: () {},
          ),
          // Add spacing between the menu icon and the logo
          const SizedBox(width: 15.0),
          // Logo (Clickable)
          Flexible(
            child: Align(
              alignment: Alignment.centerLeft, // Align the logo closer to the menu icon
              child: GestureDetector(
                onTap: () {
                  // Navigate to the home tab of the bottom bar
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const BottomNavBar(), // Redirect to BottomNavBar
                    ),
                  );
                },
                child: Image.asset(
                  'public/assets/images/semikart_logo_medium.png',
                  height: 20.0, // Fixed height for the logo
                  fit: BoxFit.contain, // Ensure the logo scales properly
                ),
              ),
            ),
          ),
          // Right-side Icons
          Row(
            mainAxisSize: MainAxisSize.min, // Prevents the row from taking extra space
            children: [
              IconButton(
                icon: Image.asset('public/assets/images/whatsapp_icon.png'),
                iconSize: 20.0, // Reduced size for WhatsApp icon
                onPressed: () {},
              ),
              IconButton(
                icon: const Icon(Icons.phone, color: Colors.black),
                iconSize: 27.0, // Reduced size for phone icon
                onPressed: () {},
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(66.0); // Updated height to match the new padding
}