import 'package:flutter/material.dart';
import '../../app_navigator.dart';
import 'capsule.dart';
import '../common/red_button.dart';
import '../../base_scaffold.dart';

class PopularCategoriesGrid extends StatelessWidget {
  const PopularCategoriesGrid({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final crossAxisCount = screenWidth > 600 ? 4 : 2;
    final crossAxisSpacing = screenWidth * 0.04;
    final mainAxisSpacing = screenWidth * 0.04;

    final categories = [
      {'label': 'Connectors', 'imagePath': 'public/assets/icon/connectors.ico'},
      {'label': 'Optoelectronics', 'imagePath': 'public/assets/icon/optoelectronics.ico'},
      {'label': 'Semiconductors', 'imagePath': 'public/assets/icon/semiconductors.ico'},
      {'label': 'Electro-\nmechanical', 'imagePath': 'public/assets/icon/electromechanical.ico'},
      {'label': 'Enclosures', 'imagePath': 'public/assets/icon/enclosures.ico'},
      {'label': 'Engineering \nDevelopment', 'imagePath': 'public/assets/icon/engineering_development.ico'},
      {'label': 'Industrial \nAutomation', 'imagePath': 'public/assets/icon/industrial_automation.ico'},
      {'label': 'Ciruit Protection', 'imagePath': 'public/assets/icon/circuit_protection.ico'},
      {'label': 'Passive \nComponents', 'imagePath': 'public/assets/icon/passive_components.ico'},
      {'label': 'Sensors', 'imagePath': 'public/assets/icon/sensors.ico'},
      {'label': 'Cables & \nWire', 'imagePath': 'public/assets/icon/wire_and_cable.ico'},
      {'label': 'Embeded \nSolutions', 'imagePath': 'public/assets/icon/embeded_solutions.ico'},
    ];

    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.04),
          child: GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: crossAxisCount,
              crossAxisSpacing: crossAxisSpacing,
              mainAxisSpacing: mainAxisSpacing,
              childAspectRatio: 2.5,
            ),
            itemCount: categories.length,
            itemBuilder: (context, index) {
              final category = categories[index];
              return Capsule(
                label: category['label']!,
                imagePath: category['imagePath']!,
                onTap: () {
                        AppNavigator.openProductsL1FromAnywhere();
},

              );
            },
          ),
        ),
        SizedBox(height: screenWidth * 0.1),
        RedButton(
          label: 'View All',
          onPressed: () {
            AppNavigator.openProductsL1FromAnywhere();
          },


          isWhiteButton: true,
          width: screenWidth * 0.23,
          height: screenWidth * 0.11,
          fontSize: screenWidth * 0.035,
        ),
      ],
    );
  }
}
