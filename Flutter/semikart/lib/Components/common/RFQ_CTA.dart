import 'package:flutter/material.dart';
import 'red_button.dart';

class RFQComponent extends StatelessWidget {
  const RFQComponent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Container(
      width: screenWidth * 0.9, // 90% of the screen width
      height: screenHeight * 0.15, // 15% of the screen height
      decoration: const BoxDecoration(
        color: Color(0xFFFFFFFF), // White background
      ),
      child: Stack(
        children: [
          Positioned(
            left: screenWidth * 0.02, // 2% of the screen width
            top: screenHeight * 0.02 - 40, // Move 20px up
            child: Image.asset(
              'public/assets/images/RFQ.png',
              width: screenWidth * 0.3, // 30% of the screen width
              height: screenHeight * 0.15, // 15% of the screen height
              fit: BoxFit.contain,
            ),
          ),
          Positioned(
            left: screenWidth * 0.35, // 35% of the screen width
            top: screenHeight * 0.01, // 1% of the screen height
            child: SizedBox(
              width: screenWidth * 0.5, // 50% of the screen width
              child: const Text(
                'Request for quote',
                style: TextStyle(
                  fontSize: 20,
                  fontFamily: 'Product Sans',
                  fontWeight: FontWeight.normal,
                  color: Color(0xFFA51414),
                ),
              ),
            ),
          ),
          Positioned(
            left: screenWidth * 0.37, // 37% of the screen width
            top: screenHeight * 0.06, // Adjusted to ensure 10px space from the text
            child: SizedBox(
              width: screenWidth * 0.4, // 40% of the screen width
              child: RedButton(
                label: "Submit RFQ",
                onPressed: () {
                  print('RFQ button pressed');
                },
                width: screenWidth * 0.4, // 40% of the screen width
              ),
            ),
          ),
        ],
      ),
    );
  }
}