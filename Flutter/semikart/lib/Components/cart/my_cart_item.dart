import 'package:flutter/material.dart';
import '../common/red_button.dart'; // Import the RedButton widget

class MyCartItem extends StatefulWidget {
  final String imagePath; // Updated to use imagePath
  final String title;
  final String description;
  final double price;
  final VoidCallback onDelete;
  final VoidCallback onViewDetails;

  const MyCartItem({
    Key? key,
    required this.imagePath, // Updated to use imagePath
    required this.title,
    required this.description,
    required this.price,
    required this.onDelete,
    required this.onViewDetails,
  }) : super(key: key);

  @override
  _MyCartItemState createState() => _MyCartItemState();
}

class _MyCartItemState extends State<MyCartItem> {
  int _quantity = 1;

  void _updateQuantity(String value) {
    final int? newQuantity = int.tryParse(value);
    if (newQuantity != null && newQuantity > 0) {
      setState(() {
        _quantity = newQuantity;
      });
    }
  }

  void _incrementQuantity() {
    setState(() {
      _quantity++;
    });
  }

  void _decrementQuantity() {
    if (_quantity > 1) {
      setState(() {
        _quantity--;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final imageWidth = screenWidth * 0.2; // Dynamically scale image size
    final buttonSize = screenWidth * 0.08; // Dynamically scale button size
    final textFieldWidth = screenWidth * 0.1; // Dynamically scale text field width
    final redButtonWidth = screenWidth * 0.25; // Dynamically scale the width of the "View Details" button
    final spacing = screenWidth * 0.02; // Dynamically scale spacing

    return Container(
      margin: EdgeInsets.symmetric(vertical: spacing),
      padding: EdgeInsets.all(spacing),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(screenWidth * 0.02), // Dynamic border radius
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Stack(
        children: [
          // Delete Button
          Positioned(
            top: 0,
            right: 0,
            child: IconButton(
              onPressed: widget.onDelete,
              icon: const Icon(Icons.delete, color: Color(0xFFA51414)),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Product Image
                  Container(
                    width: imageWidth,
                    height: imageWidth,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(screenWidth * 0.02),
                      image: DecorationImage(
                        image: AssetImage(widget.imagePath), // Use AssetImage for local images
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  SizedBox(width: spacing),
                  // Product Details
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.title,
                          style: TextStyle(
                            fontSize: screenWidth * 0.04, // Dynamic font size
                            fontWeight: FontWeight.bold,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis, // Truncate long text
                        ),
                        SizedBox(height: spacing * 0.5),
                        Text(
                          widget.description,
                          style: TextStyle(
                            fontSize: screenWidth * 0.035, // Dynamic font size
                            color: Colors.grey,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis, // Truncate long text
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: spacing),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Quantity Updater
                  Row(
                    children: [
                      // Decrease Button
                      SizedBox(
                        width: buttonSize,
                        height: buttonSize,
                        child: IconButton(
                          onPressed: _decrementQuantity,
                          icon: const Icon(Icons.remove, color: Color(0xFFA51414)),
                        ),
                      ),
                      // Editable Quantity Field
                      SizedBox(
                        width: textFieldWidth,
                        child: TextField(
                          textAlign: TextAlign.center,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            contentPadding: EdgeInsets.symmetric(vertical: 4),
                          ),
                          controller: TextEditingController(text: '$_quantity'),
                          onSubmitted: _updateQuantity,
                        ),
                      ),
                      // Increase Button
                      SizedBox(
                        width: buttonSize,
                        height: buttonSize,
                        child: IconButton(
                          onPressed: _incrementQuantity,
                          icon: const Icon(Icons.add, color: Color(0xFFA51414)),
                        ),
                      ),
                    ],
                  ),
                  // Price
                  Text(
                    '₹${widget.price.toStringAsFixed(2)}',
                    style: TextStyle(
                      fontSize: screenWidth * 0.04, // Dynamic font size
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  // View Details Button (Using RedButton)
                  SizedBox(
                    width: redButtonWidth,
                    child: RedButton(
                      label: "Details",
                      onPressed: widget.onViewDetails,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class MyCart extends StatefulWidget {
  const MyCart({Key? key}) : super(key: key);

  @override
  _MyCartState createState() => _MyCartState();
}

class _MyCartState extends State<MyCart> {
  final List<Map<String, dynamic>> _cartItems = [
    {
      "imagePath": "public/assets/images/products/noImageFound.png", // Correct asset path
      "title": "Item 1",
      "description": "This is the description for item 1.",
      "price": 10.0
    },
    {
      "imagePath": "public/assets/images/products/noImageFound.png", // Correct asset path
      "title": "Item 2",
      "description": "This is the description for item 2.",
      "price": 20.0
    },
    {
      "imagePath": "public/assets/images/products/noImageFound.png", // Correct asset path
      "title": "Item 3",
      "description": "This is the description for item 3.",
      "price": 30.0
    },
  ];

  void _removeItem(int index) {
    setState(() {
      _cartItems.removeAt(index);
    });
  }

  void _viewDetails(String itemName) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ItemDetailsPage(itemName: itemName),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("My Cart"),
      ),
      body: ListView.builder(
        itemCount: _cartItems.length,
        itemBuilder: (context, index) {
          return MyCartItem(
            imagePath: _cartItems[index]["imagePath"], // Pass the correct asset path
            title: _cartItems[index]["title"],
            description: _cartItems[index]["description"],
            price: _cartItems[index]["price"],
            onDelete: () => _removeItem(index),
            onViewDetails: () => _viewDetails(_cartItems[index]["title"]),
          );
        },
      ),
    );
  }
}

class ItemDetailsPage extends StatelessWidget {
  final String itemName;

  const ItemDetailsPage({Key? key, required this.itemName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(itemName),
      ),
      body: Center(
        child: Text(
          "Details of $itemName",
          style: const TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}