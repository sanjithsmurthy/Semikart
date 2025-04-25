import 'package:flutter/material.dart';
import '../common/search_bar.dart' as custom_search; // Import the SearchBar widget
import '../common/red_button.dart'; // Import the RedButton widget
import '../rfq_bom/rfq_full.dart'; // Import the RFQFullPage widget

class ProductsHeaderContent extends StatelessWidget {
  const ProductsHeaderContent({super.key});

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
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Material(
      color: Colors.white, // Set the background color to white
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Heading
            Container(
              padding: EdgeInsets.all(screenWidth * 0.01),
              child: Text(
                'Electronic Components Categories Line Card',
                style: TextStyle(
                  color: const Color(0xFFA51414), // Red color (A51414)
                  fontSize: screenHeight * 0.019,
                  fontWeight: FontWeight.bold, // Font size 25px
                ),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(height: screenHeight * 0.008), // Add spacing before the search bar

            // Red Button
            Center(
              child: RedButton(
                label: 'Request for Quote (RFQ)',
                onPressed: () => _showRFQOverlay(context), // Show the full-screen overlay
                width: screenWidth * 0.5, // Adjust width as needed
                height: screenHeight * 0.05, // Adjust height as needed
              ),
            ),
          ],
        ),
      ),
    );
  }
}

