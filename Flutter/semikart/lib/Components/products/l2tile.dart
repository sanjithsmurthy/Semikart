import 'package:flutter/material.dart';

class l2tile extends StatelessWidget {
  final String label;
  final VoidCallback onTap;
  final double width; // Add width as a parameter

  const l2tile({
    super.key,
    required this.label,
    required this.onTap,
    required this.width, // Make width required
  });

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    // Dynamically calculate dimensions based on screen size
    final containerHeight = screenHeight * 0.065; // ~6.5% of screen height (~59px for 917px height)
    final borderRadius = width * 0.025; // ~2.5% of width (~10px for 412px width)
    final borderWidth = width * 0.0025; // ~0.25% of width (~1px for 412px width)
    final fontSize = width * 0.04; // ~4% of width (~16px for 412px width)

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width, // Use the passed width
        height: containerHeight,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
            color: const Color(0xFFA51414), // Border color (A51414)
            width: borderWidth, // Border width (~1px)
          ),
          borderRadius: BorderRadius.circular(borderRadius), // Border radius (~10px)
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: fontSize, // Dynamically scalable font size (~16px)
            fontWeight: FontWeight.normal,
            color: Colors.black,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}