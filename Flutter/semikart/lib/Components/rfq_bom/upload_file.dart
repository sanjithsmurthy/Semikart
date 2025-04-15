import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart'; // Import file_picker for selecting files
import '../common/red_button.dart'; // Import the RedButton class
import 'dart:io';

class CustomSquare extends StatefulWidget {
  const CustomSquare({super.key});

  @override
  State<CustomSquare> createState() => _CustomSquareState();
}

class _CustomSquareState extends State<CustomSquare> {
  String? _fileName; // Store the file name
  String? _fileExtension; // Store the file extension
  File? _selectedFile; // Store the selected file

  Future<void> _pickFile() async {
    // Allow the user to pick files (Excel and PDF documents)
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['xlsx', 'xls', 'pdf'], // Allowed file types
    );

    if (result != null && result.files.isNotEmpty) {
      final file = result.files.first;
      setState(() {
        _fileName = file.name; // Set the file name
        _fileExtension = file.extension; // Set the file extension
        if (file.path != null) {
          _selectedFile = File(file.path!); // Set the selected file
        }
      });
      print('File selected: ${file.name}');
    } else {
      print('File selection canceled.');
    }
  }

  Widget _getFileIcon() {
    // Return an appropriate icon based on the file type
    if (_fileExtension == null) {
      return Image.asset(
        'public/assets/images/cloud_icon.png', // Default cloud icon
        fit: BoxFit.contain,
      );
    }

    if (_fileExtension!.toLowerCase() == 'pdf') {
      return const Icon(Icons.picture_as_pdf,
          size: 50, color: Colors.red); // PDF icon
    } else if (['xlsx', 'xls'].contains(_fileExtension!.toLowerCase())) {
      return const Icon(Icons.table_chart,
          size: 50, color: Colors.green); // Excel file icon
    }

    return const Icon(Icons.insert_drive_file,
        size: 50, color: Colors.grey); // Default file icon
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
              // Display the file icon or the default cloud icon
              GestureDetector(
                onTap: _pickFile, // Call the _pickFile method when tapped
                child: Column(
                  children: [
                    SizedBox(
                      width: screenWidth * 0.25, // 25% of the screen width
                      height: screenHeight * 0.12, // 12% of the screen height
                      child: _getFileIcon(), // Display the file icon
                    ),
                    if (_fileName != null) // Display the file name if available
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Text(
                          _fileName!,
                          style: TextStyle(
                            fontSize: screenWidth * 0.035,
                            color: Colors.black,
                          ),
                          textAlign: TextAlign.center,
                          overflow:
                              TextOverflow.ellipsis, // Handle long file names
                          maxLines: 1,
                        ),
                      ),
                  ],
                ),
              ),
              if (_fileName == null) ...[
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
                    height: screenHeight *
                        0.008), // Reduced space between text lines
                Text(
                  'Supported formats: Excel (XLS, XLSX), PDF.',
                  style: TextStyle(
                    fontSize: screenWidth * 0.03, // 3% of the screen width
                    color: const Color(0xFF757575), // Gray color
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
              SizedBox(
                  height: screenHeight *
                      0.015), // Reduced space between text and button

              // Make the "Browse" button clickable
              Center(
                child: RedButton(
                  label: _fileName == null ? "Browse" : "Replace File",
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
