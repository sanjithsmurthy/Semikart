import 'package:flutter/material.dart';
import 'product_display_tile.dart'; // Assuming this is in the same directory
import 'product_supplier_tile.dart'; // Assuming this is in the same directory
// TODO: Import your Cart State Management solution (e.g., Provider, Bloc, Riverpod)
// import 'package:provider/provider.dart';
// import 'path/to/your/cart_provider.dart';
// import 'path/to/your/cart_item_model.dart'; // If you have a dedicated model

class ProductDetailsContent extends StatelessWidget {
  // TODO: Replace with actual product and supplier data models and input parameters
  const ProductDetailsContent({super.key});

  // Helper function to calculate price per unit based on quantity and slabs
  double _calculatePricePerUnit(int quantity, double initialPrice, int minQuantity, List<Map<String, dynamic>> priceSlabs) {
      if (quantity <= 0) return 0.0;

      double pricePerUnit = initialPrice / (minQuantity > 0 ? minQuantity : 1); // Default price

      // Ensure slabs are sorted by quantity ascending
      priceSlabs.sort((a, b) => (a['quantity'] as int).compareTo(b['quantity'] as int));

      // Find the best price slab for the given quantity
      for (var slab in priceSlabs.reversed) { // Iterate from highest quantity slab
          if (quantity >= (slab['quantity'] as int)) {
              pricePerUnit = slab['price'] as double;
              break; // Found the applicable slab
          }
      }
       // If quantity is less than the smallest slab quantity, use the price from the smallest slab
      if (priceSlabs.isNotEmpty && quantity < (priceSlabs.first['quantity'] as int)) {
           pricePerUnit = priceSlabs.first['price'] as double;
      }

      return pricePerUnit;
  }


  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    // Define base dimensions for scaling (adjust if needed based on design reference)
    const double baseWidth = 412.0;
    const double baseHeight = 917.0;

    // Calculate scaling factors
    final widthScale = screenSize.width / baseWidth;
    final heightScale = screenSize.height / baseHeight;
    // Use the smaller scale factor to maintain aspect ratio, or choose width/height scale as needed
    final scaleFactor = widthScale < heightScale ? widthScale : heightScale;

    // Dynamic padding and font sizes
    final horizontalPadding = 16.0 * widthScale;
    final verticalPadding = 10.0 * heightScale;
    final smallFontSize = 12.0 * scaleFactor;
    final mediumFontSize = 14.0 * scaleFactor;
    final buttonHeight = 45.0 * heightScale;

    // Placeholder Data (Replace with actual data passed to the widget)
    // TODO: Replace this Map with a proper Product Model class
    const productData = {
      'manufacturerPartNumber': '103004194-5501',
      'manufacturerLogoUrl': 'https://www.eaton.com/etc/designs/eaton/clientlib/images/logo.png', // Example URL
      'productImageUrl': null, // No image in the design
      'productName': 'Battery Enclosures SEISMIC KIT K15LV',
      'category': 'Battery Enclosures',
      'manufacturer': 'Eaton',
      'lifeCycle': 'New Product',
      'hsnCode': '00000000',
    };

    // TODO: Replace this List<Map> with a List<SupplierModel>
    const suppliersData = [
      {
        'supplierLogoUrl': 'https://example.com/master_logo.png', // Replace with actual logo URL
        'supplierName': 'Master Electronics',
        'partStatus': 'Active',
        'stock': 10, // Example stock > 0 to enable button
        'packagingType': 'Type A',
        'vendorPartNumber': 'VENDOR123',
        'factoryLeadTime': '9 Days',
        'warehouse': 'US Warehouse',
        'htsCode': '854231',
        'dateCode': 'Within 2 Years',
        'minQuantity': 1,
        'multQuantity': 1,
        'initialOrderValue': 196032.03, // Price for min quantity 1
        'priceSlabs': [
          {'quantity': 1, 'price': 196032.03},
          {'quantity': 3, 'price': 190811.16},
          {'quantity': 5, 'price': 185855.6},
        ],
      },
       {
        'supplierLogoUrl': 'https://example.com/mouser_logo.png', // Replace with actual logo URL
        'supplierName': 'Mouser Electronics',
        'partStatus': 'Active',
        'stock': 5, // Example stock > 0
        'packagingType': 'Type B',
        'vendorPartNumber': '545-103004194-5501',
        'factoryLeadTime': '12 Days',
        'warehouse': 'US Warehouse',
        'htsCode': '8500000000',
        'dateCode': 'Within 2 Years',
        'minQuantity': 1,
        'multQuantity': 1,
        'initialOrderValue': 184785.7, // Price for min quantity 1
        'priceSlabs': [
          {'quantity': 1, 'price': 184785.7},
          // Add more slabs if available
        ],
      },
       {
        'supplierLogoUrl': 'https://example.com/digikey_logo.png', // Replace with actual logo URL
        'supplierName': 'Digikey Electronics',
        'partStatus': 'Active',
        'stock': 0, // Example stock = 0, button will be disabled
        'packagingType': 'Bulk',
        'vendorPartNumber': 'P21#-103004194-5501-ND',
        'factoryLeadTime': '10 Days',
        'warehouse': 'US Warehouse',
        'htsCode': '8500000000',
        'dateCode': 'Within 2 Years',
        'minQuantity': 1,
        'multQuantity': 1,
        'initialOrderValue': 208474.17, // Price for min quantity 1
        'priceSlabs': [
          {'quantity': 1, 'price': 208474.17},
           // Add more slabs if available
        ],
      },
      // Add more supplier data maps here
    ];


    return Container(
      color: Colors.white, // Set background color if needed, otherwise transparent
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: verticalPadding),
              // Top Info Text
              Container(
                padding: EdgeInsets.all(10 * scaleFactor),
                decoration: BoxDecoration(
                  color: Colors.blue.shade50,
                  borderRadius: BorderRadius.circular(4 * scaleFactor),
                ),
                child: Text(
                  'Final Unit Price is calculated at the checkout is inclusive of all duties, But excludes optional Freight, Insurance, Handling Fees and other charges.',
                  style: TextStyle(fontSize: smallFontSize, color: Colors.blue.shade800),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(height: verticalPadding * 1.5),

              // Request for Quote Button
              Center(
                child: SizedBox(
                  height: buttonHeight,
                  child: ElevatedButton(
                    onPressed: () {
                      // TODO: Implement Request for Quote action
                       ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Request for Quote Initiated (Placeholder)')),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red.shade700,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8 * scaleFactor),
                      ),
                      padding: EdgeInsets.symmetric(horizontal: 30 * widthScale),
                    ),
                    child: Text(
                      'Request for Quote',
                      style: TextStyle(fontSize: mediumFontSize, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
              SizedBox(height: verticalPadding * 1.5),

              // Product Display Tile
              ProductDisplayTile(
                manufacturerPartNumber: productData['manufacturerPartNumber'] as String,
                manufacturerLogoUrl: productData['manufacturerLogoUrl'] as String?,
                productImageUrl: productData['productImageUrl'] as String?,
                productName: productData['productName'] as String,
                category: productData['category'] as String,
                manufacturer: productData['manufacturer'] as String,
                lifeCycle: productData['lifeCycle'] as String,
                hsnCode: productData['hsnCode'] as String,
                onCategoryTap: () {
                  // TODO: Implement category tap action
                   ScaffoldMessenger.of(context).showSnackBar(
                     SnackBar(content: Text('Tapped Category: ${productData['category']}')),
                   );
                },
              ),
              SizedBox(height: verticalPadding * 2),

              // Suppliers Header
              Text(
                'Suppliers',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  fontSize: 18 * scaleFactor, // Slightly larger font for header
                ),
              ),
              SizedBox(height: verticalPadding),

              // List of Supplier Tiles
              ListView.builder(
                shrinkWrap: true, // Important inside SingleChildScrollView
                physics: const NeverScrollableScrollPhysics(), // Disable ListView's own scrolling
                itemCount: suppliersData.length,
                itemBuilder: (context, index) {
                  final supplier = suppliersData[index];
                  // Cast priceSlabs explicitly
                  final priceSlabs = List<Map<String, dynamic>>.from(supplier['priceSlabs'] as List);

                  return Padding(
                    padding: EdgeInsets.only(bottom: verticalPadding), // Spacing between supplier cards
                    child: ProductSupplierTile(
                      supplierLogoUrl: supplier['supplierLogoUrl'] as String,
                      supplierName: supplier['supplierName'] as String,
                      partStatus: supplier['partStatus'] as String,
                      stock: supplier['stock'] as int,
                      packagingType: supplier['packagingType'] as String,
                      vendorPartNumber: supplier['vendorPartNumber'] as String,
                      factoryLeadTime: supplier['factoryLeadTime'] as String?,
                      warehouse: supplier['warehouse'] as String,
                      htsCode: supplier['htsCode'] as String,
                      dateCode: supplier['dateCode'] as String,
                      minQuantity: supplier['minQuantity'] as int,
                      multQuantity: supplier['multQuantity'] as int,
                      initialOrderValue: supplier['initialOrderValue'] as double,
                      priceSlabs: priceSlabs, // Pass the casted list
                      onAddToCart: (quantity) {
                        // --- Add to Cart Implementation ---

                        // 1. Calculate Price Per Unit for the given quantity
                        final double pricePerUnit = _calculatePricePerUnit(
                          quantity,
                          supplier['initialOrderValue'] as double,
                          supplier['minQuantity'] as int,
                          priceSlabs,
                        );

                        // 2. Prepare Cart Item Data (matching CartItem structure)
                        // TODO: Define a proper CartItemModel class instead of using a Map
                        final cartItemData = {
                          "mfrPartNumber": productData['manufacturerPartNumber'] as String,
                          // Use mfrPartNumber or a specific logic if customer part number differs
                          "customerPartNumber": productData['manufacturerPartNumber'] as String,
                          "description": productData['productName'] as String, // Use product name as description
                          "vendorPartNumber": supplier['vendorPartNumber'] as String,
                          "manufacturer": productData['manufacturer'] as String,
                          "supplier": supplier['supplierName'] as String,
                          "basicUnitPrice": pricePerUnit, // Use calculated price per unit
                          "finalUnitPrice": pricePerUnit, // Assuming final is same as basic for now
                          "gstPercentage": 18.0, // TODO: Replace with actual GST logic/data
                          "quantity": quantity,
                        };

                        // 3. Add to Cart using State Management
                        // TODO: Replace this print with your actual cart state management logic
                        // Example using Provider:
                        // try {
                        //   context.read<CartProvider>().addItem(CartItemModel.fromJson(cartItemData)); // Assuming a model and fromJson constructor
                        // } catch (e) {
                        //    print("Error adding item to cart: $e");
                        //    ScaffoldMessenger.of(context).showSnackBar(
                        //      const SnackBar(content: Text('Failed to add item to cart.')),
                        //    );
                        //    return; // Exit if adding failed
                        // }
                        print('--- Add to Cart ---');
                        print('Item Data: $cartItemData');
                        print('-------------------');


                        // 4. Show Confirmation
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('$quantity x ${productData['productName']} from ${supplier['supplierName']} added to cart.'),
                            duration: const Duration(seconds: 2),
                          ),
                        );
                        // --- End Add to Cart ---
                      },
                      onRequestQuote: (quantity) {
                         // TODO: Implement Request Quote action for this supplier
                         print('Request quote: ${supplier['supplierName']} - Qty: $quantity');
                         ScaffoldMessenger.of(context).showSnackBar(
                           SnackBar(content: Text('Requesting quote for $quantity x ${productData['productName']} from ${supplier['supplierName']}')),
                         );
                      },
                    ),
                  );
                },
              ),
               SizedBox(height: verticalPadding), // Bottom padding
            ],
          ),
        ),
      ),
    );
  }
}

// Example Usage (within a Scaffold body or any other parent widget):
//
// Scaffold(
//   appBar: AppBar(title: Text('Product Details')), // Optional AppBar
//   body: ProductDetailsContent(
//     // Pass actual product and supplier data here
//   ),
// )

// TODO: Define a CartItemModel class (Example)
/*
class CartItemModel {
  final String mfrPartNumber;
  final String customerPartNumber;
  final String description;
  final String vendorPartNumber;
  final String manufacturer;
  final String supplier;
  final double basicUnitPrice;
  final double finalUnitPrice;
  final double gstPercentage;
  final int quantity;

  CartItemModel({
    required this.mfrPartNumber,
    required this.customerPartNumber,
    required this.description,
    required this.vendorPartNumber,
    required this.manufacturer,
    required this.supplier,
    required this.basicUnitPrice,
    required this.finalUnitPrice,
    required this.gstPercentage,
    required this.quantity,
  });

  // Optional: Factory constructor to create from Map
  factory CartItemModel.fromJson(Map<String, dynamic> json) {
    return CartItemModel(
      mfrPartNumber: json['mfrPartNumber'] as String,
      customerPartNumber: json['customerPartNumber'] as String,
      description: json['description'] as String,
      vendorPartNumber: json['vendorPartNumber'] as String,
      manufacturer: json['manufacturer'] as String,
      supplier: json['supplier'] as String,
      basicUnitPrice: (json['basicUnitPrice'] as num).toDouble(),
      finalUnitPrice: (json['finalUnitPrice'] as num).toDouble(),
      gstPercentage: (json['gstPercentage'] as num).toDouble(),
      quantity: json['quantity'] as int,
    );
  }

  // Optional: Method to convert to Map
  Map<String, dynamic> toJson() {
    return {
      'mfrPartNumber': mfrPartNumber,
      'customerPartNumber': customerPartNumber,
      'description': description,
      'vendorPartNumber': vendorPartNumber,
      'manufacturer': manufacturer,
      'supplier': supplier,
      'basicUnitPrice': basicUnitPrice,
      'finalUnitPrice': finalUnitPrice,
      'gstPercentage': gstPercentage,
      'quantity': quantity,
    };
  }
}
*/