import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // For status bar customization
import 'login_password_new.dart'; // Import the LoginPasswordScreen
import 'signup_screen.dart'; // Import the SignUpScreen
import 'reset_password.dart'; // Import the ResetPasswordScreen
import 'custom_text_field.dart'; // Import the CustomTextField widget
import '../common/red_button.dart'; // Import the RedButton widget
import '../common/popup.dart'; // Import the CustomPopup widget

class ForgotPasswordScreen extends StatelessWidget {
  final TextEditingController emailController = TextEditingController(); // Controller for email input

  ForgotPasswordScreen({super.key}); // Add key to constructor

  @override
  Widget build(BuildContext context) {
    // Set the status bar to have a white background with black content
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.white, // White background for the status bar
      statusBarIconBrightness: Brightness.dark, // Black content for the status bar
    ));

    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    // Calculate available height excluding status bar and bottom padding (like navigation bar)
    final availableHeight = screenHeight - MediaQuery.of(context).padding.top - MediaQuery.of(context).padding.bottom;

    return Scaffold(
      backgroundColor: Colors.white, // Set the background color to white
      // resizeToAvoidBottomInset: true, // This is the default and correct behavior
      body: SafeArea( // Ensures content avoids system intrusions like notches
        child: SingleChildScrollView( // *** This makes the ENTIRE child content scrollable ***
          // Wrap content in a SizedBox to give Stack a defined height for scrolling
          child: SizedBox(
            // Ensure stack has enough height for scrolling content + positioned items
            height: availableHeight > screenHeight ? availableHeight : screenHeight,
            width: screenWidth,
            child: Stack( // Use Stack for positioning the back button
              children: [
                // --- Main Content Area (Scrollable) ---
                Padding(
                  // Apply horizontal padding to the entire content column
                  padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start, // Left-align content within the column
                    mainAxisAlignment: MainAxisAlignment.start, // Align content to the top
                    children: [
                      // --- Top Content Group ---
                      // Add space at the top to push content below the positioned back button
                      SizedBox(height: screenHeight * 0.15), // Increased height to push content down

                      // Forgot Password Title
                      Text(
                        "Forgot Password",
                        style: TextStyle(
                          fontSize: screenWidth * 0.055, // Adjusted font size
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        ),
                        textAlign: TextAlign.left, // Explicitly left align
                      ),
                      SizedBox(height: screenHeight * 0.02),

                      // Instruction Text
                      Text(
                        "Enter your registered email address. You will receive a link to create a new password via email.",
                        style: TextStyle(
                          fontSize: screenWidth * 0.032, // Adjusted font size
                          fontWeight: FontWeight.w400,
                          color: Color(0xFFb6b6b6),
                          height: 1.5,
                        ),
                        textAlign: TextAlign.left, // Explicitly left align
                      ),
                      SizedBox(height: screenHeight * 0.04),

                      // Email Input Field
                      CustomTextField(
                        controller: emailController,
                        label: "Email",
                        // Width is handled by Padding
                      ),
                      SizedBox(height: screenHeight * 0.05), // Space between input and button

                      // --- Bottom Content Group (Button) ---
                      // Button is now part of the main flow, aligned left by Column's crossAxisAlignment
                      RedButton(
                        label: "Send Reset Link",
                        width: screenWidth * 0.9, // Button takes full padded width
                        height: screenHeight * 0.06, // 6% of screen height
                        onPressed: () async {
                          // Simulate checking the email in the database
                          String email = emailController.text.trim();
                          bool emailExists = _checkEmailInDatabase(email);

                          if (!context.mounted) return;

                          if (!emailExists) {
                            await CustomPopup.show(
                              context: context,
                              title: 'Email Not Found',
                              message: "Don't have an account.",
                              buttonText: 'SignUp',
                              imagePath: 'public/assets/images/Alert.png',
                            ).then((_) {
                              if (context.mounted) {
                                 Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(builder: (context) => SignUpScreen()),
                                 );
                              }
                            });
                          } else {
                            if (context.mounted) {
                               Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(builder: (context) => ResetPasswordScreen()),
                               );
                            }
                          }
                        },
                      ),

                      // Add extra space at the very bottom INSIDE the scrollable area
                      SizedBox(height: screenHeight * 0.05), // Padding at the end
                    ],
                  ),
                ),

                // --- Positioned Back Button (Remains Fixed) ---
                Positioned(
                  left: screenWidth * 0.05, // 5% of screen width
                  top: screenHeight * 0.08,  // 8% of screen height
                  child: IconButton(
                    icon: Icon(Icons.arrow_back_ios_new, color: Color(0xFFA51414)),
                    iconSize: screenWidth * 0.06, // Example: 6% of screen width
                    onPressed: () {
                      // Ensure context is valid before navigating
                      if (Navigator.canPop(context)) {
                         Navigator.pop(context); // Use pop instead of pushReplacement for back button
                      } else {
                         // Fallback if cannot pop (e.g., first screen)
                         Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (context) => LoginPasswordNewScreen()),
                         );
                      }
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

  // Simulated function to check if the email exists in the database
  bool _checkEmailInDatabase(String email) {
    List<String> registeredEmails = ["user1@example.com", "user2@example.com", "user3@example.com", "test@test.com"];
    print("Checking email: $email");
    bool exists = registeredEmails.contains(email.toLowerCase());
    print("Email exists: $exists");
    return exists;
  }
}