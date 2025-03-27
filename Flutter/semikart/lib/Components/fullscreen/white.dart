import 'package:flutter/material.dart';

class WhitePage extends StatelessWidget {
  const WhitePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text('White Page'),
      // ),
      body: Container(
        color: Colors.white,
        child: const Center(
          child: Text(
            'This is the White Page',
            style: TextStyle(fontSize: 18, color: Colors.black),
          ),
        ),
      ),
    );
  }
}