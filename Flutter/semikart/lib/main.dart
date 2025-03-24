import 'package:flutter/material.dart';
import 'Components/trial/sakshi.dart';
import 'Components/trial/sanjana.dart';
import 'Components/trial/sanjith.dart';
import 'Components/trial/soma.dart';
import 'Components/fullscreen/white.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Semikart Components',
      theme: ThemeData(
        primaryColor: Color(0xFFA51414),
      ),
      home: TestContainer(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class TestContainer extends StatefulWidget {
  @override
  State<TestContainer> createState() => _TestContainerState();
}

class _TestContainerState extends State<TestContainer> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    WhiteScreen(child: Container()), // Blank WhiteScreen
    WhiteScreen(child: TestLayoutSakshi()),
    WhiteScreen(child: TestLayoutSanjana()),
    WhiteScreen(child: TestLayoutSanjith()),
    WhiteScreen(child: TestLayoutSoma()),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        selectedItemColor: Color(0xFFA51414),
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed, // Add this to show all items
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.crop_square),
            label: 'White',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Sakshi',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Sanjana',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Sanjith',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Soma',
          ),
        ],
      ),
    );
  }
}