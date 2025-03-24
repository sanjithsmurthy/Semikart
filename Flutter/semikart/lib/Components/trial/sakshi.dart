import 'package:flutter/material.dart';
// Import the CaptchaScreen widget

class TestLayoutSakshi extends StatelessWidget {
  const TestLayoutSakshi({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text('Captcha Example'),
          backgroundColor: Color(0xFFA51414),
        ),
        // body: CaptchaScreen(),
      ),
    );
  }
}

void main() {
  runApp(TestLayoutSakshi());
}