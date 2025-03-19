import 'package:flutter/material.dart';

class BottomNavBar extends StatefulWidget {
  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int _selectedIndex = 0;
  bool _isPressed = false; // Track press state

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
      selectedItemColor: Colors.blue, // Selected item color
      unselectedItemColor: Colors.grey, // Unselected item color
      onTap: _onItemTapped,
      items: [
        _buildNavItem(Icons.home, "Home", 0),
        _buildNavItem(Icons.inventory, "Products", 1),
        _buildNavItem(Icons.search, "Search", 2),
        _buildNavItem(Icons.shopping_cart, "Cart", 3),
        _buildNavItem(Icons.person, "Profile", 4),
      ],
    );
  }

  BottomNavigationBarItem _buildNavItem(IconData icon, String label, int index) {
    return BottomNavigationBarItem(
      icon: GestureDetector(
        onTapDown: (_) => setState(() => _isPressed = true),  // When pressed
        onTapUp: (_) => setState(() => _isPressed = false),   // When released
        onTapCancel: () => setState(() => _isPressed = false), // If tap is canceled
        child: AnimatedContainer(
          duration: Duration(milliseconds: 200),
          transform: Matrix4.identity()..scale(_isPressed && _selectedIndex == index ? 0.9 : 1.2), // Shrink on press
          child: Icon(
            icon,
            color: _selectedIndex == index ? Color(0xFFA51414) : Colors.grey, // Custom color change
          ),
        ),
      ),
      label: label,
    );
  }
}