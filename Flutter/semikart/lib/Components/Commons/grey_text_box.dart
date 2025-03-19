import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const BillingAddressScreen(),
    );
  }
}

class BillingAddressScreen extends StatelessWidget {
  const BillingAddressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController nameController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Shipping Address'),
        centerTitle: true,
        backgroundColor: Color.fromARGB(255, 255, 255, 255), // Set the app bar color
      ),
      body: Container(
        color: Colors.white, // Set the background color to white
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Name',
              style: TextStyle(
                fontSize: 13,
                color: Color(0xFFA51414), // Adjust the color as needed
              ),
            ),
            const SizedBox(height: 2),
            Container(
              width: 375,
              height: 41.54,
              decoration: BoxDecoration(
                color: Color(0xFFE4E8EC), // Grey background color
                borderRadius: BorderRadius.circular(9),
              ),
              child: TextField(
                controller: nameController,
                decoration: InputDecoration(
                  hintText: 'Username', // Placeholder text
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

