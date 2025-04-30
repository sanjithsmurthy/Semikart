import 'package:flutter/material.dart';
import '../common/red_button.dart';
import '../rfq_bom/rfq_full.dart'; // Import the RFQFullPage widget

class BomRfqCard extends StatefulWidget {
  const BomRfqCard({Key? key}) : super(key: key);

  @override
  State<BomRfqCard> createState() => _BomRfqCardState();
}

class _BomRfqCardState extends State<BomRfqCard> {
  // --- Reference Screen Dimensions ---
  // These remain static as they define the baseline for scaling
  static const double _refScreenWidth = 412.0;
  static const double _refScreenHeight = 917.0;

  // --- Helper function to scale width ---
  double scaleWidth(BuildContext context, double baseWidth) {
    // Calculates the ratio of the base width to the reference screen width
    final double widthRatio = baseWidth / _refScreenWidth;
    // Applies that ratio to the current screen width
    return MediaQuery.of(context).size.width * widthRatio;
  }

  // --- Helper function to scale height ---
  double scaleHeight(BuildContext context, double baseHeight) {
    // Calculates the ratio of the base height to the reference screen height
    // Using height scaling for vertical dimensions
    final double heightRatio = baseHeight / _refScreenHeight;
    // Applies that ratio to the current screen height
    return MediaQuery.of(context).size.height * heightRatio;

    // --- Alternative: Scale height based on width ratio (maintains aspect ratio better for some elements) ---
    // final double widthRatio = baseHeight / _refScreenWidth; // Note: using _refScreenWidth here
    // return MediaQuery.of(context).size.width * widthRatio;
  }

  // --- Helper function to scale font size (usually based on width) ---
  double scaleFontSize(BuildContext context, double baseFontSize) {
    // Calculates the ratio of the base font size to the reference screen width
    final double fontRatio = baseFontSize / _refScreenWidth;
    // Applies that ratio to the current screen width
    // Add a minimum font size clamp if desired to prevent text becoming too small
    // return (MediaQuery.of(context).size.width * fontRatio).clamp(10.0, double.infinity);
    return MediaQuery.of(context).size.width * fontRatio;
  }

  void _showRFQOverlay(BuildContext context) {
    // --- Base Dialog Dimensions (Relative to Reference Screen) ---
    const double baseDialogWidthFraction = 0.9; // 90% of screen width
    const double baseDialogHeightFraction = 0.7; // 70% of screen height
    const double baseDialogBorderRadius =
        12.0; // Base radius for reference screen
    const double baseDialogVerticalPadding =
        8.0; // Base padding for reference screen
    const double baseDialogTopPadding =
        3.0; // Base padding for reference screen
    const double baseCloseIconSize = 32.0; // Base size for reference screen
    const double baseCloseIconPadding =
        10.0; // Base padding for reference screen

    // --- Calculate Scaled Dialog Dimensions ---
    // Note: Using scaleWidth for horizontal dimensions/padding/radius and scaleHeight for vertical ones
    final double dialogMaxWidth =
        scaleWidth(context, _refScreenWidth * baseDialogWidthFraction);
    final double dialogMaxHeight =
        scaleHeight(context, _refScreenHeight * baseDialogHeightFraction);
    final double dialogBorderRadius =
        scaleWidth(context, baseDialogBorderRadius);
    final double dialogVerticalPadding =
        scaleHeight(context, baseDialogVerticalPadding);
    final double dialogTopPadding = scaleHeight(context, baseDialogTopPadding);
    final double closeIconSize = scaleWidth(context, baseCloseIconSize);
    final double closeIconPadding = scaleWidth(
        context, baseCloseIconPadding); // Scale padding based on width

    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: "Dismiss",
      barrierColor: Colors.black.withOpacity(0.5),
      transitionDuration: const Duration(milliseconds: 300),
      pageBuilder: (context, animation, secondaryAnimation) {
        return Material(
          type: MaterialType.transparency,
          child: Center(
            child: Container(
              constraints: BoxConstraints(
                maxHeight: dialogMaxHeight,
                maxWidth: dialogMaxWidth,
              ),
              padding: EdgeInsets.symmetric(
                vertical: dialogVerticalPadding,
                horizontal: 0, // No horizontal padding needed here
              ).copyWith(top: dialogTopPadding), // Specific top padding
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(
                    dialogBorderRadius), // Use scaled radius
              ),
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.topRight,
                    child: Padding(
                      // Use scaled padding values
                      padding: EdgeInsets.only(
                        top: closeIconPadding, // Use scaled padding
                        right: closeIconPadding, // Use scaled padding
                      ),
                      child: IconButton(
                        // Add constraints for better touch target sizing if needed
                        // constraints: BoxConstraints(),
                        // padding: EdgeInsets.zero,
                        icon: Icon(
                          Icons.close,
                          color: Colors.black,
                          size: closeIconSize, // Use scaled icon size
                        ),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ),
                  ),
                  const Expanded(
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
    // --- Define Base Dimensions RELATIVE to Reference Screen ---
    // These fractions determine the size/spacing on the reference screen.
    // Adjust these fractions to match your desired layout on the 412x917 screen.

    // Card Dimensions
    const double baseCardWidthFraction = 0.95; // 95% of ref width
    const double baseCardHeightFraction = 0.25 -
        0.0109; // Target height as fraction of ref height (~219px on ref)

    // Padding & Spacing (as fractions of reference dimensions)
    const double baseGeneralPaddingFraction =
        baseCardWidthFraction * 0.04; // Padding relative to card width fraction
    const double baseHorizontalSpacingFraction =
        baseCardWidthFraction * 0.03; // Spacing relative to card width fraction
    const double baseVerticalSpacingSmallFraction = baseCardHeightFraction *
        0.025; // Spacing relative to card height fraction
    const double baseImageLeftPaddingFraction = 0.025; // 2.5% of ref width
    const double baseImageBottomPaddingFraction = 0.01; // 1% of ref height

    // Element Sizes (as fractions of reference dimensions)
    const double baseImageSizeFraction = 0.195; // Target ~80px / 412px
    const double baseBorderRadiusFraction = 0.025; // Target ~10px / 412px

    // Font Sizes (as fractions of reference screen width)
    const double baseTitleFontSizeFraction = 0.044; // Target ~18px / 412px
    const double baseBodyFontSizeFraction = 0.032; // Target ~13px / 412px
    const double baseButtonFontSizeFraction = 0.029; // Target ~12px / 412px

    // Button Dimensions (as fractions of reference dimensions)
    const double baseButtonWidthFraction = 0.22; // 22% of ref width
    const double baseButtonHeightFraction = 0.04; // 4% of ref height

    // --- Calculate Scaled Dimensions for Current Screen ---
    // Use helper functions to scale the base fractions relative to the *actual* screen size

    // Scale dimensions based on width
    final cardWidth =
        scaleWidth(context, _refScreenWidth * baseCardWidthFraction);
    final generalPadding =
        scaleWidth(context, _refScreenWidth * baseGeneralPaddingFraction);
    final horizontalSpacing =
        scaleWidth(context, _refScreenWidth * baseHorizontalSpacingFraction);
    final imageSize =
        scaleWidth(context, _refScreenWidth * baseImageSizeFraction);
    final borderRadius =
        scaleWidth(context, _refScreenWidth * baseBorderRadiusFraction);
    final imageLeftPadding =
        scaleWidth(context, _refScreenWidth * baseImageLeftPaddingFraction);
    final buttonWidth =
        scaleWidth(context, _refScreenWidth * baseButtonWidthFraction);

    // Scale dimensions based on height (or width, depending on preference - see scaleHeight function)
    final cardHeight =
        scaleHeight(context, _refScreenHeight * baseCardHeightFraction);
    final verticalSpacingSmall = scaleHeight(
        context, _refScreenHeight * baseVerticalSpacingSmallFraction);
    final imageBottomPadding =
        scaleHeight(context, _refScreenHeight * baseImageBottomPaddingFraction);
    final buttonHeight =
        scaleHeight(context, _refScreenHeight * baseButtonHeightFraction);

    // Scale font sizes based on width
    final titleFontSize =
        scaleFontSize(context, _refScreenWidth * baseTitleFontSizeFraction);
    final bodyFontSize =
        scaleFontSize(context, _refScreenWidth * baseBodyFontSizeFraction);
    final buttonFontSize =
        scaleFontSize(context, _refScreenWidth * baseButtonFontSizeFraction);

    return Center(
      child: SizedBox(
        width: cardWidth,
        height: cardHeight,
        child: Card(
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius:
                BorderRadius.circular(borderRadius), // Use scaled radius
          ),
          margin: EdgeInsets.zero,
          color: Colors.transparent, // Gradient is in the Container
          clipBehavior:
              Clip.antiAlias, // Ensures gradient respects border radius
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
            padding: EdgeInsets.all(generalPadding), // Use scaled padding
            child: Column(
              children: [
                // RFQ Section
                Expanded(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                          left: imageLeftPadding, // Use scaled padding
                          bottom: imageBottomPadding, // Use scaled padding
                        ),
                        child: Image.asset(
                          'public/assets/images/RFQ.png',
                          width: imageSize, // Use scaled size
                          height: imageSize, // Use scaled size
                          fit: BoxFit.contain,
                        ),
                      ),
                      SizedBox(width: horizontalSpacing), // Use scaled spacing
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment
                              .center, // Center text vertically
                          children: [
                            Text(
                              "Request For Quote",
                              style: TextStyle(
                                fontSize: titleFontSize, // Use scaled font size
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow
                                  .ellipsis, // Prevent title wrapping
                            ),
                            SizedBox(
                                height:
                                    verticalSpacingSmall), // Use scaled spacing
                            Text(
                              "Looking for the best price?\nNeed a larger quantity?\nOr do you have a target price that none of our competitors can match?",
                              style: TextStyle(
                                fontSize: bodyFontSize, // Use scaled font size
                                color: Colors.white,
                              ),
                              maxLines:
                                  3, // Adjust max lines based on available space
                              overflow:
                                  TextOverflow.ellipsis, // Handle overflow
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                // Button Section
                Align(
                  alignment: Alignment.centerRight,
                  child: RedButton(
                    label: "RFQ",
                    onPressed: () => _showRFQOverlay(context),
                    width: buttonWidth, // Use scaled width
                    height: buttonHeight, // Use scaled height
                    isWhiteButton: true,
                    fontSize: buttonFontSize, // Use scaled font size
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
