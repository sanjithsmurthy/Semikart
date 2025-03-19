import 'package:flutter/material.dart';
import 'Components/Login_SignUp/LoginOTP.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Semikart',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: LoginWelcomeScreenWidget(),
      debugShowCheckedModeBanner: false,
    );
  }
}