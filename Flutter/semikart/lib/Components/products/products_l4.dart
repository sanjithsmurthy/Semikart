import 'package:flutter/material.dart';
import 'l4_tile.dart'; // Import the ProductTileL4 component
import '../products/products_static.dart'; // Import the ProductsHeaderContent widget

// Define a simple data structure for product information
class ProductDataL4 {
  final String imageUrl;
  final String productName;
  final String description;
  final String category;
  final String mfrPartNumber;
  final String manufacturer;
  final String lifeCycle;

  ProductDataL4({
    required this.imageUrl,
    required this.productName,
    required this.description,
    required this.category,
    required this.mfrPartNumber,
    required this.manufacturer,
    required this.lifeCycle,
  });
}

class ProductListL4 extends StatelessWidget {
  final List<ProductDataL4> products;
  final Function(ProductDataL4 product) onViewDetails; // Callback function

  const ProductListL4({
    super.key,
    required this.products,
    required this.onViewDetails,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: products.length,
      itemBuilder: (context, index) {
        final product = products[index];
        return ProductTileL4(
          imageUrl: product.imageUrl,
          productName: product.productName,
          description: product.description,
          category: product.category,
          mfrPartNumber: product.mfrPartNumber,
          manufacturer: product.manufacturer,
          lifeCycle: product.lifeCycle,
          onViewDetailsPressed: () {
            onViewDetails(product); // Call the callback with product data
          },
        );
      },
    );
  }
}

// Example Usage (You would typically place this in a screen widget)
class ProductListScreenExample extends StatelessWidget {
  ProductListScreenExample({super.key});

  // Sample data - replace with your actual data source
  final List<ProductDataL4> sampleProducts = [
    ProductDataL4(
      imageUrl: 'https://www.sepa-europe.com/fileadmin/_processed_/csm_HY45T05A-830-BLI_01_01_01_991258612a.png', // Replace with actual URL
      productName: 'HY45T05A-830-BLI',
      description: 'Fan: DC; blower; 5VDC; 45x45x5mm; 2.3m3/h; 27dBA; MagFix; 5200rpm',
      category: 'DC5V Fans',
      mfrPartNumber: 'HY45T05A-830-BLI',
      manufacturer: 'SEPA Europe GMBH',
      lifeCycle: 'NEW',
    ),
    ProductDataL4(
      imageUrl: 'https://via.placeholder.com/60', // Placeholder image
      productName: 'Another Product',
      description: 'Description for another product goes here.',
      category: 'Category B',
      mfrPartNumber: 'XYZ-789',
      manufacturer: 'Another Mfr Inc.',
      lifeCycle: 'Active',
    ),
    // Add more products as needed
  ];

  @override
  Widget build(BuildContext context) {
    // Removed Scaffold and AppBar, using Column structure similar to L3
    return Column(
      children: [
        // Header
        ProductsHeaderContent(),

        // List of L4 items
        Expanded(
          child: ProductListL4(
            products: sampleProducts,
            onViewDetails: (product) {
              // Handle the "View Details" button press
              // e.g., navigate to a detail screen
              print('View Details pressed for: ${product.productName}');
              // Navigator.push(context, MaterialPageRoute(builder: (context) => ProductDetailScreen(product: product)));
            },
          ),
        ),
      ],
    );
  }
}