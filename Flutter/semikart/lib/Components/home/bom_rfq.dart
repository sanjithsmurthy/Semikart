import 'package:flutter/material.dart';
import '../common/red_button.dart'; // Import your RedButton// Import the RFQFullPage

class BomRfqCard extends StatelessWidget {
  const BomRfqCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Get screen dimensions
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    // --- Define Base Multipliers ---
    const double cardWidthMultiplier = 0.95;
    const double cardHeightMultiplier = 0.25; // Adjusted for half height
    // Reduced heightReduction by 1 to effectively increase card height slightly
    const double heightReduction = 49; // Height reduction in pixels 

    // --- Calculate Final Dimensions ---
    final cardWidth = screenWidth * cardWidthMultiplier;
    // The height calculation remains the same, but uses the adjusted heightReduction
    final cardHeight = (screenHeight * cardHeightMultiplier) - (screenHeight * 0.04); // Scalable reduction (~10px on 800px height)

    // --- Other dimensions based on screen size ---
    final generalPadding = cardWidth * 0.04;
    final imageSize = 80.0; // Set fixed image size to 80.0
    final horizontalSpacing = cardWidth * 0.03;
    final verticalSpacingSmall = cardHeight * 0.004;
    final titleFontSize = cardWidth * 0.04;
    final bodyFontSize = cardWidth * 0.03;
    final buttonWidth = screenWidth * 0.22; // Use screenWidth for buttonWidth
    final buttonHeight =
        screenHeight * 0.04; // Use screenHeight for buttonHeight
    final buttonFontSize = cardWidth * 0.025;

    return Center(
      child: SizedBox(
        width: cardWidth,
        height: cardHeight, // Use the calculated cardHeight
        child: Card(
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(screenWidth * 0.025),
          ),
          margin: EdgeInsets.zero,
          color: Colors.transparent,
          child: Container(
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [
                  Color(0xFFF46D6D),
                  Color(0xFFA51414),
                ],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
              borderRadius: BorderRadius.circular(screenWidth * 0.025),
            ),
            padding: EdgeInsets.all(generalPadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.max,
              children: [
                // RFQ Section
                Expanded(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                            left: screenWidth * 0.025,
                            bottom: screenHeight * 0.01), // Added 2 pixels padding
                        child: Image.asset(
                          'public/assets/images/RFQ.png',
                          width: imageSize,
                          height: imageSize,
                          fit: BoxFit.cover,
                        ),
                      ),
                      SizedBox(width: horizontalSpacing),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Request For Quote",
                              style: TextStyle(
                                fontSize: titleFontSize,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(height: verticalSpacingSmall),
                            Text(
                              "Looking for the best price?\nNeed a larger quantity?\nOr do you have a target price that none of our competitors can match?",
                              style: TextStyle(
                                fontSize: bodyFontSize,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: verticalSpacingSmall),
                Align(
                  alignment: Alignment.centerRight,
                  child: RedButton(
                    label: "RFQ",
                    onPressed: () {
                      Navigator.of(context).pushNamed('rfq');

                    },
                    width: buttonWidth,
                    height: buttonHeight,
                    isWhiteButton: true,
                    fontSize: buttonFontSize,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
