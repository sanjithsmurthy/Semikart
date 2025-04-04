import 'package:flutter/material.dart';
import '../common/signinwith_google.dart'; // Import the SignInWithGoogleButton widget
import '../common/vertical_radios.dart'; // Import the VerticalRadios widget
import '../common/custom_text_field.dart'; // Import the CustomTextField widget
import '../common/password_text_field.dart'; // Import the PasswordTextField widget
import '../common/forgot_password.dart'; // Import the ForgotPasswordButton widget
import '../common/red_button.dart'; // Import the RedButton widget
import 'LoginOTP.dart'; // Import the LoginOTP page

class TestLayoutSanjana extends StatefulWidget {
  const TestLayoutSanjana({super.key});

  @override
  State<TestLayoutSanjana> createState() => _TestLayoutSanjanaState();
}

class _TestLayoutSanjanaState extends State<TestLayoutSanjana> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Component Testing',
          style: TextStyle(fontFamily: 'Product Sans'),
        ),
        backgroundColor: Color(0xFFA51414),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Other components...

              SizedBox(height: 32),
              GestureDetector(
                onTap: () {
                  // Navigate to the LoginPasswordScreen
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => LoginPasswordScreen(),
                    ),
                  );
                },
                child: Text(
                  'LoginPassword Page',
                  style: TextStyle(
                    fontSize: 18,
                    fontFamily: 'Product Sans',
                    color: Colors.blue, // Blue color to indicate it's clickable
                    decoration: TextDecoration.underline, // Underline for clickable text
                  ),
                ),
              ),
              SizedBox(height: 32), // Add spacing after the text

              // Other components...
            ],
          ),
        ),
      ),
    );
  }
}

class LoginPasswordScreen extends StatefulWidget {
  @override
  _LoginPasswordScreenState createState() => _LoginPasswordScreenState();
}

class _LoginPasswordScreenState extends State<LoginPasswordScreen> {
  int selectedRadio = 1; // Default selected radio button

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title
            Text(
              'Login with Password',
              style: TextStyle(
                fontSize: 24,
                fontFamily: 'Product Sans',
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 16),

            // Radio Buttons
            Row(
              children: [
                // Radio 1
                Radio(
                  value: 1,
                  groupValue: selectedRadio,
                  onChanged: (value) {
                    setState(() {
                      selectedRadio = value as int;
                    });
                  },
                ),
                Text(
                  'Login with Password',
                  style: TextStyle(
                    fontSize: 16,
                    fontFamily: 'Product Sans',
                  ),
                ),

                // Radio 2
                Radio(
                  value: 2,
                  groupValue: selectedRadio,
                  onChanged: (value) {
                    setState(() {
                      selectedRadio = value as int;

                      // Navigate to LoginOTP page when Radio 2 is selected
                      if (selectedRadio == 2) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => LoginOTPScreen(), // Navigate to LoginOTP
                          ),
                        );
                      }
                    });
                  },
                ),
                Text(
                  'Login with OTP',
                  style: TextStyle(
                    fontSize: 16,
                    fontFamily: 'Product Sans',
                  ),
                ),
              ],
            ),

            // Other UI elements (e.g., password field, login button)
            SizedBox(height: 32),
            TextField(
              decoration: InputDecoration(
                labelText: "Password",
                border: OutlineInputBorder(),
              ),
              obscureText: true,
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // Handle login with password
                print('Login with Password');
              },
              child: Text('Login'),
            ),
          ],
        ),
      ),
    );
  }
}