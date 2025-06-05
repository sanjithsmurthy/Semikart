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
      // Always add x-api-key header
      options.headers['x-api-key'] = '7b483f94-efac-4624-afc9-f161f0653eef';
      // Get token from SharedPreferences
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('authToken');

      if (token != null) {
        options.headers.addAll({'Authorization': 'Bearer $token'});
      }

      // Log the request
      ApiConfig.logRequest(options.method, options.path,
          data: options.data, queryParams: options.queryParameters);

      // Log the request with headers and data type
      log('🌐 API ${options.method}: ${options.uri}');
      log('Headers: ' + options.headers.toString());
      if (options.data != null) {
        log('Data type: ' + options.data.runtimeType.toString());
        if (options.data is Map<String, dynamic>) {
          log('Request Body: ' + jsonEncode(options.data));
        } else if (options.data.runtimeType.toString() == 'FormData') {
          final formData = options.data as FormData;
          log('FormData fields: ' + formData.fields.toString());
          log('FormData files: ' + formData.files.toString());
        } else {
          log('Request Body: ' + options.data.toString());
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
        log('⚠️ API Error: ' + (e.message ?? 'No message'));
        log('Error Type: ' + e.type.toString());
        log('Error StackTrace: ' + (e.stackTrace.toString()));
        if (e.response != null) {
          log('Error Response [' + (e.response?.statusCode?.toString() ?? '') + ']: ' + (e.response?.data?.toString() ?? ''));
        }
        return handler.next(e);
      }
    ));
  }

  Dio get dio => _dio;
}
