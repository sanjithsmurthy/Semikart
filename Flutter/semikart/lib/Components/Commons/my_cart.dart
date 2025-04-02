import 'package:flutter/material.dart';

class MyCartItem extends StatefulWidget {
  final String itemName;
  final String itemDescription;
  final VoidCallback onDelete;
  final VoidCallback onViewDetails;

  const MyCartItem({
    Key? key,
    required this.itemName,
    required this.itemDescription,
    required this.onDelete,
    required this.onViewDetails,
  }) : super(key: key);

  @override
  _MyCartItemState createState() => _MyCartItemState();
}

class _MyCartItemState extends State<MyCartItem> {
  int _quantity = 1;

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
    final containerWidth = screenWidth < 412 ? screenWidth : 412;

    return Container(
      width: containerWidth.toDouble(), // Adjust width for smaller screens
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Item image
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Center(
              child: Text(
                "No Image",
                style: TextStyle(fontSize: 10),
              ),
            ),
          ),
          const SizedBox(width: 16),
          // Item details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.itemName,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  widget.itemDescription,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    IconButton(
                      onPressed: _decrementQuantity,
                      icon: const Icon(Icons.remove),
                    ),
                    Text(
                      '$_quantity',
                      style: const TextStyle(fontSize: 16),
                    ),
                    IconButton(
                      onPressed: _incrementQuantity,
                      icon: const Icon(Icons.add),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(width: 16),
          // View Details button and Delete icon
          Column(
            children: [
              ElevatedButton(
                onPressed: widget.onViewDetails,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFA51414),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text(
                  "View Details",
                  style: TextStyle(color: Colors.white),
                ),
              ),
              const SizedBox(height: 8),
              IconButton(
                onPressed: widget.onDelete,
                icon: const Icon(Icons.delete, color: Color(0xFFA51414)),
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
  final List<Map<String, String>> _cartItems = [
    {"name": "Item 1", "description": "This is the description for item 1."},
    {"name": "Item 2", "description": "This is the description for item 2."},
    {"name": "Item 3", "description": "This is the description for item 3."},
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
            itemName: _cartItems[index]["name"]!,
            itemDescription: _cartItems[index]["description"]!,
            onDelete: () => _removeItem(index),
            onViewDetails: () => _viewDetails(_cartItems[index]["name"]!),
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