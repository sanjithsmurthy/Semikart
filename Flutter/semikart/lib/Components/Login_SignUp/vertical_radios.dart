// import 'package:flutter/material.dart';
// import 'login_password.dart'; // Import the LoginPassword screen
// import 'login_otp.dart'; // Import the LoginOTP screen

// class VerticalRadios extends StatefulWidget {
//   final String initialOption; // Add a parameter to set the initial selected option

//   VerticalRadios({required this.initialOption}); // Constructor to accept the initial option

//   @override
//   _VerticalRadiosState createState() => _VerticalRadiosState();
// }

// class _VerticalRadiosState extends State<VerticalRadios> {
//   late String _selectedOption; // Track the selected option

//   @override
//   void initState() {
//     super.initState();
//     _selectedOption = widget.initialOption; // Initialize with the passed option
//   }

//   @override
//   Widget build(BuildContext context) {
//     final screenWidth = MediaQuery.of(context).size.width;
//     final screenHeight = MediaQuery.of(context).size.height;

//     // Dynamically calculate dimensions
//     final containerWidth = screenWidth * 0.9; // Adjusted width for both radios
//     final containerHeight = screenHeight * 0.2; // Adjusted height for both radios
//     final radioSize = (containerHeight * 0.2); // Adjusted size for radio buttons
//     final textFontSize = containerHeight * 0.1; // Adjusted font size

//     return Container(
//       width: containerWidth,
//       height: containerHeight,
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(containerWidth * 0.08), // 8% of container width
//       ),
//       child: Padding(
//         padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05), // Add horizontal padding
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.spaceEvenly, // Space out the radios evenly
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // First Radio (Login with Password)
//             Row(
//               children: [
//                 SizedBox(
//                   width: radioSize,
//                   height: radioSize,
//                   child: Radio<String>(
//                     value: "password", // Value for the first radio
//                     groupValue: _selectedOption, // Current selected option
//                     activeColor: Color(0xFFA51414), // Red color for selected radio
//                     onChanged: (value) {
//                       if (value != null) {
//                         setState(() {
//                           _selectedOption = value; // Update the selected radio option
//                         });
//                         // Navigate to LoginPassword screen without custom animation
//                         Navigator.pushReplacement(
//                           context,
//                           MaterialPageRoute(builder: (context) => LoginPasswordScreen()),
//                         );
//                       }
//                     },
//                   ),
//                 ),
//                 SizedBox(width: 10), // Spacing between radio and text
//                 Expanded(
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         "Login with",
//                         style: TextStyle(
                          
//                           fontSize: textFontSize,
//                           fontWeight: FontWeight.normal,
//                           color: Color(0xFF000000),
//                         ),
//                       ),
//                       Text(
//                         "Password",
//                         style: TextStyle(
                          
//                           fontSize: textFontSize,
//                           fontWeight: FontWeight.normal,
//                           color: Color(0xFF000000),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),

//             // Second Radio (Login with OTP)
//             Row(
//               children: [
//                 SizedBox(
//                   width: radioSize,
//                   height: radioSize,
//                   child: Radio<String>(
//                     value: "otp", // Value for the second radio
//                     groupValue: _selectedOption, // Current selected option
//                     activeColor: Color(0xFFA51414), // Red color for selected radio
//                     onChanged: (value) {
//                       if (value != null) {
//                         setState(() {
//                           _selectedOption = value; // Update the selected radio option
//                         });
//                         // Navigate to LoginOTP screen without custom animation
//                         Navigator.pushReplacement(
//                           context,
//                           MaterialPageRoute(builder: (context) => LoginOTPScreen()),
//                         );
//                       }
//                     },
//                   ),
//                 ),
//                 SizedBox(width: 10), // Spacing between radio and text
//                 Expanded(
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         "Login with",
//                         style: TextStyle(
                          
//                           fontSize: textFontSize,
//                           fontWeight: FontWeight.normal,
//                           color: Color(0xFF000000),
//                         ),
//                       ),
//                       Text(
//                         "OTP",
//                         style: TextStyle(
                          
//                           fontSize: textFontSize,
//                           fontWeight: FontWeight.normal,
//                           color: Color(0xFF000000),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }