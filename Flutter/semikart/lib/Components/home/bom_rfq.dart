import 'package:flutter/material.dart';
import '../common/red_button.dart'; 
import '../rfq_bom/rfq_full.dart'; // Import the RFQFullPage widget

class BomRfqCard extends StatefulWidget {
  const BomRfqCard({Key? key}) : super(key: key);

  @override
  State<BomRfqCard> createState() => _BomRfqCardState();
}

class _BomRfqCardState extends State<BomRfqCard> {
  void _showRFQOverlay(BuildContext context) {
    showGeneralDialog(
      context: context,
      barrierDismissible: true, // Allow dismissing by tapping outside
      barrierLabel: "Dismiss",
      barrierColor: Colors.black.withOpacity(0.5), // Semi-transparent background
      transitionDuration: const Duration(milliseconds: 300),
      pageBuilder: (context, animation, secondaryAnimation) {
        return Material( // Wrap the dialog content in a Material widget
          type: MaterialType.transparency,
          child: Center(
            child: Container(
              constraints: BoxConstraints(
                maxHeight: MediaQuery.of(context).size.height * 0.7, // 70% of screen height
                maxWidth: MediaQuery.of(context).size.width * 0.9, // 90% of screen width
              ),
              padding: const EdgeInsets.only(
                top: 3,
                bottom: 8,
                left: 0,
                right: 0,
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.topRight,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 10, right: 10), // Reduced top padding
                      child: IconButton(
                        icon: const Icon(
                          Icons.close,
                          color: Colors.black,
                          size: 32,
                        ),
                        onPressed: () {
                          Navigator.of(context).pop(); // Close the overlay
                        },
                      ),
                    ),
                  ),
                  Expanded(
                    child: RFQFullPage(), // Display RFQFullPage content
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // Get screen dimensions
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    // --- Define Base Multipliers ---
    const double cardWidthMultiplier = 0.95;
    const double cardHeightMultiplier = 0.25;

    // --- Calculate Final Dimensions ---
    final cardWidth = screenWidth * cardWidthMultiplier;
    final cardHeight = screenHeight * cardHeightMultiplier;

    // --- Other dimensions based on screen size ---
    final generalPadding = cardWidth * 0.04;
    final imageSize = 80.0;
    final horizontalSpacing = cardWidth * 0.03;
    final verticalSpacingSmall = cardHeight * 0.004;
    final titleFontSize = cardWidth * 0.04;
    final bodyFontSize = cardWidth * 0.03;
    final buttonWidth = screenWidth * 0.22;
    final buttonHeight = screenHeight * 0.04;
    final buttonFontSize = cardWidth * 0.025;

    return Center(
      child: SizedBox(
        width: cardWidth,
        height: cardHeight,
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
                          bottom: screenHeight * 0.01,
                        ),
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
                    onPressed: () => _showRFQOverlay(context), // Show the full-screen overlay
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