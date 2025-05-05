import 'package:flutter/material.dart';
import '../common/search_bar.dart' as custom_search; // Import the SearchBar widget
import '../common/red_button.dart'; // Import the RedButton widget
import '../rfq_bom/rfq_full.dart'; // Import the RFQFullPage widget

class ProductsHeaderContent extends StatelessWidget {
  const ProductsHeaderContent({super.key});

  void _showRFQOverlay(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    // Define base dimensions for scaling calculations (optional, but can help maintain proportions)
    // const double baseWidth = 412.0;
    // const double baseHeight = 917.0;

    // Calculate scale factors (optional)
    // final double widthScale = screenWidth / baseWidth;
    // final double heightScale = screenHeight / baseHeight;

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
                maxHeight: screenHeight * 0.7, // 70% of screen height
                maxWidth: screenWidth * 0.9, // 90% of screen width
              ),
              padding: EdgeInsets.only(
                top: screenHeight * 0.003, // Relative top padding
                bottom: screenHeight * 0.009, // Relative bottom padding
                left: 0,
                right: 0,
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(screenWidth * 0.03), // Relative border radius
              ),
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.topRight,
                    child: Padding(
                      padding: EdgeInsets.only(
                        top: screenHeight * 0.01, // Relative top padding
                        right: screenWidth * 0.025, // Relative right padding
                      ),
                      child: IconButton(
                        icon: Icon(
                          Icons.close,
                          color: Colors.black,
                          size: screenWidth * 0.078, // Relative icon size (approx 32 on 412 width)
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
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    // Define base dimensions for scaling calculations (optional, but can help maintain proportions)
    // const double baseWidth = 412.0;
    // const double baseHeight = 917.0;

    // Calculate scale factors (optional)
    // final double widthScale = screenWidth / baseWidth;
    // final double heightScale = screenHeight / baseHeight;

    // Calculate font size relative to screen height (adjust multiplier as needed)
    // Example: Aim for ~17.5px on a 917px height screen -> 17.5 / 917 = 0.019
    final double titleFontSize = screenHeight * 0.019;

    // Calculate button dimensions relative to screen size
    final double buttonWidth = screenWidth * 0.5; // 50% of screen width
    final double buttonHeight = screenHeight * 0.05; // 5% of screen height

    // Calculate padding and spacing relative to screen size
    final double containerPadding = screenWidth * 0.02; // 2% of screen width for padding
    final double verticalSpacing = screenHeight * 0.01; // 1% of screen height for spacing

    return Material(
      color: Colors.white, // Set the background color to white
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Heading
            Container(
              padding: EdgeInsets.all(containerPadding),
              child: Text(
                'Electronic Components Categories Line Card',
                style: TextStyle(
                  color: const Color(0xFFA51414), // Red color (A51414)
                  fontSize: titleFontSize,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(height: verticalSpacing), // Add relative spacing

            // Red Button
            Center(
              child: RedButton(
                label: 'Request for Quote (RFQ)',
                onPressed: () => _showRFQOverlay(context), // Show the overlay
                width: buttonWidth, // Relative width
                height: buttonHeight, // Relative height
              ),
            ),
             SizedBox(height: verticalSpacing), // Add spacing below button if needed
          ],
        ),
      ),
    );
  }
}
