import 'package:flutter/material.dart';
import 'red_button.dart'; // Import RedButton
import 'track_order.dart'; // Import TrackOrder

class CongratulationsScreen extends StatelessWidget {
  const CongratulationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Get screen dimensions
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    // Base dimensions for scaling
    const baseHeight = 917.0;
    const baseWidth = 412.0;

    // Scaling factors
    final heightScale = screenHeight / baseHeight;
    final widthScale = screenWidth / baseWidth;

    return Scaffold(
      backgroundColor: Colors.white, // Set the background color to white
      body: Center(
        child: SizedBox(
          width: screenWidth,
          height: screenHeight,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05), // 5% horizontal padding
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(height: 176 * heightScale), // Distance from the top (scaled)

                // Two layers with the success icon
                Container(
                  width: 164 * widthScale, // Dynamically scaled width
                  height: 164 * widthScale, // Dynamically scaled height
                  decoration: BoxDecoration(
                    color: const Color(0xFFFFB8B8), // Light red background
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Container(
                      width: 102.5 * widthScale, // Dynamically scaled inner circle width
                      height: 102.5 * widthScale, // Dynamically scaled inner circle height
                      decoration: const BoxDecoration(
                        color: Color(0xFFA51414), // Dark red background
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.check, // Success check icon
                        color: Colors.white,
                        size: 50 * widthScale, // Dynamically scaled icon size
                      ),
                    ),
                  ),
                ),

                SizedBox(height: 56 * heightScale), // Distance between icon and "Congratulations!!!" text (scaled)

                // "Congratulations!!!" Text
                Text(
                  "Congratulations!!!",
                  style: TextStyle(
                    fontSize: 24 * widthScale, // Dynamically scaled font size
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),

                SizedBox(height: 10 * heightScale), // Small spacing (scaled)

                // Description Text
                Text(
                  "Your order has been taken\nand is being attended to",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 18 * widthScale, // Dynamically scaled font size
                    color: Colors.grey,
                  ),
                ),

                SizedBox(height: 56 * heightScale), // Distance between description and "Track order" button (scaled)

                // "Track Order" Button
                SizedBox(
                  width: 141 * widthScale, // Dynamically scaled width
                  height: 56 * heightScale, // Dynamically scaled height
                  child: RedButton(
                    label: "Track order",
                    fontSize: 16 * widthScale, // Dynamically scaled font size
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

                SizedBox(height: 25 * heightScale), // Distance between "Track order" and "Continue shopping" button (scaled)

                // "Continue Shopping" Button (White Variant)
                SizedBox(
                  width: 193 * widthScale, // Dynamically scaled width
                  height: 56 * heightScale, // Dynamically scaled height
                  child: RedButton(
                    label: "Continue shopping",
                    fontSize: 16 * widthScale, // Dynamically scaled font size
                    isWhiteButton: true, // White button variant
                    onPressed: () {
                      Navigator.pop(context); // Navigate back to the previous screen
                    },
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
