import 'dart:async';
import 'dart:developer';
import 'package:dio/dio.dart';
import '../config/api_config.dart';
import 'api_client.dart';

class NotificationService {
  final ApiClient _apiClient = ApiClient();
  
  NotificationService() {
    // No need to configure Dio here as it's handled by ApiClient
  }

  // Get user notifications
  Future<List<Map<String, dynamic>>> getUserNotifications(String userId) async {
    try {
      // Since this isn't in ApiConfig yet, construct the endpoint
      final endpoint = '/notifications/$userId';
      
      final response = await _apiClient.dio.get(endpoint);
      
      if (response.statusCode != 200) {
        throw Exception('Failed to fetch notifications: ${response.statusMessage}');
      }
      
      final List<dynamic> data = response.data;
      log('Fetched ${data.length} notifications for user: $userId');
      return data.cast<Map<String, dynamic>>();
    } catch (e) {
      log('Error fetching notifications: $e');
      rethrow;
    }
  }

  // Mark notification as read
  Future<void> markAsRead(String notificationId) async {
    try {
      final endpoint = '/notifications/$notificationId/read';
      
      final response = await _apiClient.dio.patch(endpoint);
      
      if (response.statusCode != 200) {
        throw Exception('Failed to mark notification as read: ${response.statusMessage}');
      }
      
      log('Marked notification $notificationId as read');
    } catch (e) {
      log('Error marking notification as read: $e');
      rethrow;
    }
  }

  // Delete notification
  Future<void> deleteNotification(String notificationId) async {
    try {
      final endpoint = '/notifications/$notificationId';
      
      final response = await _apiClient.dio.delete(endpoint);
      
      if (response.statusCode != 200) {
        throw Exception('Failed to delete notification: ${response.statusMessage}');
      }
      
      log('Deleted notification: $notificationId');
    } catch (e) {
      log('Error deleting notification: $e');
      rethrow;
    }
  }

  // Register device for push notifications
  Future<void> registerDevice(String userId, String deviceToken, String platform) async {
    try {
      final endpoint = '/notifications/register-device';
      
      final data = {
        'userId': userId,
        'deviceToken': deviceToken,
        'platform': platform // "android" or "ios"
      };
      
      final response = await _apiClient.dio.post(endpoint, data: data);
      
      if (response.statusCode != 200 && response.statusCode != 201) {
        throw Exception('Failed to register device: ${response.statusMessage}');
      }
      
      log('Registered device for push notifications: $deviceToken');
    } catch (e) {
      log('Error registering device for push notifications: $e');
      rethrow;
    }
  }
}