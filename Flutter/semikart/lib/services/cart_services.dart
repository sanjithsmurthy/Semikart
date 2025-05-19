import 'dart:async';
import 'dart:developer';
import 'package:dio/dio.dart';
import '../config/api_config.dart';
import 'api_client.dart';

class CartService {
  final ApiClient _apiClient = ApiClient();
  
  CartService() {
    // No need to configure Dio here as it's handled by ApiClient
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
      // Use Cart.addItem instead of ApiConfig.cart.addItem
      final endpoint = Cart.addItem;
      
      await _apiClient.dio.post(
        endpoint,
        data: {
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
        }
      );
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
      // Access static method directly through Cart class
      final endpoint = Cart.updateItem(userId, productId);
      
      final Map<String, dynamic> data = {
        'quantity': quantity,
      };
      if (finalUnitPrice != null) {
        data['finalUnitPrice'] = finalUnitPrice;
      }
      
      await _apiClient.dio.patch(endpoint, data: data);
    } catch (e) {
      log('Error updating cart item: $e');
      rethrow;
    }
  }

  // Fetch Cart Items
  Stream<List<Map<String, dynamic>>> fetchCartItems(String userId) {
    // Access static method directly through Cart class
    final endpoint = Cart.userCart(userId);
    
    // Create a StreamController to simulate a Firestore-like stream
    final controller = StreamController<List<Map<String, dynamic>>>();
    
    // Function to fetch cart items and add to stream
    Future<void> fetchItems() async {
      try {
        final response = await _apiClient.dio.get(endpoint);
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
      // Access static method directly through Cart class
      final endpoint = Cart.removeItem(userId, productId);
      await _apiClient.dio.delete(endpoint);
    } catch (e) {
      log('Error removing item from cart: $e');
      rethrow;
    }
  }

  // Clear Cart
  Future<void> clearCart(String userId) async {
    try {
      // Access static method directly through Cart class
      final endpoint = Cart.clearCart(userId);
      await _apiClient.dio.delete(endpoint);
    } catch (e) {
      log('Error clearing cart: $e');
      rethrow;
    }
  }
}