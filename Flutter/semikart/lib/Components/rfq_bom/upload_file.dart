import 'package:flutter/material.dart';
import '../common/red_button.dart'; // Import the RedButton class

class CustomSquare extends StatelessWidget {
  const CustomSquare({super.key});

  @override
  Widget build(BuildContext context) {
    // Get screen width and height
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Center(
      child: GestureDetector(
        onTap: () {
          // Handle the click event for the entire container
          print("Container clicked!");
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Container clicked!")),
          );
        },
        child: Container(
          width: screenWidth * 0.8, // 80% of the screen width (smaller box)
          height: screenHeight * 0.35, // 35% of the screen height (smaller box)
          decoration: BoxDecoration(
            color: Colors.white, // Background color of the square
            borderRadius: BorderRadius.circular(20), // Corner radius
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5), // Gray shadow with opacity
                spreadRadius: 5, // Spread radius of the shadow
                blurRadius: 10, // Blur radius of the shadow
                offset: Offset(0, 3), // Offset of the shadow (x, y)
              ),
            ],
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: screenWidth * 0.05), // Add horizontal padding
            child: Stack(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Insert PNG image at the top
                    Image.asset(
                      'public/assets/images/cloud_icon.png', // Path to your PNG file
                      width: screenWidth * 0.25, // 25% of the screen width
                      height: screenHeight * 0.12, // 12% of the screen height
                      fit: BoxFit
                          .contain, // Adjust the image to fit within the box
                    ),
                    SizedBox(
                        height: screenHeight *
                            0.01), // Reduced space between image and text
                    Text(
                      'Upload Parts List',
                      style: TextStyle(
                        fontSize: screenWidth * 0.04, // 4% of the screen width
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF000000), // Black color
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(
                        height: screenHeight *
                            0.008), // Reduced space between text lines
                    Text(
                      'All file formats supported.',
                      style: TextStyle(
                        fontSize: screenWidth * 0.03, // 3% of the screen width
                        color: Color(0xFF757575), // Gray color
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(
                        height: screenHeight *
                            0.008), // Reduced space between text lines
                    Text(
                      'click to upload files.',
                      style: TextStyle(
                        fontSize: screenWidth * 0.03, // 3% of the screen width
                        color: Color(0xFFA51414), // Red color
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(
                        height: screenHeight *
                            0.015), // Reduced space between text and button
                    Center(
                      child: RedButton(
                        label: "Browse",
                        onPressed: () {
                          print('Red button pressed!');
                        },
                      ), // Use the RedButton widget
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}