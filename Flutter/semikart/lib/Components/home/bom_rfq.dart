import 'package:flutter/material.dart';
import '../common/red_button.dart'; // Import your RedButton
import '../rfq_bom/rfq_full.dart'; // Import the RFQFullPage

class BomRfqCard extends StatelessWidget {
  const BomRfqCard({super.key});

  @override
  Widget build(BuildContext context) {
    // Get screen dimensions
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    // Define responsive sizes based on screen dimensions
    // Adjust these multipliers as needed for your desired layout
    final cardWidth = screenWidth * 0.9; // 90% of screen width
    // Height might need adjustment based on content, using screen width for proportion
    final cardHeight = screenWidth * 0.95;
    final generalPadding = screenWidth * 0.04; // ~16 on 400 width
    final imageSize = screenWidth * 0.2; // ~80 on 400 width
    final horizontalSpacing = screenWidth * 0.03; // ~12 on 400 width
    final verticalSpacingSmall = screenHeight * 0.005; // ~4 on 800 height
    final verticalSpacingMedium = screenHeight * 0.01; // ~8 on 800 height
    final titleFontSize = screenWidth * 0.04; // ~16 on 400 width
    final bodyFontSize = screenWidth * 0.03; // ~12 on 400 width
    final buttonWidth = screenWidth * 0.22; // ~90 on 400 width
    final buttonHeight = screenHeight * 0.035; // ~30 on 800 height
    final buttonFontSize = screenWidth * 0.03; // ~12 on 400 width
    final dividerWidth = cardWidth * 0.9; // Relative to card width

    return Center(
      child: Container(
        width: cardWidth,
        // Consider using IntrinsicHeight or calculating height more dynamically
        // if content varies significantly. Fixed relative height might still overflow/underflow.
        height: cardHeight,
        padding: EdgeInsets.all(generalPadding),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [
              Color(0xFFF46D6D), // 19%
              Color(0xFFA51414), // 100%
            ],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
          // Use screen width for consistent corner rounding
          borderRadius: BorderRadius.circular(screenWidth * 0.025), // ~10 on 400 width
        ),
        child: Column(
          // Use MainAxisAlignment.spaceBetween if you want to push top/bottom sections apart
          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Smart BOM Section
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  // Responsive padding
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
            SizedBox(height: verticalSpacingMedium),
            Align(
              alignment: Alignment.centerRight,
              child: RedButton(
                label: "Go to BOM",
                onPressed: () {
                  // Handle BOM button tap
                  print("Go to BOM tapped"); // Added for testing
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
                height: 2, // Keep divider height minimal
                color: Colors.white,
              ),
            ),
            SizedBox(height: verticalSpacingMedium),

            // RFQ Section
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  // Responsive padding
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
            // Use Spacer if you want the button pushed to the very bottom,
            // but this might conflict with a fixed container height.
            // const Spacer(),
            SizedBox(height: verticalSpacingMedium), // Keep SizedBox if Spacer is not used
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
          ],
        ),
      ),
    );
  }
}
