import 'package:flutter/material.dart';

class SignInWithGoogleButton extends StatelessWidget {
  final VoidCallback onPressed;
  final bool isLoading;

  const SignInWithGoogleButton({
    Key? key,
    required this.onPressed,
    this.isLoading = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Get screen dimensions
    final screenWidth = MediaQuery.of(context).size.width;

    // Dynamically calculate button width and height based on screen size
    final buttonWidth = screenWidth * 0.45; // 45% of screen width
    final buttonHeight = screenWidth < 400 ? 50.0 : 58.0; // Adjust height for smaller screens
    final iconSize = screenWidth < 400 ? 35.0 : 40.0; // Adjust icon size for smaller screens
    final fontSize = screenWidth < 400 ? 12.0 : 14.0; // Adjust font size for smaller screens

    return Container(
      width: buttonWidth,
      height: buttonHeight,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(50),
        border: Border.all(
          color: Colors.white,
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            spreadRadius: 0,
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: MaterialButton(
        padding: EdgeInsets.zero,
        onPressed: isLoading ? null : onPressed,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50),
        ),
        child: Padding(
          padding: EdgeInsets.only(left: 13.0), // 13px from left corner
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: iconSize, // Dynamically calculated icon size
                height: iconSize, // Dynamically calculated icon size
                child: Icon(
                  Icons.g_mobiledata_rounded,
                  size: iconSize, // Dynamically calculated icon size
                  color: Color(0xFF4285F4),
                ),
              ),
              SizedBox(width: 12), // 12px spacing between icon and text
              Text(
                'Sign in with\nGoogle',
                style: TextStyle(
                  color: Color(0xFF000000),
                  fontSize: fontSize, // Dynamically calculated font size
                  height: 1.2,
                  fontFamily: 'Product Sans',
                  fontWeight: FontWeight.normal,
                ),
                textAlign: TextAlign.center,
                maxLines: 2,
              ),
            ],
          ),
        ),
      ),
    );
  }
}