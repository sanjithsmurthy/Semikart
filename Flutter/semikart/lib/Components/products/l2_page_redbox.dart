import 'package:flutter/material.dart';

class RedBorderBox extends StatelessWidget {
  final String text; // Text to display inside the box
  final double widthFactor; // Width factor relative to screen width
  final Color borderColor; // Border color
  final TextStyle? textStyle; // Custom text style
  final EdgeInsetsGeometry? padding; // Padding inside the box

  const RedBorderBox({
    super.key,
    required this.text,
    this.widthFactor = 0.9, // Default width is 90% of screen width
    this.borderColor = const Color(0xFFA51414), // Default border color
    this.textStyle,
    this.padding, // Allow custom padding, otherwise calculate dynamically
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    // Dynamic scaling based on reference size (412x917)
    final double dynamicHeight = screenHeight * 0.08; // 8% of screen height
    final double dynamicBorderRadius = screenWidth * (10 / 412); // Approx 10 on 412px width
    final double dynamicBorderWidth = screenWidth * (1.5 / 412); // Approx 1.5 on 412px width
    final double dynamicFontSize = screenHeight * (16 / 917); // Approx 16 on 917px height
    final EdgeInsetsGeometry dynamicPadding = padding ?? EdgeInsets.symmetric(horizontal: screenWidth * (16 / 412)); // Approx 16 on 412px width

    return Center(
      child: Container(
        width: screenWidth * widthFactor, // Responsive width
        height: dynamicHeight, // Responsive height
        padding: dynamicPadding, // Apply dynamic or custom padding
        decoration: BoxDecoration(
          border: Border.all(
              color: borderColor, width: dynamicBorderWidth), // Dynamic border width
          borderRadius:
              BorderRadius.circular(dynamicBorderRadius), // Dynamic rounded corners
        ),
        child: Center(
          child: Text(
            text,
            style: textStyle ??
                TextStyle( // Use dynamic font size if no custom style is provided
                  fontSize: dynamicFontSize,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}