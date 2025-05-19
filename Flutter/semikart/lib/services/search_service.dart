import 'dart:async';
import 'dart:developer';
import 'package:dio/dio.dart';
import '../config/api_config.dart';
import 'api_client.dart';

class SearchService {
  final ApiClient _apiClient = ApiClient();
  
  SearchService() {
    // No need to configure Dio here as it's handled by ApiClient
  }

  // Search products
  Future<List<Map<String, dynamic>>> searchProducts(
      {required String query, String? category, int? limit, int? offset}) async {
    try {
      final endpoint = Products.search;
      
      final queryParams = {
        'query': query,
        if (category != null) 'category': category,
        if (limit != null) 'limit': limit.toString(),
        if (offset != null) 'offset': offset.toString(),
      };
      
      final response = await _apiClient.dio.get(
        endpoint,
        queryParameters: queryParams,
      );
      
      if (response.statusCode != 200) {
        throw Exception('Failed to search products: ${response.statusMessage}');
      }
      
      final List<dynamic> results = response.data;
      log('Found ${results.length} products matching query: "$query"');
      return results.cast<Map<String, dynamic>>();
    } catch (e) {
      log('Error searching products: $e');
      rethrow;
    }
  }
  
  // Get search suggestions
  Future<List<String>> getSearchSuggestions(String query) async {
    try {
      final endpoint = '/search/suggestions';
      
      final response = await _apiClient.dio.get(
        endpoint,
        queryParameters: {'query': query},
      );
      
      if (response.statusCode != 200) {
        throw Exception('Failed to get search suggestions: ${response.statusMessage}');
      }
      
      final List<dynamic> suggestions = response.data;
      return suggestions.cast<String>();
    } catch (e) {
      log('Error getting search suggestions: $e');
      rethrow;
    }
  }
  
  // Record search history
  Future<void> recordSearchHistory(String userId, String query) async {
    try {
      final endpoint = '/search/history';
      
      await _apiClient.dio.post(
        endpoint,
        data: {
          'userId': userId,
          'query': query,
        },
      );
      
      log('Recorded search history for user $userId: "$query"');
    } catch (e) {
      log('Error recording search history: $e');
      // Don't rethrow - this is a non-critical operation
    }
  }
  
  // Get user's search history
  Future<List<String>> getSearchHistory(String userId) async {
    try {
      final endpoint = '/search/history/$userId';
      
      final response = await _apiClient.dio.get(endpoint);
      
      if (response.statusCode != 200) {
        throw Exception('Failed to get search history: ${response.statusMessage}');
      }
      
      final List<dynamic> history = response.data;
      return history.cast<String>();
    } catch (e) {
      log('Error getting search history: $e');
      rethrow;
    }
  }
  
  // Clear search history
  Future<void> clearSearchHistory(String userId) async {
    try {
      final endpoint = '/search/history/$userId';
      
      await _apiClient.dio.delete(endpoint);
      
      log('Cleared search history for user: $userId');
    } catch (e) {
      log('Error clearing search history: $e');
      rethrow;
    }
  }
}