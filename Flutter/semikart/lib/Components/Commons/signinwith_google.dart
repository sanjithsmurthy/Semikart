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

    // Dynamically calculate button width, height, icon size, and font size
    final buttonWidth = screenWidth * 0.5; // 50% of screen width
    final buttonHeight = screenWidth < 400 ? 56.0 : 58.0; // Adjust height for smaller screens
    final iconSize = screenWidth < 400 ? 24.0 : 28.0; // Adjust icon size for smaller screens
    final fontSize = screenWidth < 400 ? 14.0 : 16.0; // Adjust font size for smaller screens

    return Container(
      width: buttonWidth,
      height: buttonHeight,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(28), // Rounded corners
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            spreadRadius: 0,
            blurRadius: 4,
            offset: const Offset(0, 2), // Shadow position
          ),
        ],
      ),
      child: MaterialButton(
        padding: EdgeInsets.zero,
        onPressed: isLoading ? null : onPressed,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(28),
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
                          fontFamily: 'Product Sans', // Use Product Sans font if available
                        ),
                      ),
                      Text(
                        'Google',
                        style: TextStyle(
                          color: const Color(0xFF000000),
                          fontSize: fontSize, // Dynamically calculated font size
                          fontWeight: FontWeight.w500,
                          fontFamily: 'Product Sans', // Use Product Sans font if available
                        ),
                      ),
                    ],
                  )
                : Center(
                    child: Text(
                      'Sign in with Google',
                      style: TextStyle(
                        color: const Color(0xFF000000),
                        fontSize: fontSize, // Dynamically calculated font size
                        fontWeight: FontWeight.w500,
                        fontFamily: 'Product Sans', // Use Product Sans font if available
                      ),
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}