import 'package:flutter/material.dart';
import '../Commons/bottom_bar.dart'; // Import the BottomNavBar for navigation

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int _selectedIndex = 0;
  final int _cartItemCount = 3; // Example cart count (Update dynamically based on cart items)

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      currentIndex: _selectedIndex,
      selectedItemColor: Color(0xFFA51414), // Updated selected item color to #A51414
      unselectedItemColor: Colors.grey, // Unselected item color
      onTap: _onItemTapped,
      selectedLabelStyle: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w500,
        height: 1.5, // Adjusts spacing between icon and text
      ),
      unselectedLabelStyle: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        height: 1.5, // Adjusts spacing between icon and text
      ),
      items: [
        _buildNavItem(Icons.home, "Home", 0),
        _buildNavItem(Icons.inventory,   "Products", 1),
        _buildNavItem(Icons.search, "Search", 2),
        _buildCartNavItem(Icons.shopping_cart, "Cart", 3, _cartItemCount), // Cart with badge
        _buildNavItem(Icons.person, "Profile", 4),
      ],
    );
  }

  // General Navigation Items
  BottomNavigationBarItem _buildNavItem(IconData icon, String label, int index) {
    return BottomNavigationBarItem(
      icon: Icon(
        icon,
        color: _selectedIndex == index ? Color(0xFFA51414) : Colors.grey, // Updated color to #A51414
      ),
      label: label,
    );
  }

  // Cart Item with Badge
  BottomNavigationBarItem _buildCartNavItem(IconData icon, String label, int index, int itemCount) {
    return BottomNavigationBarItem(
      icon: Stack(
        clipBehavior: Clip.none, // Ensures the badge is not clipped
        children: [
          Icon(
            icon,
            color: _selectedIndex == index ? Color(0xFFA51414) : Colors.grey, // Updated color to #A51414
            size: 30,
          ),
          if (itemCount > 0) // Show badge only if itemCount > 0
            Positioned(
              right: -2, // Adjusted to align the badge inside the cart icon
              top: -2, // Adjusted to align the badge inside the cart icon
              child: Container(
                padding: EdgeInsets.all(5),
                decoration: BoxDecoration(
                  color: Color(0xFFA51414), // Badge color
                  shape: BoxShape.circle,
                ),
                constraints: BoxConstraints(
                  minWidth: 20,
                  minHeight: 20,
                ),
                child: Text(
                  itemCount.toString(),
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
        ],
      ),
      label: label,
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