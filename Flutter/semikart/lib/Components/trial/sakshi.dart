import 'package:flutter/material.dart';
import '../Commons/captcha.dart'; // Import the CaptchaScreen widget

class TestLayoutSakshi extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text('Captcha Example'),
          backgroundColor: Color(0xFFA51414),
        ),
       
      ),
    );
  }
}

void main() {
  runApp(TestLayoutSakshi());
}