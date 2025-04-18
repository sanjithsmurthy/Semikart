// import 'package:flutter/material.dart';
// import '../common/grey_text_box.dart'; // Import the GreyTextBox component
// import '../common/red_button.dart'; // Import the RedButton component

// class ShareCart extends StatelessWidget {
//   final String cartName;
//   final String accessId;
//   final VoidCallback onShare;

//   const ShareCart({
//     Key? key,
//     required this.cartName,
//     required this.accessId,
//     required this.onShare,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     // Get screen dimensions
//     final screenWidth = MediaQuery.of(context).size.width;

//     // Dynamically calculate font sizes and spacing
//     final titleFontSize = screenWidth * 0.045; // Dynamic font size for titles
//     final textFontSize = screenWidth * 0.033; // Dynamic font size for text
//     final spacing = screenWidth * 0.02; // Dynamic spacing
//     final buttonWidth = screenWidth * 0.25; // Dynamic button width

//     // Controllers for GreyTextBox
//     final cartNameController = TextEditingController(text: cartName);
//     final accessIdController = TextEditingController(text: accessId);

//     return Padding(
//       padding: EdgeInsets.all(spacing * 2), // Add padding around the component
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           // Cart Name Label
//           // Text(
//           //   "Cart Name",
//           //   style: TextStyle(
//           //     fontSize: titleFontSize,
//           //     fontWeight: FontWeight.bold,
//           //     color: Colors.black,
//           //   ),
//           // ),
//           //SizedBox(height: spacing),
//           // Cart Name TextBox
//           GreyTextBox(
//             nameController: cartNameController,
//             text: "Cart Name",
//             backgroundColor: const Color(0xFFE4E8EC), // Grey background
//           ),
//           SizedBox(height: spacing * 2),
//           // Access ID Label
//           // Text(
//           //   "Access Id:",
//           //   style: TextStyle(
//           //     fontSize: titleFontSize,
//           //     fontWeight: FontWeight.bold,
//           //     color: Colors.black,
//           //   ),
//           // ),w
//           //SizedBox(height: spacing),
//           // Access ID TextBox and Share Button
//           Row(
//             children: [
//               // Access ID TextBox
//               Expanded(
//                 child: GreyTextBox(
//                   nameController: accessIdController,
//                   text: "Access Id",
//                   backgroundColor: const Color(0xFFE4E8EC), // Grey background
//                 ),
//               ),
//               SizedBox(width: spacing),
//               // Share Button
//               SizedBox(
//                 width: buttonWidth,
//                 child: RedButton(
//                   label: "Share",
//                   fontWeight: FontWeight.bold,
//                   onPressed: onShare,
//                   height: screenWidth * 0.1,
                  
                  
//                 ),
//               ),
//             ],
//           ),
//           SizedBox(height: spacing * 2),
//           // Disclaimer Text
//           Text(
//             "* Final Unit Price is inclusive of Indian custom duty, International Freight, Insurance, Handling fees and other charges",
//             style: TextStyle(
//               fontSize: textFontSize,
//               color: const Color(0xFFA51414), // Red color
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }