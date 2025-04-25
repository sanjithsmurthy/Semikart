import 'package:flutter/material.dart';
import 'red_button.dart'; // Import RedButton
import 'track_order.dart'; // Import TrackOrder
import '../../app_navigator.dart'; // Import AppNavigator for navigation

class CongratulationsScreen extends StatelessWidget {
  const CongratulationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Get current screen dimensions
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    // Base dimensions (your reference design size)
    const baseHeight = 917.0;
    const baseWidth = 412.0;

    // Calculate scaling factors based on the current screen size vs the base size
    final heightScale = screenHeight / baseHeight;
    final widthScale = screenWidth / baseWidth;

    // Helper function to scale font sizes (using width scale for better aspect ratio)
    double scaleFont(double fontSize) => fontSize * widthScale;

    // Helper function to scale heights
    double scaleHeight(double height) => height * heightScale;

    // Helper function to scale widths
    double scaleWidth(double width) => width * widthScale;

    return Scaffold(
      backgroundColor: Colors.white, // Set the background color to white
      body: Center(
        child: SizedBox(
          width: screenWidth, // Use full screen width
          height: screenHeight, // Use full screen height
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
            child: Transform.translate(
              offset: const Offset(0, -20.0), // Move content up by 20 logical pixels
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Icon container
                  Container(
                    width: scaleWidth(164),
                    height: scaleWidth(164),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFB8B8), // Light red background
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Container(
                        width: scaleWidth(102.5),
                        height: scaleWidth(102.5),
                        decoration: const BoxDecoration(
                          color: Color(0xFFA51414), // Dark red background
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.check, // Success check icon
                          color: Colors.white,
                          size: scaleWidth(50),
                        ),
                      ),
                    ),
                  ),

                  SizedBox(height: scaleHeight(56)),

                  // "Congratulations!!!" Text
                  Text(
                    "Congratulations!!!",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: scaleFont(24),
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),

                  SizedBox(height: scaleHeight(10)),

                  // Description Text
                  Text(
                    "Your order has been taken and is \nbeing attended to",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: scaleFont(18),
                      color: Colors.grey,
                    ),
                  ),

                  SizedBox(height: scaleHeight(56)),

                  // "Track Order" Button
                  SizedBox(
                    width: scaleWidth(141),
                    height: scaleHeight(56),
                    child: RedButton(
                      label: "Track order",
                      fontSize: scaleFont(16),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => TrackOrder(
                              steps: OrderStep.getDefaultSteps(),
                              currentStep: 3,
                            ),
                          ),
                        );
                      },
                    ),
                  ),

                  SizedBox(height: scaleHeight(25)),

                  // "Continue Shopping" Button
                  SizedBox(
                    width: scaleWidth(193),
                    height: scaleHeight(56),
                    child: RedButton(
                      label: "Continue shopping",
                      fontSize: scaleFont(16),
                      isWhiteButton: true,
                      onPressed: () {
                        // Navigate to Products L1 Page in the Products tab
                        AppNavigator.openProductsRootPage();
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
