import 'package:flutter/material.dart';
// Note: We are creating a new button style, so direct import of red_button.dart
// isn't strictly necessary unless you want to reuse some specific logic or constants
// from it. This code creates the button independently based on your description.

class ImageTextCapsuleButton extends StatelessWidget {
  final String imagePath;     // Path to the asset image
  final String label;         // Text to display
  final VoidCallback onPressed; // Action when tapped
  final double imageWidth;    // Optional: Width of the image
  final double imageHeight;   // Optional: Height of the image
  final double gap;           // Optional: Space between image and text
  final TextStyle? textStyle; // Optional: Style for the text

  const ImageTextCapsuleButton({
    super.key,
    required this.imagePath,
    required this.label,
    required this.onPressed,
    this.imageWidth = 24.0, // Default image width
    this.imageHeight = 24.0, // Default image height
    this.gap = 8.0,          // Default gap
    this.textStyle,         // Default text style (can be customized)
  });

  @override
  Widget build(BuildContext context) {
    // Define the default text style if none is provided
    final effectiveTextStyle = textStyle ??
        const TextStyle(
          // Using a common color for text on a white background
          color: Color(0xFF333333), // Dark gray is often readable
          fontSize: 14,
          fontWeight: FontWeight.w500, // Medium weight
          // Consider adding fontFamily if you have a specific one
          // fontFamily: 'YourFontFamily',
        );

    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: 182.5,
        height: 48,
        decoration: BoxDecoration(
          color: Colors.white, // White background
          // Using the specified corner radius
          borderRadius: BorderRadius.circular(30),
          boxShadow: [ // Optional: Add a subtle shadow for visual depth
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 1,
              blurRadius: 3,
              offset: const Offset(0, 1), // changes position of shadow
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center, // Center content horizontally
          crossAxisAlignment: CrossAxisAlignment.center, // Center content vertically
          children: [
            // Image Widget
            Image.asset(
              imagePath,
              width: imageWidth,
              height: imageHeight,
              // Optional: Apply color filter if needed, e.g., if the icon should match text color
              // color: effectiveTextStyle.color,
            ),
            // Gap between image and text
            SizedBox(width: gap),
            // Text Widget
            // Use Flexible to prevent overflow if text is too long
            Flexible(
              child: Text(
                label,
                style: effectiveTextStyle,
                overflow: TextOverflow.ellipsis, // Handle long text gracefully
                maxLines: 1, // Ensure text stays on one line
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// --- Example Usage ---
// You would place this widget within the build method of another widget, like so:
/*
@override
Widget build(BuildContext context) {
  return Scaffold(
    body: Center(
      child: ImageTextCapsuleButton(
        imagePath: 'public/assets/images/your_icon.png', // <-- Replace with your image path
        label: 'Upload File',                           // <-- Replace with your button text
        onPressed: () {
          print('Capsule button tapped!');
          // Add your file picking logic or other actions here
        },
        // --- Optional Customizations ---
        // imageWidth: 28,
        // imageHeight: 28,
        // gap: 10,
        // textStyle: TextStyle(
        //   color: Colors.blue, // Custom text color
        //   fontSize: 15,
        //   fontWeight: FontWeight.bold,
        // ),
      ),
    ),
  );
}
*/
