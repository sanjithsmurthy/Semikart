import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BottomNavBar extends StatefulWidget {
  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int _selectedIndex = 0;
  bool _isPressed = false; // Track press state
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
      selectedItemColor: Colors.blue, // Selected item color
      unselectedItemColor: Colors.grey, // Unselected item color
      onTap: _onItemTapped,
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
      icon: GestureDetector(
        onTapDown: (_) => setState(() => _isPressed = true),
        onTapUp: (_) => setState(() => _isPressed = false),
        onTapCancel: () => setState(() => _isPressed = false),
        child: AnimatedContainer(
          duration: Duration(milliseconds: 200),
          transform: Matrix4.identity()..scale(_isPressed && _selectedIndex == index ? 0.9 : 1.2),
          child: Icon(
            icon,
            color: _selectedIndex == index ? Color(0xFFA51414) : Colors.grey,
          ),
        ),
      ),
      label: label,
    );
  }

  // Cart Item with Badge
  BottomNavigationBarItem _buildCartNavItem(IconData icon, String label, int index, int itemCount) {
    return BottomNavigationBarItem(
      icon: GestureDetector(
        onTapDown: (_) => setState(() => _isPressed = true),
        onTapUp: (_) => setState(() => _isPressed = false),
        onTapCancel: () => setState(() => _isPressed = false),
        child: AnimatedContainer(
          duration: Duration(milliseconds: 200),
          transform: Matrix4.identity()..scale(_isPressed && _selectedIndex == index ? 0.9 : 1.2),
          child: Stack(
            children: [
              Icon(
                icon,
                color: _selectedIndex == index ? Color(0xFFA51414) : Colors.grey,
                size: 30,
              ),
              if (itemCount > 0) // Show badge only if itemCount > 0
                Positioned(
                  right: 0,
                  top: 0,
                  child: Container(
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      color: Color(0xFFA51414),
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
        ),
      ),
      label: label,
    );
  }
}