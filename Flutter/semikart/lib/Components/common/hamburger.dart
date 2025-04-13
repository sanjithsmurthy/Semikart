import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // For status bar customization

class HamburgerMenu extends StatelessWidget {
  const HamburgerMenu({super.key});

  @override
  Widget build(BuildContext context) {
    // Set the status bar to match the screen color and ensure contrast
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.white, // Match the screen background color
      statusBarIconBrightness: Brightness.dark, // Ensure content is visible (black icons)
    ));

    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white, // Set the top bar background to white
        iconTheme: IconThemeData(color: Colors.black), // Set the icon color to black
        title: Text(
          'Hamburger Menu Test',
          style: TextStyle(
            color: Colors.black, // Set the title color to black
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        elevation: 0, // Remove shadow
      ),
      drawer: Drawer(
        width: screenWidth * 0.75, // Occupy 75% of the screen width
        child: Container(
          color: Colors.white, // Set the background color to white
          child: Stack(
            children: [
              // Row for Back Icon and Semikart Logo
              Positioned(
                left: screenWidth * 0.05, // Dynamically scale the left position
                top: screenHeight * 0.06, // Dynamically scale the top position
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Back Icon
                    IconButton(
                      icon: Icon(
                        Icons.arrow_back_ios_new,
                        color: Color(0xFFA51414), // Red color for the back icon
                      ),
                      iconSize: screenWidth * 0.06, // Dynamically scale the icon size
                      onPressed: () {
                        Navigator.pop(context); // Navigate back to the previous page
                      },
                    ),
                    SizedBox(width: 14), // Add 14 units of spacing between the icon and the logo

                    // Semikart Logo
                    Image.asset(
                      'public/assets/images/semikart_logo_medium.png', // Path to the Semikart logo
                      width: screenWidth * 0.4, // Dynamically scale width
                      fit: BoxFit.contain,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      body: Center(
        child: Text(
          "Main Content Area",
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}