import 'package:flutter/material.dart';
import 'red_button.dart'; // Import RedButton
import 'track_order.dart'; // Import TrackOrder

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
      body: Center( // This outer Center helps horizontally
        child: SizedBox(
          width: screenWidth, // Use full screen width
          height: screenHeight, // Use full screen height
          child: Padding(
            // Use percentage-based padding for responsiveness
            padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
            // Wrap the Column with Transform.translate to shift it up
            child: Transform.translate(
              // Changed offset from -10.0 to -20.0
              offset: const Offset(0, -20.0), // Move content up by 20 logical pixels
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center, // Keep vertical centering logic
                // crossAxisAlignment defaults to center, which is good here
                children: [
                  // Icon container scaled using widthScale to maintain aspect ratio
                  Container(
                    width: scaleWidth(164), // Dynamically scaled width
                    height: scaleWidth(164), // Dynamically scaled height (using width scale for circle)
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFB8B8), // Light red background
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Container(
                        // Inner icon container scaled using widthScale
                        width: scaleWidth(102.5), // Dynamically scaled inner circle width
                        height: scaleWidth(102.5), // Dynamically scaled inner circle height
                        decoration: const BoxDecoration(
                          color: Color(0xFFA51414), // Dark red background
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.check, // Success check icon
                          color: Colors.white,
                          // Icon size scaled using widthScale
                          size: scaleWidth(50), // Dynamically scaled icon size
                        ),
                      ),
                    ),
                  ),

                  // Scaled vertical spacing
                  SizedBox(height: scaleHeight(56)),

                  // "Congratulations!!!" Text with scaled font size
                  Text(
                    "Congratulations!!!",
                    textAlign: TextAlign.center, // Ensure text itself is centered if it wraps
                    style: TextStyle(
                      fontSize: scaleFont(24), // Dynamically scaled font size
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),

                  // Scaled vertical spacing
                  SizedBox(height: scaleHeight(10)),

                  // Description Text with scaled font size
                  Text(
                    "Your order has been taken and is \nbeing attended to",
                    textAlign: TextAlign.center, // Already centered
                    style: TextStyle(
                      fontSize: scaleFont(18), // Dynamically scaled font size
                      color: Colors.grey,
                    ),
                  ),

                  // Scaled vertical spacing
                  SizedBox(height: scaleHeight(56)),

                  // "Track Order" Button container with scaled dimensions
                  SizedBox(
                    width: scaleWidth(141), // Dynamically scaled width
                    height: scaleHeight(56), // Dynamically scaled height
                    child: RedButton(
                      label: "Track order",
                      // Font size within the button scaled
                      fontSize: scaleFont(16), // Dynamically scaled font size
                      onPressed: () {
                        // Navigate to TrackOrder widget
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => TrackOrder(
                              steps: OrderStep.getDefaultSteps(), // Pass default steps
                              currentStep: 3, // Example: Current step is "In Transit"
                            ),
                          ),
                        );
                      },
                    ),
                  ),

                  // Scaled vertical spacing
                  SizedBox(height: scaleHeight(25)),

                  // "Continue Shopping" Button container with scaled dimensions
                  SizedBox(
                    width: scaleWidth(193), // Dynamically scaled width
                    height: scaleHeight(56), // Dynamically scaled height
                    child: RedButton(
                      label: "Continue shopping",
                      // Font size within the button scaled
                      fontSize: scaleFont(16), // Dynamically scaled font size
                      isWhiteButton: true, // White button variant
                      onPressed: () {
                        // Navigate back to the previous screen
                        Navigator.pop(context);
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
