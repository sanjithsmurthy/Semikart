import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // For status bar customization

class TestLayoutSanjana extends StatefulWidget {
  const TestLayoutSanjana({super.key});

  @override
  State<TestLayoutSanjana> createState() => _TestLayoutSanjanaState();
}

class _TestLayoutSanjanaState extends State<TestLayoutSanjana> {
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
              // App Icon Back Logo
              Positioned(
                left: screenWidth * 0.05, // 22 dynamically scaled
                top: screenHeight * 0.06, // 49 dynamically scaled
                child: Icon(
                  Icons.arrow_back, // Back icon
                  size: screenWidth * 0.08, // Dynamically scale the size
                  color: Colors.black, // Black color for contrast
                ),
              ),

              // Semikart Logo
              Positioned(
                left: screenWidth * 0.12, // 45 dynamically scaled
                top: screenHeight * 0.06, // 47 dynamically scaled
                child: Image.asset(
                  'assets/images/semikart_logo.png', // Replace with the actual path to your logo
                  width: screenWidth * 0.4, // Dynamically scale width
                  fit: BoxFit.contain,
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