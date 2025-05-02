// import 'package:flutter/material.dart';
// import 'l1_tile.dart'; // Import the L1Tile widget
// import 'l2_dynamicpage.dart'; // Import the L2DynamicComponent

// class Productsonerow extends StatelessWidget {
//   final Map<String, String> category1;
//   final Map<String, String>? category2; // Make category2 optional

//   const Productsonerow({
//     super.key,
//     required this.category1,
//     this.category2, // Add category2 to constructor
//   });

//   @override
//   Widget build(BuildContext context) {
//     final screenWidth = MediaQuery.of(context).size.width;
//     final screenHeight = MediaQuery.of(context).size.height;

//     // Example L2 items for each L1 category (replace with API data later)
//     final Map<String, List<String>> l2Categories = {
//       "L1 Category 1": ["L2 Item 1", "L2 Item 2", "L2 Item 3"],
//       "L1 Category 2": ["L2 Item A", "L2 Item B", "L2 Item C"],
//     };

//     const Color dividerColor = Color(0xFFA51414); // Red color

//     return Column(
//       mainAxisSize: MainAxisSize.min, // Take minimum vertical space
//       children: [
//         IntrinsicHeight(
//           child: Row(
//             crossAxisAlignment: CrossAxisAlignment.stretch, // Stretch children vertically
//             children: [
//               // First L1 Tile
//               Expanded(
//                 child: L1Tile(
//                   iconPath: category1["icon"]!,
//                   text: category1["name"]!,
//                   onTap: () {
//                     // Navigate to L2DynamicComponent for the first category
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (context) => L2DynamicComponent(
//                           l1CategoryId: category1["id"]!,
//                           l1CategoryName: category1["name"]!,
//                           l1CategoryIcon: category1["icon"]!,
//                            // Pass L2 items for category1
//                         ),
//                       ),
//                     );
//                   },
//                 ),
//               ),
//               // Vertical Divider (Only show if category2 exists)
//               if (category2 != null)
//                 Container(
//                   child: VerticalDivider(
//                     color: dividerColor,
//                     thickness: screenWidth * 0.0025, // Dynamically scale thickness (~1px)
//                     width: screenWidth * 0.0025, // Dynamically scale width (~1px)
//                   ),
//                 ),
//               // Second L1 Tile (Only show if category2 exists)
//               if (category2 != null)
//                 Expanded(
//                   child: L1Tile(
//                     iconPath: category2!["icon"]!,
//                     text: category2!["name"]!,
//                     onTap: () {
//                       // Navigate to L2DynamicComponent for the second category
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                           builder: (context) =>L2DynamicComponent(
//                           l1CategoryId: category1["id"]!,
//                           l1CategoryName: category1["name"]!,
//                           l1CategoryIcon: category1["icon"]!,
//                            // Pass L2 items for category1
//                         ),
//                         ),
//                       );
//                     },
//                   ),
//                 )
//               else
//                 const Expanded(child: SizedBox()), // Placeholder if no second category
//             ],
//           ),
//         ),
//         // Bottom Horizontal Divider (Always add this one below the row)
//         Divider(
//           color: dividerColor,
//           thickness: screenHeight * 0.001, // Dynamically scale thickness (~1px)
//           height: screenHeight * 0.001, // Ensure divider takes minimal space
//         ),
//       ],
//     );
//   }
// }
