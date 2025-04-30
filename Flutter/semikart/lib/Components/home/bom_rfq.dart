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
    // Get screen dimensions for dialog sizing
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    showGeneralDialog(
      context: context,
      barrierDismissible: true, // Allow dismissing by tapping outside
      barrierLabel: "Dismiss",
      barrierColor:
          Colors.black.withOpacity(0.5), // Semi-transparent background
      transitionDuration: const Duration(milliseconds: 300),
      pageBuilder: (context, animation, secondaryAnimation) {
        return Material(
          // Wrap the dialog content in a Material widget
          type: MaterialType.transparency,
          child: Center(
            child: Container(
              constraints: BoxConstraints(
                // Use calculated screen dimensions
                maxHeight: screenHeight * 0.7, // 70% of screen height
                maxWidth: screenWidth * 0.9, // 90% of screen width
              ),
              padding: const EdgeInsets.only(
                top: 3,
                bottom: 8,
                left: 0,
                right: 0,
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(
                    12), // Consider scaling this radius too
              ),
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.topRight,
                    child: Padding(
                      padding: const EdgeInsets.only(
                          top: 10, right: 10), // Consider scaling padding
                      child: IconButton(
                        // Add constraints for better touch target sizing if needed
                        // constraints: BoxConstraints(),
                        // padding: EdgeInsets.zero,
                        icon: const Icon(
                          Icons.close,
                          color: Colors.black,
                          size: 32, // Consider scaling icon size
                        ),
                        onPressed: () {
                          Navigator.of(context).pop(); // Close the overlay
                        },
                      ),
                    ),
                  ),
                  const Expanded(
                    // Use const for static child
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
    // --- MODIFIED: Reduced height multiplier again ---
    // Previous: const double cardHeightMultiplier = 0.25 - 0.0327; // ~21.7% (~30px reduction)
    // New: Reduced by another ~10px (total ~40px reduction -> 0.0436)
    const double cardHeightMultiplier =
        0.25 - 0.0436; // Target height ~20.6% of screen height
    // --- End Modification ---

    // --- Calculate Final Dimensions ---
    final cardWidth = screenWidth * cardWidthMultiplier;
    final cardHeight =
        screenHeight * cardHeightMultiplier; // Height will be smaller now

    // --- Other dimensions based on screen size ---
    final generalPadding = cardWidth * 0.04;
    final imageSize = 80.0; // Keep image size static or make relative
    final horizontalSpacing = cardWidth * 0.03;
    // Adjust vertical spacing if needed for the even smaller height
    final verticalSpacingSmall = cardHeight * 0.025; // May need adjustment
    final titleFontSize = cardWidth * 0.044;
    final bodyFontSize = cardWidth * 0.032;
    final buttonWidth = screenWidth * 0.22;
    final buttonHeight = screenHeight * 0.04;
    final buttonFontSize = cardWidth * 0.029;
    final borderRadiusValue = screenWidth * 0.025;

    // --- Image Padding Calculations ---
    final imageLeftPadding = screenWidth * 0.025; // Original left padding
    const double imageTopPaddingFraction =
        0.0218; // Fraction for ~20px downward shift (kept from previous step)
    final imageTopPadding =
        screenHeight * imageTopPaddingFraction; // Calculate final top padding

    return Center(
      child: SizedBox(
        width: cardWidth,
        height: cardHeight, // Using the further reduced height
        child: Card(
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadiusValue),
          ),
          margin: EdgeInsets.zero,
          color: Colors.transparent,
          clipBehavior: Clip.antiAlias,
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
            ),
            padding: EdgeInsets.all(generalPadding),
            child: Column(
              children: [
                // RFQ Section
                Expanded(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment
                        .center, // Keeps vertical center alignment overall
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                          left: imageLeftPadding,
                          top: imageTopPadding, // Apply calculated top padding
                        ),
                        child: Image.asset(
                          'public/assets/images/RFQ.png',
                          width: imageSize,
                          height: imageSize,
                          fit: BoxFit.contain,
                        ),
                      ),
                      SizedBox(width: horizontalSpacing),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Request For Quote",
                              style: TextStyle(
                                fontSize: titleFontSize,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            SizedBox(height: verticalSpacingSmall),
                            Text(
                              "Looking for the best price?\nNeed a larger quantity?\nOr do you have a target price that none\nof our competitors can match?",
                              style: TextStyle(
                                fontSize: bodyFontSize,
                                color: Colors.white,
                              ),
                              // Increased maxLines to allow for the 4 lines in the string
                              maxLines: 4,
                              overflow: TextOverflow
                                  .ellipsis, // Keep this to handle overflow if it still occurs
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: RedButton(
                    label: "RFQ",
                    onPressed: () => _showRFQOverlay(context),
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
