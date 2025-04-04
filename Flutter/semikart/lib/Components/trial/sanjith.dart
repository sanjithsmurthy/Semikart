import 'package:flutter/material.dart';
import '../common/bottom_bar.dart' as BottomBar; // Alias for bottom_bar.dart
import '../common/header.dart'; // Import the Header for the AppBar
import '../common/search_failed.dart'; // Import the search_failed.dart file
import '../common/red_button.dart'; // Import the RedButton component
import '../common/forgot_password.dart'; // Import the ForgotPasswordButton component
import '../rfq_bom/add_item_manually.dart'; // Import the DynamicTable component
import '../common/signinwith_google.dart'; // Import the SignInWithGoogleButton component
import '../cart/cart_item.dart'; // Import the updated CartItem widget

class TestLayoutSanjith extends StatelessWidget {
  const TestLayoutSanjith({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Header(), // Use the updated Header as the AppBar
      body: LayoutBuilder(
        builder: (context, constraints) {
          final screenWidth = constraints.maxWidth;
          final padding = screenWidth * 0.05; // Dynamic padding based on screen width

          return SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: padding, vertical: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // SearchFailed Component
                  const SearchFailed(),
                  const SizedBox(height: 20), // Add spacing between components
                  // White Button Variant
                  RedButton(
                    label: "Go Back",
                    onPressed: () {
                      // Add your button action here
                      print("White button pressed");
                    },
                    isWhiteButton: true, // Trigger the white button variant
                    width: screenWidth * 0.5, // Button width is 50% of screen width
                  ),
                  const SizedBox(height: 20), // Add spacing between components
                  // Forgot Password Button
                  ForgotPasswordButton(
                    label: "Forgot Password", // Customizable text
                    onPressed: () {
                      // Add your navigation or action here
                      print("Forgot Password button pressed");
                    },
                  ),
                  const SizedBox(height: 20), // Add spacing between components
                  // Don't Have an Account Button
                  ForgotPasswordButton(
                    label: "Don't have an account", // Customizable text
                    onPressed: () {
                      // Add your navigation or action here
                      print("Don't have an account button pressed");
                    },
                  ),
                  const SizedBox(height: 20), // Add spacing between components
                  // Sign In with Google Button (Two-Line Text)
                  SignInWithGoogleButton(
                    onPressed: () {
                      // Add your Google sign-in logic here
                      print("Sign in with Google button (Two-Line) pressed");
                    },
                    isTwoLine: true, // Enable two-line text
                  ),
                  const SizedBox(height: 20), // Add spacing between components
                  // Sign In with Google Button (Single-Line Text)
                  SignInWithGoogleButton(
                    onPressed: () {
                      // Add your Google sign-in logic here
                      print("Sign in with Google button (Single-Line) pressed");
                    },
                    isTwoLine: false, // Enable single-line text
                  ),
                  const SizedBox(height: 20), // Add spacing between components
                  // Updated CartItem Component
                  CartItem(
                    mfrPartNumber: "LSP4-480",
                    customerPartNumber: "Customer Part Number", // Updated variable name
                    description: "LED Protection Devices, 120VAC-480VAC, 10kA/20kA, Compact Design",
                    vendorPartNumber: "837-LSP4-480",
                    manufacturer: "Hatch Lighting",
                    supplier: "Mouser Electronics",
                    basicUnitPrice: 911.93,
                    finalUnitPrice: 1103.3441,
                    gstPercentage: 18.0,
                    quantity: 1,
                    onDelete: () {
                      print("Delete button pressed");
                    },
                  ),
                  const SizedBox(height: 20), // Add spacing between components
                  // DynamicTable Component
                  const DynamicTable(), // Let the table expand naturally
                ],
              ),
            ),
          );
        },
      ),
      bottomNavigationBar: BottomBar.BottomNavBar(), // Use the alias for BottomNavBar
    );
  }
}

void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: TestLayoutSanjith(),
  ));
}
