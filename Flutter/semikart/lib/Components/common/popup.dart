import 'package:flutter/material.dart';
import 'red_button.dart';

class CustomPopup {
  static Future<void> show({
    required BuildContext context,
    String? title, // Optional title
    String? message, // Optional message
    String buttonText = 'OK', // Default button text
    String? imagePath, // Optional image path
  }) async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        // Dynamically calculate popup dimensions
        final popupWidth = MediaQuery.of(context).size.width * 0.9; // 90% of screen width
        final popupHeight = MediaQuery.of(context).size.height * 0.4; // 40% of screen height

        return Dialog(
          backgroundColor: Color(0xFFFFFFFF),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30), // Increased corner radius to 20
          ),
          child: Container(
            width: popupWidth,
            padding: EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min, // Make height dynamic
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Optional Image
                if (imagePath != null)
                  Image.asset(
                    imagePath,
                    width: popupWidth * 0.22, // Scale image width to 20% of popup width
                    height: popupWidth * 0.2, // Scale image height to 20% of popup width
                    fit: BoxFit.contain,
                  ),
                if (imagePath != null) SizedBox(height: 16), // Space between image and title

                // Optional Title
                if (title != null)
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: popupWidth * 0.05, // Scale font size to 5% of popup width
                      
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                if (title != null) SizedBox(height: 8), // Space between title and message

                // Optional Message
                if (message != null)
                  Text(
                    message,
                    style: TextStyle(
                      fontSize: popupWidth * 0.04, // Scale font size to 4% of popup width
                      
                    ),
                    textAlign: TextAlign.center,
                  ),
                if (message != null) SizedBox(height: 16), // Space between message and button

                // Button
                RedButton(
                  label: buttonText,
                  width: popupWidth * 0.3, // Scale button width to 30% of popup width
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}