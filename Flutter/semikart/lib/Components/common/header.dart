import 'package:flutter/material.dart';
import 'bottom_bar.dart'; // Import the BottomNavBar for navigation

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