import 'dart:async';
import 'dart:developer';
import 'package:dio/dio.dart';
import '../config/api_config.dart';
import 'api_client.dart';

class OrderService {
  final ApiClient _apiClient = ApiClient();
  
  OrderService() {
    // No need to configure Dio here as it's handled by ApiClient
  }

  // Get all orders for a user
  Future<List<Map<String, dynamic>>> getUserOrders(String userId) async {
    try {
      final endpoint = Orders.userOrders(userId);
      
      final response = await _apiClient.dio.get(
        endpoint,
        options: Options(headers: {'x-api-key': '7b483f94-efac-4624-afc9-f161f0653eef'}),
      );
      
      if (response.statusCode != 200) {
        throw Exception('Failed to fetch orders: ${response.statusMessage}');
      }
      
      final List<dynamic> data = response.data;
      log('Fetched ${data.length} orders for user: $userId');
      return data.cast<Map<String, dynamic>>();
    } catch (e) {
      log('Error fetching user orders: $e');
      rethrow;
    }
  }
  
  // Get order details
  Future<Map<String, dynamic>> getOrderDetails(String orderId) async {
    try {
      final endpoint = Orders.orderDetails(orderId);
      
      final response = await _apiClient.dio.get(
        endpoint,
        options: Options(headers: {'x-api-key': '7b483f94-efac-4624-afc9-f161f0653eef'}),
      );
      
      if (response.statusCode != 200) {
        throw Exception('Failed to fetch order details: ${response.statusMessage}');
      }
      
      final Map<String, dynamic> data = response.data;
      log('Fetched details for order: $orderId');
      return data;
    } catch (e) {
      log('Error fetching order details: $e');
      rethrow;
    }
  }
  
  // Create new order
  Future<Map<String, dynamic>> createOrder({
    required String userId,
    required List<Map<String, dynamic>> items,
    required Map<String, dynamic> shippingAddress,
    required String paymentMethod,
    String? couponCode,
  }) async {
    try {
      final endpoint = Orders.createOrder;
      
      final data = {
        'userId': userId,
        'items': items,
        'shippingAddress': shippingAddress,
        'paymentMethod': paymentMethod,
        if (couponCode != null) 'couponCode': couponCode,
      };
      
      final response = await _apiClient.dio.post(
        endpoint,
        options: Options(headers: {'x-api-key': '7b483f94-efac-4624-afc9-f161f0653eef'}),
        data: data,
      );
      
      if (response.statusCode != 200 && response.statusCode != 201) {
        throw Exception('Failed to create order: ${response.statusMessage}');
      }
      
      final Map<String, dynamic> orderData = response.data;
      log('Created order: ${orderData['orderId']}');
      return orderData;
    } catch (e) {
      log('Error creating order: $e');
      rethrow;
    }
  }
  
  // Cancel order
  Future<void> cancelOrder(String orderId, String reason) async {
    try {
      final endpoint = '${Orders.orderDetails(orderId)}/cancel';
      
      final data = {
        'reason': reason,
      };
      
      final response = await _apiClient.dio.post(
        endpoint,
        options: Options(headers: {'x-api-key': '7b483f94-efac-4624-afc9-f161f0653eef'}),
        data: data,
      );
      
      if (response.statusCode != 200) {
        throw Exception('Failed to cancel order: ${response.statusMessage}');
      }
      
      log('Cancelled order: $orderId');
    } catch (e) {
      log('Error cancelling order: $e');
      rethrow;
    }
  }
  
  // Track order
  Future<Map<String, dynamic>> trackOrder(String orderId) async {
    try {
      final endpoint = '${Orders.orderDetails(orderId)}/track';
      
      final response = await _apiClient.dio.get(
        endpoint,
        options: Options(headers: {'x-api-key': '7b483f94-efac-4624-afc9-f161f0653eef'}),
      );
      
      if (response.statusCode != 200) {
        throw Exception('Failed to track order: ${response.statusMessage}');
      }
      
      final Map<String, dynamic> trackingData = response.data;
      log('Retrieved tracking info for order: $orderId');
      return trackingData;
    } catch (e) {
      log('Error tracking order: $e');
      rethrow;
    }
  }
}