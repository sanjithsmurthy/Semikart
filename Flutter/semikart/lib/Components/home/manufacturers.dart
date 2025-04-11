import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart' as carousel_slider_package;

class ManufacturerCarousel extends StatelessWidget {
  final List<String> logoPaths = [
    'public/assets/images/home_page/marquee1.png',
    'public/assets/images/home_page/marquee2.png',
    'public/assets/images/home_page/marquee3.png',
    'public/assets/images/home_page/marquee4.png',
    'public/assets/images/home_page/marquee5.png',
    'public/assets/images/home_page/marquee6.png',
    'public/assets/images/home_page/marquee7.png',
    'public/assets/images/home_page/marquee8.png',
    'public/assets/images/home_page/marquee9.png',
    'public/assets/images/home_page/marquee10.png',
    'public/assets/images/home_page/marquee11.png',
    'public/assets/images/home_page/marquee12.png',
    'public/assets/images/home_page/marquee13.png',
    'public/assets/images/home_page/marquee14.png',
  ];

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // Title
        Text(
          'Manufacturers',
          style: TextStyle(
            fontSize: screenWidth * 0.05, // Dynamically scalable font size
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 10), // Spacing below the title
        // Carousel for scrolling logos
        carousel_slider_package.CarouselSlider(
          options: carousel_slider_package.CarouselOptions(
            height: 100, // Set the height of the carousel
            autoPlay: true, // Enable auto-scrolling
            autoPlayInterval: Duration(seconds: 3), // Interval between slides
            autoPlayAnimationDuration: Duration(milliseconds: 800), // Animation duration
            autoPlayCurve: Curves.easeInOut, // Scrolling curve
            enlargeCenterPage: true, // Highlight the center image
            viewportFraction: 0.3, // Fraction of the screen each image takes
          ),
          items: logoPaths.map((path) {
            return Builder(
              builder: (BuildContext context) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Image.asset(
                    path,
                    height: 80, // Set the height of each logo
                    fit: BoxFit.contain,
                    errorBuilder: (context, error, stackTrace) {
                      return Icon(Icons.broken_image, size: 80); // Fallback icon
                    },
                  ),
                );
              },
            );
          }).toList(),
        ),
      ],
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: Scaffold(
      appBar: AppBar(title: Text('Manufacturer Carousel')),
      body: Center(
        child: ManufacturerCarousel(),
      ),
    ),
   ));
}