import 'package:flutter/material.dart';

class SignInWithGoogleButton extends StatelessWidget {
  final VoidCallback onPressed;
  final bool isLoading;
  final bool isTwoLine; // Determines if the text is displayed in two lines

  const SignInWithGoogleButton({
    Key? key,
    required this.onPressed,
    this.isLoading = false,
    this.isTwoLine = false, // Default to single-line text
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Get screen dimensions
    final screenWidth = MediaQuery.of(context).size.width;

    // Dynamically calculate icon size, font size, and padding
    final iconSize = screenWidth < 400 ? 24.0 : 28.0; // Adjust icon size for smaller screens
    final fontSize = screenWidth < 400 ? 14.0 : 16.0; // Adjust font size for smaller screens
    final basePadding = screenWidth * 0.01 + 5.0; // Base padding
    final horizontalPadding = isTwoLine ? basePadding + 5.0 : basePadding; // Add 5px more padding for two-line buttons

    // Dynamically calculate button height based on isTwoLine
    final buttonHeight = isTwoLine ? null : 56.0; // Use null for flexible height for two-line buttons
    final borderRadius = 28.0; // Fixed border radius for rounded corners

    return Padding(
      padding: EdgeInsets.all(basePadding), // Add dynamic padding on all sides
      child: GestureDetector(
        onTap: onPressed, // Handle button click
        child: Material(
          color: Colors.transparent, // Transparent material for ripple effect
          borderRadius: BorderRadius.circular(borderRadius),
          elevation: 4, // Add elevation for shadow
          shadowColor: Colors.black.withOpacity(0.2), // Enhance shadow visibility
          child: ClipRRect(
            borderRadius: BorderRadius.circular(borderRadius), // Clip overflow
            child: Container(
              constraints: BoxConstraints(
                minHeight: 56.0, // Minimum height for single-line buttons
              ),
              padding: EdgeInsets.symmetric(
                vertical: basePadding, // Keep vertical padding consistent
                horizontal: horizontalPadding, // Adjust horizontal padding dynamically
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(borderRadius), // Set border radius to 50%
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2), // Enhance shadow opacity
                    spreadRadius: 1,
                    blurRadius: 6,
                    offset: const Offset(0, 3), // Shadow position
                  ),
                ],
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Google Icon
                  Container(
                    width: iconSize,
                    height: iconSize,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('public/assets/icon/google.png'), // Replace with your Google logo asset
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12), // Spacing between icon and text
                  // Button Text
                  isTwoLine
                      ? Column(
                          mainAxisAlignment: MainAxisAlignment.center, // Align text vertically in the center
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Sign in with',
                              style: TextStyle(
                                color: const Color(0xFF000000),
                                fontSize: fontSize, // Dynamically calculated font size
                                fontWeight: FontWeight.w500,
                                 // Use Product Sans font if available
                              ),
                            ),
                            Text(
                              'Google',
                              style: TextStyle(
                                color: const Color(0xFF000000),
                                fontSize: fontSize, // Dynamically calculated font size
                                fontWeight: FontWeight.w500,
                                 // Use Product Sans font if available
                              ),
                            ),
                          ],
                        )
                      : Text(
                          'Sign in with Google',
                          style: TextStyle(
                            color: const Color(0xFF000000),
                            fontSize: fontSize, // Dynamically calculated font size
                            fontWeight: FontWeight.w500,
                             // Use Product Sans font if available
                          ),
                        ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}