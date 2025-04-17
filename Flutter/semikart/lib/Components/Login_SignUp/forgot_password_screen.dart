import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // For status bar customization
import 'login_password.dart'; // Import the LoginPasswordScreen
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
    // Still useful for determining the overall SizedBox height
    final availableHeight = screenHeight - MediaQuery.of(context).padding.top - MediaQuery.of(context).padding.bottom;

    // Define vertical positions (adjust these percentages as needed)
    final double iconTop = 0.08;
    final double titleTop = 0.15;
    final double instructionTop = 0.22;
    final double emailInputTop = 0.32; // Adjusted based on instruction text height
    final double buttonTop = 0.42; // Adjusted based on email input height

    return Scaffold(
      backgroundColor: Colors.white, // Set the background color to white
      // resizeToAvoidBottomInset: true, // This is the default and correct behavior
      body: SafeArea( // Ensures content avoids system intrusions like notches
        child: SingleChildScrollView( // *** This makes the ENTIRE child content scrollable ***
          // Wrap content in a SizedBox to give Stack a defined height for scrolling
          child: SizedBox(
            // Ensure stack has enough height for scrolling content + positioned items
            // Use a height that accommodates the lowest positioned item + some buffer
            height: screenHeight * (buttonTop + 0.15), // e.g., button top + button height + buffer
            width: screenWidth,
            child: Stack( // Use Stack for positioning all elements
              children: [

                // --- Positioned Back Button ---
                Positioned(
                  left: screenWidth * 0.01, // 5% of screen width
                  top: screenHeight * iconTop,  // Use defined variable
                  child: IconButton(
                    padding: EdgeInsets.zero,
                    constraints: BoxConstraints(),
                    icon: Icon(Icons.arrow_back_ios_new, color: Color(0xFFA51414)),
                    iconSize: screenWidth * 0.06, // Example: 6% of screen width
                    onPressed: () {
                      if (Navigator.canPop(context)) {
                         Navigator.pop(context);
                      } else {
                         Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (context) => LoginPasswordNewScreen()),
                         );
                      }
                    },
                  ),
                ),

                // --- Positioned Forgot Password Title (Below Icon) ---
                Positioned(
                  left: screenWidth * 0.05, // 5% of screen width (Same as icon)
                  top: screenHeight * titleTop,  // Use defined variable
                  child: Text(
                    "Forgot Password",
                    style: TextStyle(
                      fontSize: screenWidth * 0.055, // Using 7% as per previous request
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),

                // --- Positioned Instruction Text ---
                Positioned(
                  left: screenWidth * 0.05, // Align with title
                  right: screenWidth * 0.05, // Allow text to wrap within padding
                  top: screenHeight * instructionTop, // Use defined variable
                  child: Text(
                    "Enter your registered email address. You will receive a link to create a new password via email.",
                    style: TextStyle(
                      fontSize: screenWidth * 0.033, // Using 4.5% as per previous request
                      fontWeight: FontWeight.w400,
                      color: Color(0xFFb6b6b6),
                      height: 1.5,
                    ),
                    textAlign: TextAlign.left, // Explicitly left align
                  ),
                ),

                // --- Positioned Email Input Field ---
                Positioned(
                  left: screenWidth * 0.05, // Align with title
                  right: screenWidth * 0.05, // Span across padded width
                  top: screenHeight * emailInputTop, // Use defined variable
                  child: CustomTextField(
                    controller: emailController,
                    label: "Email",
                    // Let CustomTextField determine its height or set explicitly if needed
                    // height: screenHeight * 0.06,
                  ),
                ),

                // --- Positioned Send Reset Link Button ---
                Positioned(
                  left: screenWidth * 0.05, // Align with title
                  right: screenWidth * 0.05, // Span across padded width
                  top: screenHeight * buttonTop, // Use defined variable
                  child: RedButton(
                    label: "Send Reset Link",
                    // Width is handled by left/right constraints
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