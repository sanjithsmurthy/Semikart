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
        child: SingleChildScrollView( // *** This makes the content scrollable ***
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05), // Consistent padding
            // Use ConstrainedBox to ensure the Column tries to fill at least the available screen height
            // This helps SingleChildScrollView determine if scrolling is needed.
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: availableHeight, // Minimum height is the screen height minus safe area insets
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween, // Pushes content to top and button towards bottom
                children: [
                  // --- Top Content Group ---
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: screenHeight * 0.05), // Spacing at the top

                      // Back Button
                      IconButton(
                        icon: Icon(Icons.arrow_back_ios_new, color: Color(0xFFA51414)),
                        iconSize: screenWidth * 0.06,
                        onPressed: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (context) => LoginPasswordNewScreen()),
                          );
                        },
                      ),
                      SizedBox(height: screenHeight * 0.02),

                      // Forgot Password Title
                      Text(
                        "Forgot Password",
                        style: TextStyle(
                          fontSize: screenWidth * 0.07,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.02),

                      // Instruction Text
                      Text(
                        "Enter your registered email address. You will receive a link to create a new password via email.",
                        style: TextStyle(
                          fontSize: screenWidth * 0.045,
                          fontWeight: FontWeight.w400,
                          color: Color(0xFFb6b6b6),
                          height: 1.5,
                        ),
                        textAlign: TextAlign.left,
                      ),
                      SizedBox(height: screenHeight * 0.04),

                      // Email Input Field
                      CustomTextField(
                        controller: emailController,
                        label: "Email",
                      ),
                    ],
                  ),

                  // --- Bottom Content Group ---
                  // This Column will be pushed towards the bottom by MainAxisAlignment.spaceBetween
                  Column(
                     children: [
                        SizedBox(height: screenHeight * 0.04), // Add some space above the button regardless

                        // Send Reset Link Button
                        Center(
                          child: RedButton(
                            label: "Send Reset Link",
                            width: screenWidth * 0.9,
                            height: screenHeight * 0.06,
                            onPressed: () async {
                              // Simulate checking the email in the database
                              String email = emailController.text.trim();
                              bool emailExists = _checkEmailInDatabase(email);

                              if (!emailExists) {
                                await CustomPopup.show(
                                  context: context,
                                  title: 'Email Not Found',
                                  message: "Don't have an account.",
                                  buttonText: 'SignUp',
                                  imagePath: 'public/assets/images/Alert.png',
                                ).then((_) {
                                  // Ensure context is still valid before navigating
                                  if (Navigator.canPop(context)) {
                                     Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(builder: (context) => SignUpScreen()),
                                     );
                                  }
                                });
                              } else {
                                // Ensure context is still valid before navigating
                                if (Navigator.canPop(context)) {
                                   Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(builder: (context) => ResetPasswordScreen()),
                                   );
                                }
                              }
                            },
                          ),
                        ),

                        // Add extra space at the very bottom INSIDE the scrollable area
                        // This ensures there's room to scroll the button well above the keyboard
                        SizedBox(height: screenHeight * 0.05), // Adjust as needed
                     ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Simulated function to check if the email exists in the database
  bool _checkEmailInDatabase(String email) {
    List<String> registeredEmails = ["user1@example.com", "user2@example.com", "user3@example.com"];
    return registeredEmails.contains(email);
  }
}