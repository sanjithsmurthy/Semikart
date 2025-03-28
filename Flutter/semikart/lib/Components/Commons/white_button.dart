import 'package:flutter/material.dart';

class WhiteButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  final bool isLoading;
  final EdgeInsetsGeometry? padding;

  const WhiteButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.isLoading = false,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final screenWidth = MediaQuery.of(context).size.width;

        // Dynamically calculate button width and height based on screen size
        final buttonWidth = screenWidth * 0.4; // 40% of screen width
        final buttonHeight = screenWidth < 400 ? 33.0 : 40.0; // Adjust height for smaller screens (cast to double)
        final fontSize = screenWidth < 400 ? 14.0 : 16.0; // Adjust font size for smaller screens (cast to double)

        return Container(
          width: buttonWidth,
          height: buttonHeight,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                spreadRadius: 0,
                blurRadius: 4,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: ElevatedButton(
            onPressed: isLoading ? null : onPressed,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              foregroundColor: Color(0xFF000000),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50),
              ),
              elevation: 0,
              padding: padding ?? EdgeInsets.zero,
            ),
            child: isLoading
                ? SizedBox(
                    width: 16,
                    height: 16,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF000000)),
                    ),
                  )
                : Container(
                    alignment: Alignment.center,
                    child: Text(
                      label,
                      style: TextStyle(
                        color: Color(0xFF000000),
                        fontSize: fontSize, // Dynamically scaled font size
                        height: 19 / fontSize, // Line height relative to font size
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