import 'package:flutter/material.dart';
import 'red_button.dart';

class CustomPopup {
  // --- Changed return type to Future<bool?> ---
  static Future<bool?> show({
    required BuildContext context,
    String? title, // Optional title
    String? message, // Optional message
    required String buttonText, // Confirm button text is now required
    String? cancelButtonText, // Optional cancel button text
    String? imagePath, // Optional image path
  }) async {
    // --- Changed showDialog to expect bool? ---
    return await showDialog<bool?>( // Expect a nullable boolean result
      context: context,
      barrierDismissible: false, // Prevent dismissing by tapping outside (optional but common for confirmation)
      builder: (BuildContext context) {
        final screenWidth = MediaQuery.of(context).size.width;
        final screenHeight = MediaQuery.of(context).size.height; // Use screen height for scaling if needed

        // Use screen width for responsive sizing
        final popupWidth = screenWidth * 0.85; // Slightly smaller width

        return Dialog(
          backgroundColor: Colors.white, // Explicit white background
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20), // Consistent corner radius
          ),
          child: Container(
            width: popupWidth,
            padding: const EdgeInsets.all(24), // Consistent padding
            child: Column(
              mainAxisSize: MainAxisSize.min, // Fit content height
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Optional Image
                if (imagePath != null)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 16.0),
                    child: Image.asset(
                      imagePath,
                      width: popupWidth * 0.25, // Slightly larger image
                      height: popupWidth * 0.25,
                      fit: BoxFit.contain,
                    ),
                  ),

                // Optional Title
                if (title != null)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Text(
                      title,
                      style: TextStyle(
                        fontSize: popupWidth * 0.055, // Slightly larger title
                        fontWeight: FontWeight.bold,
                        color: Colors.black87, // Darker text
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),

                // Optional Message
                if (message != null)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 24.0), // More space before buttons
                    child: Text(
                      message,
                      style: TextStyle(
                        fontSize: popupWidth * 0.045, // Slightly larger message
                        color: Colors.black54, // Greyer text
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),

                // Buttons Row
                Row(
                  mainAxisAlignment: cancelButtonText != null
                      ? MainAxisAlignment.spaceEvenly // Space out if two buttons
                      : MainAxisAlignment.center, // Center if only one button
                  children: [
                    // Cancel Button (optional)
                    if (cancelButtonText != null)
                      RedButton(
                        label: cancelButtonText,
                        onPressed: () {
                          // --- Pop with false for cancel ---
                          Navigator.of(context).pop(false);
                        },
                        width: popupWidth * 0.35, // Adjust width
                        height: 45, // Standard height
                        isWhiteButton: true, // Make it look different
                      ),

                    // Confirm Button
                    RedButton(
                      label: buttonText,
                      onPressed: () {
                        // --- Pop with true for confirm ---
                        Navigator.of(context).pop(true);
                      },
                      width: cancelButtonText != null
                          ? popupWidth * 0.35 // Adjust width if two buttons
                          : popupWidth * 0.6, // Wider if only one button
                      height: 45, // Standard height
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}