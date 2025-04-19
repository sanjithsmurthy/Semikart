import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // For status bar customization
import 'red_button.dart'; // Import your custom RedButton
import 'popup.dart'; // Import your CustomPopup widget
import '../login_signup/login_password.dart';
import '../profile/profile_screen.dart';
import '../../base_scaffold.dart'; // Import BaseScaffold
import '../home/order_history.dart';

// Helper function for creating a Fade Transition Page Route
Route _createFadeRoute(Widget page, {int? initialIndex}) {
  final Widget targetPage = (page is BaseScaffold && initialIndex != null)
      ? BaseScaffold(key: ValueKey('BaseScaffold_$initialIndex'), initialIndex: initialIndex)
      : page;

  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => targetPage,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      // Use FadeTransition for a smooth fade effect
      return FadeTransition(
        opacity: animation,
        child: child,
      );
    },
    // Faster transition duration
    transitionDuration: const Duration(milliseconds: 200), // Reduced from 300ms
  );
}

class HamburgerMenu extends StatelessWidget {
  const HamburgerMenu({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Drawer(
      width: screenWidth * 0.75, // Occupy 75% of the screen width
      child: Container(
        color: Colors.white, // Set the background color to white
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Section with Back Icon and Logo
            Padding(
              padding: EdgeInsets.only(
                left: screenWidth * 0.05 + (screenWidth * 0.01), // Move 10 pixels right dynamically
                top: screenHeight * 0.043, // Keep the top padding as is
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Back Icon
                  Transform.translate(
                    offset: Offset(screenWidth * 0.01, 0), // Move 10 pixels right dynamically
                    child: IconButton(
                      icon: const Icon(
                        Icons.arrow_back_ios_new,
                        color: Color(0xFFA51414), // Red color for the back icon
                      ),
                      iconSize: screenWidth * 0.06, // Dynamically scale the icon size
                      onPressed: () {
                        Navigator.pop(context); // Close the drawer
                      },
                    ),
                  ),
                  SizedBox(width: screenWidth * 0.02), // Add spacing between the icon and the logo

                  // Semikart Logo
                  Transform.translate(
                    offset: Offset(screenWidth * 0.01, 0), // Move 10 pixels right dynamically
                    child: Image.asset(
                      'public/assets/images/semikart_logo_medium.png', // Path to the Semikart logo
                      height: screenHeight * 0.025, // Dynamically scale height
                      fit: BoxFit.contain,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: screenHeight * 0.04),

            // Profile Section
            Center(
              child: Column(
                children: [
                  // Profile Picture
                  CircleAvatar(
                    radius: screenWidth * 0.12, // Dynamically scale the profile picture size
                    backgroundImage: const AssetImage('public/assets/images/profile_picture.png'), // Replace with actual profile picture path
                  ),
                  const SizedBox(height: 8),

                  // Username and Email
                  const Text(
                    'Username',
                    style: TextStyle(
                      fontSize: 16, // Set font size to 16
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    'username@gmail.com',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Edit Profile and Logout Buttons
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Edit Profile Button
                      RedButton(
                        label: 'Edit Profile',
                        onPressed: () {
                          Navigator.pop(context); // Close drawer first
                          // Navigate using the faster Fade Transition
                          Navigator.pushReplacement(
                            context,
                            _createFadeRoute(const BaseScaffold(), initialIndex: 4), // Index 4 for Profile
                          );
                        },
                        width: screenWidth * 0.3,
                        height: 40,
                        isWhiteButton: true,
                      ),
                      const SizedBox(width: 16),

                      // Logout Button - Keep using pushAndRemoveUntil
                      RedButton(
                        label: 'Logout',
                        onPressed: () {
                          CustomPopup.show(
                            context: context,
                            title: 'Logout',
                            message: 'Are you sure you want to logout?',
                            buttonText: 'Confirm',
                            imagePath: 'public/assets/images/Alert.png',
                          ).then((_) {
                            Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(builder: (context) => const LoginPasswordNewScreen()),
                              (Route<dynamic> route) => false,
                            );
                          });
                        },
                        width: screenWidth * 0.3,
                        height: 40,
                        isWhiteButton: true,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: screenHeight * 0.04),

            // Menu Items
            Expanded(
              child: ListView(
                padding: EdgeInsets.zero, // Remove default ListView padding
                children: [
                  _buildMenuItem(
                    context,
                    icon: Icons.shopping_bag,
                    text: 'Products',
                    onTap: () {
                      Navigator.pop(context); // Close drawer first
                      // Navigate using the faster Fade Transition
                      Navigator.pushReplacement(
                        context,
                        _createFadeRoute(const BaseScaffold(), initialIndex: 1), // Index 1 for Products
                      );
                    },
                  ),
                  const SizedBox(height: 16), // Add spacing between menu items
                  _buildMenuItem(
                    context,
                    icon: Icons.history,
                    text: 'Order History',
                    onTap: () {
                      Navigator.pop(context); // Close drawer first
                      // Navigate to Order History page using MaterialPageRoute to fix date picker issue
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => OrderHistory()),
                      );
                    },
                  ),
                  const SizedBox(height: 16), // Add spacing between menu items
                  _buildMenuItem(
                    context,
                    icon: Icons.contact_support,
                    text: 'Contact Us',
                    onTap: () {
                      Navigator.pop(context); // Close drawer first
                      // TODO: Replace with actual navigation using _createFadeRoute if needed
                      // Example: Navigator.push(context, _createFadeRoute(const ContactUsPage()));
                       print("Navigate to Contact Us"); // Placeholder
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Helper method to build menu items
  Widget _buildMenuItem(BuildContext context, {required IconData icon, required String text, required VoidCallback onTap}) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05), // Align icons with buttons
      child: ListTile(
        leading: Icon(
          icon,
          color: const Color(0xFFA51414), // Red icon
          size: 24, // Increased icon size
        ),
        title: Text(
          text,
          style: const TextStyle(
            fontSize: 14, // Set font size to 14
            fontWeight: FontWeight.normal, // Remove bold styling
            color: Colors.black,
          ),
        ),
        trailing: const Icon( // Added const
          Icons.arrow_forward_ios,
          color: Color(0xFFA51414), // Red right arrow icon
          size: 24, // Match size with left icon
        ),
        onTap: onTap, // Use the provided onTap callback
        // Add visual feedback
        hoverColor: Colors.grey.shade100,
        splashColor: Colors.red.shade100,
      ),
    );
  }
}