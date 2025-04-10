import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart'; // Import flutter_svg package
import 'bottom_bar.dart'; // Import the BottomNavBar for navigation

class Header extends StatelessWidget implements PreferredSizeWidget {
  const Header({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea( // Wrap the header in a SafeArea
      child: Container(
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
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(66.0); // Updated height to match the new padding
}

// CombinedAppBar Widget
class CombinedAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final VoidCallback onBackPressed;

  const CombinedAppBar({
    super.key,
    required this.title,
    required this.onBackPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        color: Colors.white,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Header Section
            Container(
              height: 66.0, // Fixed height for the header
              padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 5.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: const Icon(Icons.menu, color: Colors.black),
                    iconSize: 35.0,
                    onPressed: () {},
                  ),
                  const SizedBox(width: 15.0),
                  Flexible(
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const BottomNavBar(),
                            ),
                          );
                        },
                        child: Image.asset(
                          'public/assets/images/semikart_logo_medium.png',
                          height: 20.0,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Image.asset('public/assets/images/whatsapp_icon.png'),
                        iconSize: 20.0,
                        onPressed: () {},
                      ),
                      IconButton(
                        icon: const Icon(Icons.phone, color: Colors.black),
                        iconSize: 27.0,
                        onPressed: () {},
                      ),
                    ],
                  ),
                ],
              ),
            ),
            // AppBar Section
            Container(
              height: 56.0, // Fixed height for the AppBar
              child: Row(
                children: [
                  IconButton(
                    icon: SvgPicture.asset(
                      'public/assets/images/back.svg',
                      color: const Color(0xFFA51414),
                    ),
                    iconSize: 24.0,
                    onPressed: onBackPressed,
                  ),
                  Text(
                    title,
                    style: const TextStyle(color: Colors.black, fontSize: 18.0),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(122.0); // Combined height of Header and AppBar
}
