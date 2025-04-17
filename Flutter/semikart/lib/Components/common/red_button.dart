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
        // Get the screen width and height
        final screenWidth = MediaQuery.of(context).size.width;
        final screenHeight = MediaQuery.of(context).size.height;

        // Dynamically calculate button width, height, and font size
        final buttonWidth = width ??
            (screenWidth < 400
                ? screenWidth * 0.9
                : screenWidth *
                    0.7); // 90% of screen width for small screens, 70% for larger screens
        final buttonHeight =
            height ?? screenHeight * 0.06; // 6% of screen height
        final textFontSize = fontSize ??
            (screenWidth < 400
                ? screenWidth * 0.035
                : screenWidth *
                    0.04); // 3.5% of screen width for small screens, 4% for larger screens
        final borderRadius = screenWidth * 0.0625; // 6.25% of screen width
        final progressIndicatorSize = screenWidth * 0.05; // 5% of screen width
        final borderWidth = screenWidth * 0.0025; // 0.25% of screen width
        final progressIndicatorStrokeWidth =
            screenWidth * 0.005; // 0.5% of screen width

        return SizedBox(
          width: buttonWidth,
          height: buttonHeight,
          child: ElevatedButton(
            onPressed: isLoading ? null : onPressed,
            style: ElevatedButton.styleFrom(
              backgroundColor: isWhiteButton
                  ? Colors.white
                  : const Color(0xFFA51414), // White or red background
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(borderRadius),
                side: isWhiteButton
                    ? BorderSide(
                        color: const Color(0xFFA51414),
                        width: borderWidth) // Border for white button
                    : BorderSide.none, // No border for red button
              ),
              elevation: 0,
              padding: padding ??
                  EdgeInsets.zero, // Use provided padding or default to zero
            ),
            child: isLoading
                ? SizedBox(
                    width: progressIndicatorSize,
                    height: progressIndicatorSize,
                    child: CircularProgressIndicator(
                      strokeWidth: progressIndicatorStrokeWidth,
                      valueColor:
                          const AlwaysStoppedAnimation<Color>(Colors.white),
                    ),
                  )
                : Container(
                    alignment: Alignment.center,
                    child: Text(
                      label,
                      style: TextStyle(
                        color: isWhiteButton
                            ? const Color(0xFFA51414)
                            : Colors.white, // Text color based on variant
                        fontSize:
                            textFontSize, // Dynamically calculated font size
                        height: 1.0,

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
