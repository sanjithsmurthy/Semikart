import 'package:flutter/material.dart';
import 'capsule.dart';
import '../common/red_button.dart';

class PopularCategoriesGrid extends StatelessWidget {
  final VoidCallback onViewAll;

  const PopularCategoriesGrid({
    super.key,
    required this.onViewAll,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final crossAxisCount = screenWidth > 600 ? 4 : 2; // Adjust grid columns based on screen size
    final crossAxisSpacing = screenWidth * 0.04; // Spacing between columns
    final mainAxisSpacing = screenWidth * 0.04; // Spacing between rows

    // Define the popular categories data here
    final categories = [
      {'label': 'Connectors', 'imagePath': 'public/assets/icon/connectors.ico'},
      {'label': 'Optoelectronics', 'imagePath': 'public/assets/icon/optoelectronics.ico'},
      {'label': 'Semiconductors', 'imagePath': 'public/assets/icon/semiconductors.ico'},
      {'label': 'Electro-mechanical', 'imagePath': 'public/assets/icon/electromechanical.ico'},
      {'label': 'Enclosures', 'imagePath': 'public/assets/icon/enclosures.ico'},
      {'label': 'Engineering \nDevelopment', 'imagePath': 'public/assets/icon/engineering_development.ico'},
      {'label': 'Industrial \nAutomation', 'imagePath': 'public/assets/icon/industrial_automation.ico'},
      {'label': 'Ciruit Protection', 'imagePath': 'public/assets/icon/circuit_protection.ico'},
      {'label': 'Passive Components', 'imagePath': 'public/assets/icon/passive_components.ico'},
      {'label': 'Sensors', 'imagePath': 'public/assets/icon/sensors.ico'},
      {'label': 'Cable and \nWires', 'imagePath': 'public/assets/icon/wire_and_cable.ico'},
      {'label': 'Embeded \nSolutions', 'imagePath': 'public/assets/icon/embeded_solutions.ico'},
    ];

    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.04), // 15px dynamically scalable padding
          child: GridView.builder(
            shrinkWrap: true, // Ensure the grid takes only the required space
            physics: const NeverScrollableScrollPhysics(), // Disable scrolling for the grid
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: crossAxisCount,
              crossAxisSpacing: crossAxisSpacing,
              mainAxisSpacing: mainAxisSpacing,
              childAspectRatio: 2.5, // Aspect ratio for capsules
            ),
            itemCount: categories.length,
            itemBuilder: (context, index) {
              final category = categories[index];
              return Capsule(
                label: category['label']!,
                imagePath: category['imagePath']!,
                onTap: () {
                  // Handle capsule tap
                  print('Tapped on ${category['label']}');
                },
              );
            },
          ),
        ),
        SizedBox(height: screenWidth * 0.1), // Spacing before the "View All" button
        RedButton(
          label: 'View All',
          onPressed: onViewAll,
          isWhiteButton: true,
          width: screenWidth * 0.23, // Dynamically scalable width (~86px for typical screen widths)
          height: screenWidth * 0.11, // Dynamically scalable height (~41px for typical screen widths)
          fontSize: screenWidth * 0.035, // Dynamically scalable font size (~14px for typical screen widths)
        ),
      ],
    );
  }
}