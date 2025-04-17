import 'package:flutter/material.dart';
import '../common/search_bar.dart'; // Alias the custom SearchBar widget

class ProductSearch extends StatelessWidget {
  const ProductSearch({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController searchController = TextEditingController();

    return Scaffold(
      backgroundColor: Colors.grey[200], // Light grey background for the app
      body: Center(
        child: Container(
          width: MediaQuery.of(context).size.width * 0.9, // 90% of screen width
          height: MediaQuery.of(context).size.height * 0.9, // 90% of screen height
          decoration: BoxDecoration(
            color: Colors.white, // White background for the container
            borderRadius: BorderRadius.circular(30), // Rounded corners
          ),
          child: Stack(
            children: [
              Positioned(
                left: 23, // 23 pixels from the left
                top: 80, // 80 pixels from the top
                right: 23, // Ensure the search bar scales dynamically
                child: custom.SearchBar(
                  searchController: searchController, // Pass the controller
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}