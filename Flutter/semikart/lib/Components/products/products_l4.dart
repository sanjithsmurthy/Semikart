import 'package:flutter/material.dart';
import 'dart:developer'; // For logging
import 'dart:convert'; // Added for jsonDecode
import 'package:http/http.dart' as http; // Added for http requests
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

// New API-integrated L4 Page
class ProductsL4Page extends StatefulWidget {
  const ProductsL4Page({super.key});

  @override
  State<ProductsL4Page> createState() => _ProductsL4PageState();
}

class _ProductsL4PageState extends State<ProductsL4Page> {
  final List<ProductDataL4> _allProducts = [];
  final ScrollController _scrollController = ScrollController();
  bool _isLoading = false;
  bool _hasMoreData = true;
  int _currentPage = 1;
  int? _categoryId;
  int? _totalResults;
  
  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }
  
  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
  
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Initialize only once when dependencies change (includes route arguments)
    if (_categoryId == null) {
      final args = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
      
      log('L4 Page: didChangeDependencies called');
      log('L4 Page: Received arguments: $args');
      
      if (args != null && args['categoryId'] != null) {
        _categoryId = args['categoryId'] as int;
        log('L4 Page: Category ID extracted: $_categoryId');
        _loadInitialProducts();
      } else {
        log('L4 Page: No valid categoryId found in arguments');
      }
    }
  }
  
  void _onScroll() {
    if (_scrollController.position.pixels >= _scrollController.position.maxScrollExtent - 200) {
      if (!_isLoading && _hasMoreData) {
        _loadMoreProducts();
      }
    }
  }
  
  Future<void> _loadInitialProducts() async {
    if (_isLoading) return;
    
    setState(() {
      _isLoading = true;
      _currentPage = 1;
      _allProducts.clear();
    });
    
    await _loadProducts();
  }
    Future<void> _loadMoreProducts() async {
    if (_isLoading || !_hasMoreData) return;
    
    setState(() {
      _isLoading = true;
      _currentPage++;
    });
    
    await _loadProducts();
  }
  
  Future<void> _loadAllProducts() async {
    if (_isLoading || !_hasMoreData || _totalResults == null) return;
    
    setState(() {
      _isLoading = true;
    });
    
    log('L4 API: Loading all remaining products...');
    
    // Calculate how many more products we need to load
    final remainingProducts = _totalResults! - _allProducts.length;
    final remainingPages = (remainingProducts / 20).ceil();
    
    // Load all remaining pages
    for (int i = 0; i < remainingPages && _hasMoreData; i++) {
      _currentPage++;
      await _loadProducts();
      
      // Small delay to prevent overwhelming the server
      if (i < remainingPages - 1) {
        await Future.delayed(const Duration(milliseconds: 100));
      }
    }
    
    log('L4 API: Finished loading all products. Total: ${_allProducts.length}');
  }// Load products from API with pagination
  Future<void> _loadProducts() async {
    if (_categoryId == null) return;
    
    final url = Uri.parse('http://172.16.2.5:8080/semikartapi/paginatedProductCatalog?categoryId=$_categoryId&page=$_currentPage&pageSize=20');
    
    log('L4 API: Making request to: $url');
    log('L4 API: Request categoryId: $_categoryId, page: $_currentPage');
    
    try {
      final response = await http.get(url).timeout(const Duration(seconds: 30));
      
      log('L4 API: Response status code: ${response.statusCode}');
      
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        log('L4 API: Parsed data status: ${data['status']}');
        
        if (data['status'] == 'success' && data['products'] != null) {
          final products = data['products'] as List;
          _totalResults = data['totalResults'] ?? 0;
          final totalPages = data['totalPages'] ?? 0;
          
          log('L4 API: Products count: ${products.length}');
          log('L4 API: Total results: $_totalResults');
          log('L4 API: Current page: $_currentPage, Total pages: $totalPages');
          
          final newProducts = products.map((product) => ProductDataL4(
            imageUrl: product['imageUrl'] ?? '',
            productName: product['PartNo'] ?? 'Unknown Product',
            description: product['description'] ?? 'No description available',
            category: product['category'] ?? 'Unknown Category',
            mfrPartNumber: product['mfrPartNumber'] ?? 'N/A',
            manufacturer: product['manufacturer'] ?? 'Unknown Manufacturer',
            lifeCycle: product['lifeCycle'] ?? 'Unknown',
          )).toList();
          
          setState(() {
            _allProducts.addAll(newProducts);
            _hasMoreData = _currentPage < totalPages;
            _isLoading = false;
          });
          
          log('L4 API: Total products loaded: ${_allProducts.length}');
          log('L4 API: Has more data: $_hasMoreData');
        } else {
          log('L4 API: No products found or status not success');
          setState(() {
            _isLoading = false;
            _hasMoreData = false;
          });
        }
      } else {
        log('L4 API: HTTP error - status: ${response.statusCode}, body: ${response.body}');
        setState(() {
          _isLoading = false;
        });
      }
    } catch (e) {
      log('L4 API: Exception occurred - $e');
      setState(() {
        _isLoading = false;
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
    
    return Column(
      children: [
        // Header with breadcrumb
        const ProductsHeaderContent(),
        
        // Breadcrumb navigation
        if (args != null) ...[
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Text(
              '${args['l1Name'] ?? ''} > ${args['l2Name'] ?? ''} > ${args['categoryName'] ?? ''}',
              style: const TextStyle(
                fontSize: 10,
                color: Color(0xFFA51414),
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
          // Products count info and load all button
        if (_totalResults != null) ...[
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0), // Reduced vertical padding
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Showing ${_allProducts.length} of $_totalResults products',
                  style: const TextStyle(
                    fontSize: 10,
                    color: Colors.grey,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                if (_hasMoreData && !_isLoading) ...[
                  TextButton(
                    onPressed: _loadAllProducts,
                    child: const Text(
                      'Load All',
                      style: TextStyle(
                        color: Color(0xFFA51414),
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
          // Products list with lazy loading
        Expanded(
          child: _categoryId == null
            ? const Center(child: Text('Loading...'))
            : _allProducts.isEmpty && _isLoading
                ? const Center(child: CircularProgressIndicator(color: Color(0xFFA51414)))
                : _allProducts.isEmpty && !_isLoading
                    ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text('No products found in this category'),
                            const SizedBox(height: 16),
                            ElevatedButton(
                              onPressed: _loadInitialProducts,
                              child: const Text('Retry'),
                            ),
                            ElevatedButton(
                              onPressed: () => Navigator.pop(context),
                              child: const Text('Go Back'),
                            ),
                          ],
                        ),
                      )
                    : RefreshIndicator(
                        color: const Color(0xFFA51414),
                        onRefresh: _loadInitialProducts,
                        child: ListView.builder(
                          controller: _scrollController,
                          physics: const AlwaysScrollableScrollPhysics(),
                          itemCount: _allProducts.length + (_hasMoreData ? 1 : 0),
                          itemBuilder: (context, index) {
                            if (index == _allProducts.length) {
                              // Loading indicator at the bottom
                              return Container(
                                padding: const EdgeInsets.all(16),
                                alignment: Alignment.center,
                                child: _isLoading
                                    ? Column(
                                        children: [
                                          const CircularProgressIndicator(color: Color(0xFFA51414)),
                                          const SizedBox(height: 8),
                                          Text(
                                            'Loading more products...',
                                            style: TextStyle(
                                              fontSize: 12,
                                              color: Colors.grey[600],
                                            ),
                                          ),
                                        ],
                                      )
                                    : const SizedBox.shrink(),
                              );
                            }
                            
                            final product = _allProducts[index];
                            return ProductTileL4(
                              imageUrl: product.imageUrl,
                              productName: product.productName,
                              description: product.description,
                              category: product.category,
                              mfrPartNumber: product.mfrPartNumber,
                              manufacturer: product.manufacturer,
                              lifeCycle: product.lifeCycle,
                              onViewDetailsPressed: () {
                                // Navigate to product details page
                                Navigator.of(context).pushNamed('product_details');
                              },
                            );
                          },
                        ),
                      ),
        ),
      ],
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
              Navigator.of(context).pushNamed('product_details');
              // Navigator.push(context, MaterialPageRoute(builder: (context) => ProductDetailScreen(product: product)));
            },
          ),
        ),
      ],
    );
  }
}