import 'package:flutter/material.dart';

class InactiveButton extends StatelessWidget {
  final String label;
  final EdgeInsetsGeometry? padding;

  const InactiveButton({
    Key? key,
    required this.label,
    this.padding,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final screenWidth = MediaQuery.of(context).size.width;
        final buttonWidth = screenWidth < 400 ? screenWidth * 0.9 : 343.0;
        
        return SizedBox(
          width: buttonWidth,
          height: 48,
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
                  fontSize: 20,
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