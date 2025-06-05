import 'dart:async';
import 'dart:developer';
import 'package:dio/dio.dart';
import '../config/api_config.dart';
import 'api_client.dart';

class ProductService {
  final ApiClient _apiClient = ApiClient();
  
  ProductService() {
    // No need to configure Dio here as it's handled by ApiClient
  }

  // Get product details
  Future<Map<String, dynamic>> getProductDetails(String productId) async {
    try {
      final endpoint = Products.details(productId);
      
      final response = await _apiClient.dio.get(
        endpoint,
        options: Options(headers: {'x-api-key': '7b483f94-efac-4624-afc9-f161f0653eef'}),
      );
      
      if (response.statusCode != 200) {
        throw Exception('Failed to fetch product details: ${response.statusMessage}');
      }
      
      final Map<String, dynamic> product = response.data;
      log('Fetched details for product: $productId');
      return product;
    } catch (e) {
      log('Error fetching product details: $e');
      rethrow;
    }
  }
  
  // Get featured products
  Future<List<Map<String, dynamic>>> getFeaturedProducts() async {
    try {
      final endpoint = Products.featured;
      
      final response = await _apiClient.dio.get(
        endpoint,
        options: Options(headers: {'x-api-key': '7b483f94-efac-4624-afc9-f161f0653eef'}),
      );
      
      if (response.statusCode != 200) {
        throw Exception('Failed to fetch featured products: ${response.statusMessage}');
      }
      
      final List<dynamic> products = response.data;
      log('Fetched ${products.length} featured products');
      return products.cast<Map<String, dynamic>>();
    } catch (e) {
      log('Error fetching featured products: $e');
      rethrow;
    }
  }
  
  // Get related products
  Future<List<Map<String, dynamic>>> getRelatedProducts(String productId) async {
    try {
      final endpoint = '/products/$productId/related';
      
      final response = await _apiClient.dio.get(
        endpoint,
        options: Options(headers: {'x-api-key': '7b483f94-efac-4624-afc9-f161f0653eef'}),
      );
      
      if (response.statusCode != 200) {
        throw Exception('Failed to fetch related products: ${response.statusMessage}');
      }
      
      final List<dynamic> products = response.data;
      log('Fetched ${products.length} related products for product: $productId');
      return products.cast<Map<String, dynamic>>();
    } catch (e) {
      log('Error fetching related products: $e');
      rethrow;
    }
  }
  
  // Add product review
  Future<void> addProductReview(
      String productId, 
      String userId, 
      int rating, 
      String comment) async {
    try {
      final endpoint = '/products/$productId/reviews';
      
      final data = {
        'userId': userId,
        'rating': rating,
        'comment': comment,
      };
      
      final response = await _apiClient.dio.post(
        endpoint,
        options: Options(headers: {'x-api-key': '7b483f94-efac-4624-afc9-f161f0653eef'}),
        data: data,
      );
      
      if (response.statusCode != 200 && response.statusCode != 201) {
        throw Exception('Failed to add product review: ${response.statusMessage}');
      }
      
      log('Added review for product $productId by user $userId');
    } catch (e) {
      log('Error adding product review: $e');
      rethrow;
    }
  }
  
  // Get product reviews
  Future<List<Map<String, dynamic>>> getProductReviews(String productId) async {
    try {
      final endpoint = '/products/$productId/reviews';
      
      final response = await _apiClient.dio.get(
        endpoint,
        options: Options(headers: {'x-api-key': '7b483f94-efac-4624-afc9-f161f0653eef'}),
      );
      
      if (response.statusCode != 200) {
        throw Exception('Failed to fetch product reviews: ${response.statusMessage}');
      }
      
      final List<dynamic> reviews = response.data;
      log('Fetched ${reviews.length} reviews for product: $productId');
      return reviews.cast<Map<String, dynamic>>();
    } catch (e) {
      log('Error fetching product reviews: $e');
      rethrow;
    }
  }
}