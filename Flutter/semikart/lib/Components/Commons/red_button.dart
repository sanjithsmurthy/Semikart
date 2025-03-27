import 'package:flutter/material.dart';

class RedButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  final bool isLoading;
  final EdgeInsetsGeometry? padding;
  final String variant;  // Added variant parameter
  final double? width;   // Added width parameter

  const RedButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.isLoading = false,
    this.padding,
    this.variant = 'big',  // Default to 'big'
    this.width,           // Optional custom width
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final screenWidth = MediaQuery.of(context).size.width;
        final buttonWidth = width ?? (screenWidth < 400 ? screenWidth * 0.9 : 343.0);
        final fontSize = variant == 'big' ? 20.0 : 16.0;  // Font size based on variant

        return SizedBox(
          width: buttonWidth,
          height: 48,
          child: ElevatedButton(
            onPressed: isLoading ? null : onPressed,
            style: ElevatedButton.styleFrom(
              backgroundColor: Color(0xFFA51414),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25),
              ),
              elevation: 0,
              padding: EdgeInsets.zero,
            ),
            child: isLoading
                ? SizedBox(
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
                        color: Colors.white,
                        fontSize: fontSize,  // Use dynamic font size
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
