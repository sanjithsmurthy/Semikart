import 'package:flutter/material.dart';
import 'l1_tile.dart'; // Import the L1Tile widget

class Productsonerow extends StatelessWidget {
  final Map<String, String> category1;
  final Map<String, String>? category2; // Make category2 optional

  const Productsonerow({
    super.key,
    required this.category1,
    this.category2, // Add category2 to constructor
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    // Dynamic scaling for dividers based on reference size (412x917)
    const double refWidth = 412.0;
    const double refHeight = 917.0;
    // const double refVerticalDividerHeight = 113.0; // Match tile container height estimate - Might not be needed if using IntrinsicHeight
    const double refHorizontalDividerHeight = 1.0; // Thickness
    const double refVerticalDividerWidth = 1.0; // Thickness

    // final double dynamicVerticalDividerHeight = screenHeight * (refVerticalDividerHeight / refHeight);
    final double dynamicHorizontalDividerThickness = screenHeight * (refHorizontalDividerHeight / refHeight); // Scale thickness slightly
    final double dynamicVerticalDividerThickness = screenWidth * (refVerticalDividerWidth / refWidth); // Scale thickness slightly

    const Color dividerColor = Color(0xFFA51414); // Red color

    return Column(
      mainAxisSize: MainAxisSize.min, // Take minimum vertical space
      children: [
        // Top Horizontal Divider (Only needed if it's not the very first row, handle in parent ListView)
        // Divider(
        //   color: dividerColor,
        //   thickness: dynamicHorizontalDividerThickness,
        //   height: dynamicHorizontalDividerThickness, // Ensure divider takes minimal space
        // ),

        // Row containing the tiles and vertical divider
        IntrinsicHeight( // Ensure Row children have the same height
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch, // Stretch children vertically
            children: [
              // First L1 Tile
              Expanded(
                child: L1Tile(
                  iconPath: category1["icon"]!,
                  text: category1["name"]!,
                ),
              ),
              // Vertical Divider (Only show if category2 exists)
              if (category2 != null)
                Container(
                  // Use Container to control height if VerticalDivider alone isn't sufficient
                  // height: dynamicVerticalDividerHeight, // Set height explicitly if needed
                  child: VerticalDivider(
                    color: dividerColor,
                    thickness: dynamicVerticalDividerThickness,
                    width: dynamicVerticalDividerThickness, // Ensure divider takes minimal space
                    // indent: screenHeight * 0.01, // Optional dynamic indent
                    // endIndent: screenHeight * 0.01, // Optional dynamic endIndent
                  ),
                ),
              // Second L1 Tile (Only show if category2 exists)
              if (category2 != null)
                Expanded(
                  child: L1Tile(
                    iconPath: category2!["icon"]!,
                    text: category2!["name"]!,
                  ),
                )
              else
                const Expanded(child: SizedBox()), // Placeholder if no second category
            ],
          ),
        ),
        // Bottom Horizontal Divider (Always add this one below the row)
        Divider(
          color: dividerColor,
          thickness: dynamicHorizontalDividerThickness,
          height: dynamicHorizontalDividerThickness, // Ensure divider takes minimal space
        ),
      ],
    );
  }
}
