import 'package:flutter/material.dart';
import 'Components/trial/testing.dart'; // Import the Testing page
import 'Components/common/red_button.dart'; // Import the RedButton widget

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Semikart Components',
      theme: ThemeData(
        primaryColor: Color(0xFFA51414),
        scaffoldBackgroundColor: Colors.white,
      ),
      home: TestContainer(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class TestContainer extends StatelessWidget {
  const TestContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: RedButton(
          label: "Testing", // Button label
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const ButtonNavigationPage()), // Navigate to testing.dart
            );
          },
        ),
      ),
    );
  }
}