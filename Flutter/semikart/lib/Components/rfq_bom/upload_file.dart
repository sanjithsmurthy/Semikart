import 'package:flutter/material.dart';

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
          width: screenWidth * 0.9, // 90% of the screen width
          height: screenHeight * 0.4, // 40% of the screen height
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
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                    height:
                        screenHeight * 0.05), // Space from top of the square
                // Insert PNG image at the top
                Image.asset(
                  'public/assets/images/cloud_icon.png', // Path to your PNG file
                  width: screenWidth * 0.25, // 25% of the screen width
                  height: screenHeight * 0.15, // 15% of the screen height
                  fit: BoxFit.contain, // Adjust the image to fit within the box
                ),
                SizedBox(
                    height:
                        screenHeight * 0.05), // Space between image and text
                Text(
                  'Upload parts list',
                  style: TextStyle(
                    fontSize: screenWidth * 0.045, // 4.5% of the screen width
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF000000), // Black color
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                    height: screenHeight * 0.02), // Space between text lines
                Text(
                  'All file formats supported.',
                  style: TextStyle(
                    fontSize: screenWidth * 0.035, // 3.5% of the screen width
                    color: Color(0xFF757575), // Gray color
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                    height: screenHeight * 0.02), // Space between text lines
                Text(
                  'Drag and Drop files or click to upload files.',
                  style: TextStyle(
                    fontSize: screenWidth * 0.035, // 3.5% of the screen width
                    color: Color(0xFFA51414), // Red color
                  ),
                  textAlign: TextAlign.center,
                ),
                Spacer(), // Pushes the text to the bottom
              ],
            ),
          ),
        ),
      ),
    );
  }
}
