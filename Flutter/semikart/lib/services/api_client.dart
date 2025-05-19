// lib/services/api_client.dart
import 'package:dio/dio.dart';
import '../config/api_config.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:developer';

class ApiClient {
  final Dio _dio = Dio();
  
  ApiClient() {
    _dio.options.baseUrl = ApiConfig.baseUrl;
    _dio.options.connectTimeout = Duration(seconds: ApiConfig.connectTimeout);
    _dio.options.receiveTimeout = Duration(seconds: ApiConfig.receiveTimeout);
    
    _setupInterceptors();
  }
  
  void _setupInterceptors() {
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          // Get token from SharedPreferences
          final prefs = await SharedPreferences.getInstance();
          final token = prefs.getString('authToken');
          
          if (token != null) {
            options.headers.addAll({'Authorization': 'Bearer $token'});
          }
          
          // Log the request
          ApiConfig.logRequest(
            options.method, 
            options.path, 
            data: options.data,
            queryParams: options.queryParameters
          );
          
          return handler.next(options);
        },
        onError: (DioException e, handler) {
          log('⚠️ API Error: ${e.message}');
          return handler.next(e);
        }
      )
    );
  }
  
  Dio get dio => _dio;
}