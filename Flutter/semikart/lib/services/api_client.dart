// lib/services/api_client.dart
import 'package:dio/dio.dart';
import '../config/api_config.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:developer';
import 'dart:convert';

class ApiClient {
  final Dio _dio = Dio();

  ApiClient() {
    _dio.options.baseUrl = ApiConfig.baseUrl;
    _dio.options.connectTimeout = Duration(seconds: ApiConfig.connectTimeout);
    _dio.options.receiveTimeout = Duration(seconds: ApiConfig.receiveTimeout);

    _setupInterceptors();
  }

  void _setupInterceptors() {
    _dio.interceptors
        .add(InterceptorsWrapper(
      onRequest: (options, handler) async {
      // Get token from SharedPreferences
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('authToken');

      if (token != null) {
        options.headers.addAll({'Authorization': 'Bearer $token'});
      }

      // Log the request
      ApiConfig.logRequest(options.method, options.path,
          data: options.data, queryParams: options.queryParameters);

      log('🌐 API ${options.method}: ${options.uri}');
      if (options.data != null) {
        if (options.data is Map<String, dynamic>) {
          log('Request Body: ${jsonEncode(options.data)}');
        } else if (options.data.runtimeType.toString() == 'FormData') {
          log('Request Body: FormData (not JSON-encodable)');
        } else {
          log('Request Body: ${options.data.toString()}');
        }
      }

      return handler.next(options);
    },
      onResponse: (response, handler) {
        log('✅ API Response [${response.statusCode}]: ${response.requestOptions.uri}');
        log('Response Data: ${response.data}');
        return handler.next(response);
      },
      onError: (DioException e, handler) {
        log('⚠️ API Error: ${e.message}');
        if (e.response != null) {
          log('Error Response [${e.response?.statusCode}]: ${e.response?.data}');
        }
        return handler.next(e);
      }
    ));
  }

  Dio get dio => _dio;
}
