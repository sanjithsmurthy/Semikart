import 'package:flutter/material.dart';

class InactiveButton extends StatelessWidget {
  final String label;
  final EdgeInsetsGeometry? padding;
  final double? width; // Optional width parameter
  final double? height; // Optional height parameter

  const InactiveButton({
    super.key,
    required this.label,
    this.padding,
    this.width, // Optional width
    this.height, // Optional height
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        // Get screen width
        final screenWidth = MediaQuery.of(context).size.width;

        // Dynamically calculate button width and font size if not provided
        final buttonWidth = width ?? screenWidth * 0.9; // Default: 90% of screen width
        final buttonHeight = height ?? 48.0; // Default: Fixed height of 48
        final fontSize = screenWidth < 400 ? 16.0 : 20.0; // Adjust font size for smaller screens

        return SizedBox(
          width: buttonWidth, // Use optional width or default
          height: buttonHeight, // Use optional height or default
          child: ElevatedButton(
            onPressed: null, // Always disabled
            style: ElevatedButton.styleFrom(
              backgroundColor: Color(0xFFA51414).withOpacity(0.2),
              disabledBackgroundColor: Color(0xFFA51414).withOpacity(0.2),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25),
              ),
              elevation: 0,
              padding: EdgeInsets.zero,
            ),
            child: Container(
              alignment: Alignment.center,
              child: Text(
                label,
                style: TextStyle(
                  color: Colors.white.withOpacity(0.5),
                  fontSize: fontSize, // Dynamically calculated font size
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