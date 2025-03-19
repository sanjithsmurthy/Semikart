import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BottomNavBar extends StatefulWidget {
  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int _selectedIndex = 0;
  int _cartItemCount = 3; // Example cart count (Update dynamically based on cart items)

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
        _buildNavItem(Icons.inventory, "Products", 1),
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