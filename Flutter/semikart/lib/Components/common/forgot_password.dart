import 'package:flutter/material.dart';

class ForgotPasswordButton extends StatelessWidget {
  final String label; // Customizable text for the button
  final VoidCallback onPressed; // Callback for button click

  const ForgotPasswordButton({
    super.key,
    required this.label,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final fontSize = screenWidth * 0.03; // Font size scales with screen width
    final iconSize = screenWidth * 0.05; // Icon size scales with screen width

    return GestureDetector(
      onTap: onPressed,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Text Label
          Text(
            label,
            style: TextStyle(
              fontSize: fontSize, // Dynamically scaled font size
              color: Colors.black, // Text color
            ),
          ),
          const SizedBox(width: 8), // Space between text and icon
          // Arrow Icon
          Icon(
            Icons.arrow_forward, // Built-in Figma-like arrow icon
            size: iconSize, // Dynamically scaled icon size
            color: const Color(0xFFA51414), // Red color for the arrow
          ),
        ],
      ),
    );
  }
}