import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart'; // Import file_picker for selecting files
import '../common/red_button.dart'; // Import the RedButton class

class CustomSquare extends StatelessWidget {
  const CustomSquare({super.key});

  Future<void> _pickFile() async {
    // Allow the user to pick files (images, PDFs, Word documents)
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: [
        'jpg',
        'jpeg',
        'png',
        'pdf',
        'doc',
        'docx'
      ], // Allowed file types
    );

    if (result != null && result.files.isNotEmpty) {
      final file = result.files.first;
      print('File selected: ${file.name}');
      // You can now use the file path to upload the file or perform other actions
    } else {
      print('File selection canceled.');
    }
  }

  @override
  Widget build(BuildContext context) {
    // Get screen width and height
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Center(
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
              offset: const Offset(0, 3), // Offset of the shadow (x, y)
            ),
          ],
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: screenWidth * 0.05), // Add horizontal padding
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Make the image clickable
              GestureDetector(
                onTap:
                    _pickFile, // Call the _pickFile method when the image is tapped
                child: Image.asset(
                  'public/assets/images/cloud_icon.png', // Path to your PNG file
                  width: screenWidth * 0.25, // 25% of the screen width
                  height: screenHeight * 0.12, // 12% of the screen height
                  fit: BoxFit.contain, // Adjust the image to fit within the box
                ),
              ),
              SizedBox(
                  height: screenHeight *
                      0.01), // Reduced space between image and text
              Text(
                'Upload Parts List',
                style: TextStyle(
                  fontSize: screenWidth * 0.04, // 4% of the screen width
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF000000), // Black color
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                  height:
                      screenHeight * 0.008), // Reduced space between text lines
              Text(
                'Supported formats: JPG, PNG, PDF, DOC, DOCX.',
                style: TextStyle(
                  fontSize: screenWidth * 0.03, // 3% of the screen width
                  color: const Color(0xFF757575), // Gray color
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                  height:
                      screenHeight * 0.008), // Reduced space between text lines
              Text(
                'Click to upload files.',
                style: TextStyle(
                  fontSize: screenWidth * 0.03, // 3% of the screen width
                  color: const Color(0xFFA51414), // Red color
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                  height: screenHeight *
                      0.015), // Reduced space between text and button

              // Make the "Browse" button clickable
              Center(
                child: RedButton(
                  label: "Browse",
                  onPressed: _pickFile, // Call the _pickFile method
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
