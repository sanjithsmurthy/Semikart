import 'package:flutter/material.dart';
import '../home/home_page.dart'; // Import HomePage

void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: TestLayoutSanjith(), // Set TestLayoutSanjith as the home page
  ));
}

class TestLayoutSanjith extends StatelessWidget {
  const TestLayoutSanjith({super.key});

  @override
  Widget build(BuildContext context) {
    return HomePage(); // Directly use HomePage as the body
  }
}
