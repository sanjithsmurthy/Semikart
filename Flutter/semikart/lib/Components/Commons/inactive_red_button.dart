import 'package:flutter/material.dart';

class InactiveButton extends StatelessWidget {
  final String label;
  final EdgeInsetsGeometry? padding;

  const InactiveButton({
    super.key,
    required this.label,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        // Get screen width
        final screenWidth = MediaQuery.of(context).size.width;

        // Dynamically calculate button width and font size
        final buttonWidth = screenWidth < 400 ? screenWidth * 0.9 : 343.0; // 90% of screen width for small screens
        final fontSize = screenWidth < 400 ? 16.0 : 20.0; // Adjust font size for smaller screens

        return SizedBox(
          width: buttonWidth,
          height: 48, // Fixed height for the button
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