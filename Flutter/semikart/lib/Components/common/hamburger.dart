import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // For status bar customization
import 'red_button.dart'; // Import your custom RedButton
import 'popup.dart'; // Import your CustomPopup widget
import '../login_signup/login_password_new.dart';
import '../profile/profile_screen.dart';

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
                        Navigator.pop(context); // Navigate back to the previous page
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
                          // Navigate to Edit Profile Screen
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (context) => ProfileScreen()), // Navigate to HomePage
                          );
                        },
                        width: screenWidth * 0.3,
                        height: 40,
                        isWhiteButton: true,
                      ),
                      const SizedBox(width: 16),

                      // Logout Button
                      RedButton(
                        label: 'Logout',
                        onPressed: () {
                          // Show Logout Confirmation Popup
                          CustomPopup.show(
                            context: context,
                            title: 'Logout',
                            message: 'Are you sure you want to logout?',
                            buttonText: 'Confirm',
                            imagePath: 'public/assets/images/Alert.png', // Replace with your logout icon path
                          ).then((_) {
                            // Navigate to LoginPasswordScreen when popup button is clicked
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(builder: (context) => LoginPasswordNewScreen()),
                            );
                          });
                        },
                        width: screenWidth * 0.3,
                        height: 40,
                        isWhiteButton: true, // Make the button outlined
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
                children: [
                  _buildMenuItem(
                    context,
                    icon: Icons.shopping_bag,
                    text: 'Products',
                    onTap: () {
                      // Navigate to Products Screen
                      Navigator.pushNamed(context, '/products');
                    },
                  ),
                  SizedBox(height: 16), // Add spacing between menu items
                  _buildMenuItem(
                    context,
                    icon: Icons.history,
                    text: 'Order History',
                    onTap: () {
                      // Navigate to Order History Screen
                      Navigator.pushNamed(context, '/orderHistory');
                    },
                  ),
                  SizedBox(height: 16), // Add spacing between menu items
                  _buildMenuItem(
                    context,
                    icon: Icons.list_alt,
                    text: 'BOM History',
                    onTap: () {
                      // Navigate to BOM History Screen
                      Navigator.pushNamed(context, '/bomHistory');
                    },
                  ),
                  SizedBox(height: 16), // Add spacing between menu items
                  _buildMenuItem(
                    context,
                    icon: Icons.contact_support,
                    text: 'Contact Us',
                    onTap: () {
                      // Navigate to Contact Us Screen
                      Navigator.pushNamed(context, '/contactUs');
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
        trailing: Icon(
          Icons.arrow_forward_ios,
          color: const Color(0xFFA51414), // Red right arrow icon
          size: 24, // Match size with left icon
        ),
        onTap: onTap,
      ),
    );
  }
}