import 'package:dio/dio.dart';
import 'dart:async';
import 'dart:convert';
import 'dart:developer';

class CartService {
  final Dio _dio = Dio();
  final String baseUrl = 'http://172.16.1.154:8080/semikartapi'; // Match your API URL from auth_manager
  
  CartService() {
    _dio.options.connectTimeout = const Duration(seconds: 10);
    _dio.options.receiveTimeout = const Duration(seconds: 10);
    
    // Add logging for debugging
    _dio.interceptors.add(LogInterceptor(
      requestBody: true,
      responseBody: true,
      error: true,
    ));
  }

  // Add Item to Cart
  Future<void> addToCart(
      String userId,
      String productId,
      String mfrPartNumber,
      String customerPartNumber,
      String description,
      String vendorPartNumber,
      String manufacturer,
      String supplier,
      double basicUnitPrice,
      double finalUnitPrice,
      double gstPercentage,
      int quantity) async {
    try {
      await _dio.post('$baseUrl/carts', data: {
        'userId': userId,
        'productId': productId,
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
      });
    } catch (e) {
      log('Error adding item to cart: $e');
      rethrow;
    }
  }

  // Update Cart Item
  Future<void> updateCartItem(
      String userId,
      String productId,
      int quantity,
      {double? finalUnitPrice}) async {
    try {
      final Map<String, dynamic> data = {
        'quantity': quantity,
      };
      if (finalUnitPrice != null) {
        data['finalUnitPrice'] = finalUnitPrice;
      }
      
      await _dio.patch('$baseUrl/carts/$userId/$productId', data: data);
    } catch (e) {
      log('Error updating cart item: $e');
      rethrow;
    }
  }

  // Fetch Cart Items
  // This now returns a Stream that emits the latest cart items whenever we fetch them
  Stream<List<Map<String, dynamic>>> fetchCartItems(String userId) {
    // Create a StreamController to simulate a Firestore stream
    final controller = StreamController<List<Map<String, dynamic>>>();
    
    // Function to fetch cart items and add to stream
    Future<void> fetchItems() async {
      try {
        final response = await _dio.get('$baseUrl/carts/$userId');
        if (response.statusCode == 200) {
          final List<dynamic> items = response.data;
          controller.add(items.cast<Map<String, dynamic>>());
        } else {
          controller.addError('Failed to fetch cart items: ${response.statusCode}');
        }
      } catch (e) {
        controller.addError('Error fetching cart items: $e');
      }
    }
    
    // Initial fetch
    fetchItems();
    
    // Set up periodic polling (every 30 seconds)
    final timer = Timer.periodic(const Duration(seconds: 30), (_) {
      if (!controller.isClosed) {
        fetchItems();
      }
    });
    
    // Clean up when the stream is no longer needed
    controller.onCancel = () {
      timer.cancel();
      controller.close();
    };
    
    return controller.stream;
  }

  // Remove Item from Cart
  Future<void> removeFromCart(String userId, String productId) async {
    try {
      await _dio.delete('$baseUrl/carts/$userId/$productId');
    } catch (e) {
      log('Error removing item from cart: $e');
      rethrow;
    }
  }

  // Clear Cart
  Future<void> clearCart(String userId) async {
    try {
      await _dio.delete('$baseUrl/carts/$userId');
    } catch (e) {
      log('Error clearing cart: $e');
      rethrow;
    }
  }
}