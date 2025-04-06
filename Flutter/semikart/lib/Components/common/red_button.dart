import 'package:flutter/material.dart';

class RedButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  final bool isLoading;
  final EdgeInsetsGeometry? padding;
  final double? width; // Optional custom width
  final double? height; // Optional custom height
  final double? fontSize; // Custom font size for the button text
  final bool isWhiteButton; // Attribute to trigger the white button variant

  const RedButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.isLoading = false,
    this.padding,
    this.width, // Optional custom width
    this.height, // Optional custom height
    this.fontSize, // Optional custom font size
    this.isWhiteButton = false, // Default to false (red button is default)
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        // Get the screen width
        final screenWidth = MediaQuery.of(context).size.width;

        // Dynamically calculate button width, height, and font size
        final buttonWidth = width ?? (screenWidth < 400 ? screenWidth * 0.9 : 343.0); // 90% of screen width for small screens
        final buttonHeight = height ?? 48.0; // Default height is 48
        final textFontSize = fontSize ?? (screenWidth < 400 ? 14.0 : 16.0); // Adjust font size for smaller screens

        return SizedBox(
          width: buttonWidth,
          height: buttonHeight,
          child: ElevatedButton(
            onPressed: isLoading ? null : onPressed,
            style: ElevatedButton.styleFrom(
              backgroundColor: isWhiteButton ? Colors.white : const Color(0xFFA51414), // White or red background
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25),
                side: isWhiteButton
                    ? const BorderSide(color: Color(0xFFA51414), width: 2.0) // Border for white button
                    : BorderSide.none, // No border for red button
              ),
              elevation: 0,
              padding: padding ?? EdgeInsets.zero, // Use provided padding or default to zero
            ),
            child: isLoading
                ? const SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    ),
                  )
                : Container(
                    alignment: Alignment.center,
                    child: Text(
                      label,
                      style: TextStyle(
                        color: isWhiteButton ? const Color(0xFFA51414) : Colors.white, // Text color based on variant
                        fontSize: textFontSize, // Dynamically calculated font size
                        height: 1.0,
                        fontFamily: 'Product Sans',
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ),
          ),
        );
      },
    );
  }
}
