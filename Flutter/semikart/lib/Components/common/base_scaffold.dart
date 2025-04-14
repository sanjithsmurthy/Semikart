import 'package:flutter/material.dart';
import 'header.dart'; // Import the unified Header
import 'hamburger.dart'; // Import the HamburgerMenu

final ValueNotifier<int> cartItemCount = ValueNotifier<int>(0); // Define cartItemCount

class BaseScaffold extends StatelessWidget {
  final Widget body;
  final int selectedIndex;
  final Function(int) onNavTap;

  const BaseScaffold({
    super.key,
    required this.body,
    required this.selectedIndex,
    required this.onNavTap,
  });

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
        showBackButton: selectedIndex != 0,
        title: _getTitle(selectedIndex),
        onBackPressed: () => onNavTap(0),
        onLogoTap: () => onNavTap(0),
      ),
      drawer: const HamburgerMenu(),
      body: body,
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: selectedIndex,
        selectedItemColor: const Color(0xFFA51414),
        unselectedItemColor: Colors.grey,
        backgroundColor: Colors.white, // Set bottom bar color to white
        onTap: onNavTap,
        items: [
          _buildNavItem(context, Icons.home, "Home", 0, selectedIndex),
          _buildNavItem(context, Icons.inventory, "Products", 1, selectedIndex),
          _buildNavItem(context, Icons.search, "Search", 2, selectedIndex),
          _buildCartNavItem(context, Icons.shopping_cart, "Cart", 3, selectedIndex),
          _buildNavItem(context, Icons.person, "Profile", 4, selectedIndex),
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