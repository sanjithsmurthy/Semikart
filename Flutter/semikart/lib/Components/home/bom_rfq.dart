import 'package:flutter/material.dart';
import '../common/red_button.dart'; // Import your RedButton
import '../rfq_bom/rfq_full.dart'; // Import the RFQFullPage

class BomRfqCard extends StatelessWidget {
  const BomRfqCard({super.key});

  // Adjust the target aspect ratio (height / width).
  // Increase the height relative to the width slightly compared to the previous version
  // to provide more vertical space for the content.
  // Example: Use a ratio closer to 0.9 (height) / 0.95 (width)
  static const double targetAspectRatio = 0.90 / 0.95; // Approx 0.947...

  @override
  Widget build(BuildContext context) {
    // Get screen dimensions
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    // --- Define Base Multiplier ---
    // Keep the width multiplier as desired
    const double cardWidthMultiplier = 0.95;

    // --- Calculate Final Dimensions ---
    // Calculate the final width based on the multiplier
    final cardWidth = screenWidth * cardWidthMultiplier;
    // Calculate the final height using the width and the adjusted target aspect ratio
    final cardHeight = cardWidth * targetAspectRatio;

    // --- Other dimensions remain based on screen size ---
    // These define the size of elements *inside* the card.
    // Minor adjustments might be needed based on testing.
    final generalPadding = screenWidth * 0.04;
    final imageSize = screenWidth * 0.18;
    final horizontalSpacing = screenWidth * 0.03;
    final verticalSpacingSmall = screenHeight * 0.004;
    final verticalSpacingMedium = screenHeight * 0.009; // Slightly increased medium spacing
    final titleFontSize = screenWidth * 0.04;
    final bodyFontSize = screenWidth * 0.03;
    final buttonWidth = screenWidth * 0.22;
    final buttonHeight = screenHeight * 0.035;
    final buttonFontSize = screenWidth * 0.03;
    // Adjust divider width based on the new cardWidth
    final dividerWidth = cardWidth * 0.9;

    return Center(
      child: Container(
        width: cardWidth, // Use the calculated width
        height: cardHeight, // Use the calculated height
        padding: EdgeInsets.all(generalPadding),
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
        // Removed Clip.antiAlias as scrolling is removed
        // Removed SingleChildScrollView wrapper
        child: Column(
          // Use MainAxisAlignment to distribute space if needed, e.g., spaceEvenly
          // mainAxisAlignment: MainAxisAlignment.spaceEvenly, // Example
          children: [
            // Smart BOM Section
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(
                      left: screenWidth * 0.025, top: screenHeight * 0.02),
                  child: Image.asset(
                    'public/assets/images/bom_home.png',
                    width: imageSize,
                    height: imageSize,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(width: horizontalSpacing),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(top: screenHeight * 0.015),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Smart BOM",
                          style: TextStyle(
                            fontSize: titleFontSize,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Product Sans',
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(height: verticalSpacingSmall),
                        Text(
                          "Have a BOM ?\nUpload it to Semikart via our Smart BOM tool and instantly get prices from multiple suppliers.",
                          style: TextStyle(
                            fontSize: bodyFontSize,
                            color: Colors.white,
                            fontFamily: 'Product Sans',
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            // Use Spacer() instead of SizedBox if you want flexible spacing
            // const Spacer(), // Example: Pushes elements apart
            SizedBox(height: verticalSpacingMedium),
            Align(
              alignment: Alignment.centerRight,
              child: RedButton(
                label: "Go to BOM",
                onPressed: () {
                  print("Go to BOM tapped");
                },
                width: buttonWidth,
                height: buttonHeight,
                isWhiteButton: true,
                fontSize: buttonFontSize,
              ),
            ),
            SizedBox(height: verticalSpacingMedium),
            Center(
              child: Container(
                width: dividerWidth,
                height: 2,
                color: Colors.white,
              ),
            ),
            SizedBox(height: verticalSpacingMedium),

            // RFQ Section
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(
                      left: screenWidth * 0.025, top: screenHeight * 0.01),
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
                          fontFamily: 'Product Sans',
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: verticalSpacingSmall),
                      Text(
                        "Looking for the best price?\nNeed a larger quantity?\nOr do you have a target price that none of our competitors can match?",
                        style: TextStyle(
                          fontSize: bodyFontSize,
                          color: Colors.white,
                          fontFamily: 'Product Sans',
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            // Use Spacer() instead of SizedBox if you want flexible spacing
            // const Spacer(), // Example: Pushes elements apart
            SizedBox(height: verticalSpacingMedium),
            Align(
              alignment: Alignment.centerRight,
              child: RedButton(
                label: "Submit RFQ",
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const RFQFullPage()),
                  );
                },
                width: buttonWidth,
                height: buttonHeight,
                isWhiteButton: true,
                fontSize: buttonFontSize,
              ),
            ),
            // Removed extra SizedBox at the bottom
          ],
        ),
      ),
    );
  }
}
