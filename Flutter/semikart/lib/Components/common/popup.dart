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
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Container(
            width: popupWidth,
            padding: const EdgeInsets.all(18), // Slightly less padding
            child: Column(
              mainAxisSize: MainAxisSize.min,
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
                    padding: const EdgeInsets.only(bottom: 6.0),
                    child: Text(
                      title,
                      style: TextStyle(
                        fontSize: popupWidth * 0.042, // Smaller title
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),

                // Optional Message
                if (message != null)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 16.0),
                    child: Text(
                      message,
                      style: TextStyle(
                        fontSize: popupWidth * 0.034, // Smaller message
                        color: Colors.black54,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),

                // Buttons Row
                Row(
                  mainAxisAlignment: cancelButtonText != null
                      ? MainAxisAlignment.spaceEvenly
                      : MainAxisAlignment.center,
                  children: [
                    // Cancel Button (optional)
                    if (cancelButtonText != null)
                      RedButton(
                        label: cancelButtonText,
                        onPressed: () {
                          Navigator.of(context).pop(false);
                        },
                        width: popupWidth * 0.28, // Smaller width
                        height: 34, // Smaller height
                        fontSize: 13, // Smaller font
                        isWhiteButton: true,
                      ),

                    // Confirm Button
                    RedButton(
                      label: buttonText,
                      onPressed: () {
                        Navigator.of(context).pop(true);
                      },
                      width: cancelButtonText != null
                          ? popupWidth * 0.28
                          : popupWidth * 0.45,
                      height: 34, // Smaller height
                      fontSize: 13, // Smaller font
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