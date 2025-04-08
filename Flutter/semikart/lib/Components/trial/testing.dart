import 'package:flutter/material.dart';
import 'sakshi.dart';
import 'sanjana.dart';
import 'soma.dart';
import 'sanjith.dart';
import '../common/red_button.dart'; // Import the RedButton widget

class ButtonNavigationPage extends StatelessWidget {
  const ButtonNavigationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Navigate to Pages'),
        backgroundColor: const Color(0xFFA51414),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Button for Sakshi Page
            RedButton(
              label: "Go to Sakshi Page",
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const TestLayoutSakshi()),
                );
              },
            ),
            const SizedBox(height: 20), // Spacing between buttons

            // Button for Sanjana Page
            RedButton(
              label: "Go to Sanjana Page",
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const TestLayoutSanjana()),
                );
              },
            ),
            const SizedBox(height: 20), // Spacing between buttons

            // Button for Soma Page
            RedButton(
              label: "Go to Soma Page",
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const TestLayoutSoma()),
                );
              },
            ),
            const SizedBox(height: 20), // Spacing between buttons

            // Button for Sanjith Page
            RedButton(
              label: "Go to Sanjith Page",
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const TestLayoutSanjith()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(const MaterialApp(
    home: ButtonNavigationPage(),
    debugShowCheckedModeBanner: false,
  ));
}