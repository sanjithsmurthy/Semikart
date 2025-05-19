import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../config/api_config.dart'; // Add this import
import '../services/api_client.dart'; // Add this import

// --- Authentication Status Enum ---
enum AuthStatus { unknown, authenticated, unauthenticated }

// --- API User Class (replacing Firebase User) ---
class ApiUser {
  final String id;
  final String email;
  final String? displayName;
  final String? photoURL;
  final String? phoneNumber;
  
  ApiUser({
    required this.id,
    required this.email,
    this.displayName,
    this.photoURL,
    this.phoneNumber,
  });
  
  factory ApiUser.fromJson(Map<String, dynamic> json) {
    return ApiUser(
      id: json['id']?.toString() ?? '',
      email: json['email'] ?? '',
      displayName: json['name'] ?? json['full_name'] ?? json['firstName'] ?? '',
      photoURL: json['photoURL'] ?? json['profile_photo'] ?? '',
      phoneNumber: json['phoneNumber'] ?? json['phone'] ?? '',
    );
  }
  
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'displayName': displayName,
      'photoURL': photoURL,
      'phoneNumber': phoneNumber,
    };
  }
}

// --- Authentication State Class ---
class AuthState {
  final AuthStatus status;
  final ApiUser? user; // Using our ApiUser instead of Firebase User
  final String? errorMessage;
  final bool isLoading;

  AuthState({
    this.status = AuthStatus.unknown,
    this.user,
    this.errorMessage,
    this.isLoading = false,
  });

  // Factory methods for common states
  factory AuthState.unknown() => AuthState(status: AuthStatus.unknown);
  
  factory AuthState.authenticated(ApiUser user) => 
    AuthState(status: AuthStatus.authenticated, user: user);
    
  factory AuthState.unauthenticated() => 
    AuthState(status: AuthStatus.unauthenticated);
    
  factory AuthState.error(String message) => 
    AuthState(status: AuthStatus.unauthenticated, errorMessage: message);

  // Helper method to create a copy with updated values
  AuthState copyWith({
    AuthStatus? status,
    ApiUser? user,
    String? errorMessage,
    bool clearError = false,
    bool? isLoading,
  }) {
    return AuthState(
      status: status ?? this.status,
      user: user, // Allow setting to null
      errorMessage: clearError ? null : errorMessage ?? this.errorMessage,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}

// --- API Service using ApiClient ---
class ApiService {
  final ApiClient _apiClient = ApiClient();
  
  // Login method
  Future<Map<String, dynamic>> login(String email, String password) async {
    try {
      final formData = FormData.fromMap({
        'email': email,
        'password': password,
      });
      
      // Use ApiConfig for endpoint
      final response = await _apiClient.dio.post(
        Auth.login,
        data: formData,
      );
      
      if (response.statusCode == 200) {
        return {
          'success': true,
          'data': response.data,
        };
      } else {
        return {
          'success': false,
          'message': response.statusMessage ?? 'Login failed',
          'statusCode': response.statusCode,
        };
      }
    } on DioException catch (e) {
      String errorMessage = 'Login failed';
      
      if (e.response != null) {
        errorMessage = 'Server error: ${e.response?.statusCode} ${e.response?.statusMessage ?? 'Unknown error'}';
        if (e.response?.data is Map && e.response!.data.containsKey('message')) {
          errorMessage = e.response!.data['message'];
        } else if (e.response?.data is String && (e.response!.data as String).isNotEmpty) {
          errorMessage = e.response!.data as String;
        }
      } else if (e.type == DioExceptionType.connectionTimeout) {
        errorMessage = ApiConfig.timeoutError;
      } else if (e.type == DioExceptionType.connectionError) {
        errorMessage = ApiConfig.connectionError;
      } 
      
      return {
        'success': false,
        'message': errorMessage,
        'error': e.toString(),
      };
    } catch (e) {
      return {
        'success': false,
        'message': ApiConfig.defaultError,
        'error': e.toString(),
      };
    }
  }
  
  // Log out method
  Future<bool> logout() async {
    try {
      // If your API has a logout endpoint, use ApiConfig
      // final response = await _apiClient.dio.post(ApiConfig.auth.logout);
      // return response.statusCode == 200;
      
      // If no logout endpoint, just return success
      return true;
    } catch (e) {
      log('Logout error: $e');
      return false;
    }
  }
  
  // Sign up method
  Future<Map<String, dynamic>> signUp({
    required String email,
    required String password,
    required String firstName,
    required String lastName,
    required String companyName,
    required String phoneNumber,
  }) async {
    try {
      final formData = FormData.fromMap({
        'email': email,
        'password': password,
        'firstName': firstName,
        'lastName': lastName,
        'companyName': companyName,
        'phone': phoneNumber,
      });
      
      // Use ApiConfig for endpoint
      final response = await _apiClient.dio.post(
        Auth.register,
        data: formData,
      );
      
      if (response.statusCode == 200 || response.statusCode == 201) {
        return {
          'success': true,
          'data': response.data,
        };
      } else {
        return {
          'success': false,
          'message': response.statusMessage ?? 'Registration failed',
          'statusCode': response.statusCode,
        };
      }
    } on DioException catch (e) {
      String errorMessage = 'Registration failed';
      
      if (e.response != null) {
        errorMessage = 'Server error: ${e.response?.statusCode} ${e.response?.statusMessage ?? 'Unknown error'}';
        if (e.response?.data is Map && e.response!.data.containsKey('message')) {
          errorMessage = e.response!.data['message'];
        } 
      }
      
      return {
        'success': false,
        'message': errorMessage,
        'error': e.toString(),
      };
    } catch (e) {
      return {
        'success': false,
        'message': ApiConfig.defaultError,
        'error': e.toString(),
      };
    }
  }
  
  // Password reset
  Future<Map<String, dynamic>> sendPasswordReset(String email) async {
    try {
      final formData = FormData.fromMap({
        'email': email,
      });
      
      // Use ApiConfig for endpoint
      final response = await _apiClient.dio.post(
        Auth.resetPassword,
        data: formData,
      );
      
      if (response.statusCode == 200) {
        return {
          'success': true,
          'message': 'Password reset email sent',
        };
      } else {
        return {
          'success': false,
          'message': response.statusMessage ?? 'Failed to send password reset',
          'statusCode': response.statusCode,
        };
      }
    } on DioException catch (e) {
      String errorMessage = 'Password reset failed';
      
      if (e.response != null) {
        errorMessage = 'Server error: ${e.response?.statusCode} ${e.response?.statusMessage ?? 'Unknown error'}';
      }
      
      return {
        'success': false,
        'message': errorMessage,
        'error': e.toString(),
      };
    } catch (e) {
      return {
        'success': false,
        'message': ApiConfig.defaultError,
        'error': e.toString(),
      };
    }
  }
  
  // Add token refresh if needed
  Future<bool> refreshToken(String refreshToken) async {
    try {
      final response = await _apiClient.dio.post(
        Auth.refreshToken,
        data: {'refreshToken': refreshToken}
      );
      return response.statusCode == 200;
    } catch (e) {
      log('Token refresh failed: $e');
      return false;
    }
  }
}

// --- Auth Manager (State Notifier) ---
class AuthManager extends StateNotifier<AuthState> {
  final ApiService _apiService;
  final SharedPreferences _prefs;
  
  AuthManager(this._apiService, this._prefs) : super(AuthState()) {
    _initialize();
  }
  
  // Alternative constructor that creates ApiService internally
  AuthManager.withPrefs(this._prefs) : 
    _apiService = ApiService(), 
    super(AuthState()) {
    _initialize();
  }
  
  void _initialize() {
    _checkAuthStatus();
  }
  
  void _checkAuthStatus() {
    // Check for saved user in shared preferences
    final userJson = _prefs.getString('user_data');
    if (userJson != null) {
      try {
        final userData = jsonDecode(userJson);
        final user = ApiUser.fromJson(userData);
        state = AuthState(status: AuthStatus.authenticated, user: user);
        log("AuthManager Init: User found - ${user.id}");
      } catch (e) {
        log("Error parsing saved user data: $e");
        _prefs.remove('user_data');
        state = AuthState(status: AuthStatus.unauthenticated);
      }
    } else {
      log("AuthManager Init: No user found.");
      state = AuthState(status: AuthStatus.unauthenticated);
    }
  }
  
  Future<bool> login(String email, String password) async {
    try {
      state = state.copyWith(status: AuthStatus.unknown, errorMessage: null, clearError: true, isLoading: true);
      
      final apiResponse = await _apiService.login(email, password);
      
      if (apiResponse['success']) {
        // Extract user data from response
        final userData = apiResponse['data'];
        
        // Create ApiUser from response
        final apiUser = ApiUser.fromJson(userData);
        
        // Save to SharedPreferences
        await _prefs.setString('user_data', jsonEncode(userData));
        
        // Update state
        state = state.copyWith(
          status: AuthStatus.authenticated,
          user: apiUser,
          errorMessage: null,
          clearError: true,
          isLoading: false
        );
        return true;
      } else {
        state = state.copyWith(
          status: AuthStatus.unauthenticated,
          errorMessage: apiResponse['message'] ?? 'Login failed',
          isLoading: false
        );
        return false;
      }
    } catch (e) {
      state = state.copyWith(
        status: AuthStatus.unauthenticated,
        errorMessage: 'Login error: ${e.toString()}',
        isLoading: false
      );
      return false;
    }
  }
  
  Future<bool> logout() async {
    try {
      state = state.copyWith(isLoading: true);
      
      // Call API logout (optional)
      await _apiService.logout();
      
      // Clear local storage
      await _prefs.remove('user_data');
      
      state = state.copyWith(
        status: AuthStatus.unauthenticated,
        user: null,
        clearError: true,
        isLoading: false
      );
      return true;
    } catch (e) {
      log("Logout error: $e");
      state = state.copyWith(
        errorMessage: 'Logout failed: ${e.toString()}',
        isLoading: false
      );
      return false;
    }
  }
  
  Future<bool> signUp({
    required String email,
    required String password,
    required String firstName,
    required String lastName,
    required String companyName,
    required String phoneNumber,
  }) async {
    try {
      state = state.copyWith(isLoading: true);
      
      final apiResponse = await _apiService.signUp(
        email: email,
        password: password,
        firstName: firstName,
        lastName: lastName,
        companyName: companyName,
        phoneNumber: phoneNumber,
      );
      
      if (apiResponse['success']) {
        // You can either automatically log in after signup or require a separate login
        // For simplicity, we'll log in automatically
        return await login(email, password);
      } else {
        state = state.copyWith(
          status: AuthStatus.unauthenticated,
          errorMessage: apiResponse['message'] ?? 'Signup failed',
          isLoading: false
        );
        return false;
      }
    } catch (e) {
      state = state.copyWith(
        status: AuthStatus.unauthenticated,
        errorMessage: 'Signup error: ${e.toString()}',
        isLoading: false
      );
      return false;
    }
  }
  
  Future<bool> sendPasswordReset(String email) async {
    try {
      state = state.copyWith(isLoading: true);
      
      final apiResponse = await _apiService.sendPasswordReset(email);
      
      if (apiResponse['success']) {
        state = state.copyWith(
          errorMessage: null, 
          clearError: true,
          isLoading: false
        );
        return true;
      } else {
        state = state.copyWith(
          errorMessage: apiResponse['message'] ?? 'Password reset failed',
          isLoading: false
        );
        return false;
      }
    } catch (e) {
      state = state.copyWith(
        errorMessage: 'Password reset error: ${e.toString()}',
        isLoading: false
      );
      return false;
    }
  }
  
  // Add token refresh capability
  Future<bool> refreshToken() async {
    try {
      final refreshToken = _prefs.getString('refresh_token');
      if (refreshToken == null) return false;
      
      return await _apiService.refreshToken(refreshToken);
    } catch (e) {
      return false;
    }
  }
}

// --- Providers ---
final apiServiceProvider = Provider<ApiService>((ref) {
  return ApiService();
});

final sharedPreferencesProvider = Provider<SharedPreferences>((ref) {
  throw UnimplementedError('Initialize this provider in main.dart with a SharedPreferences instance');
});

final authManagerProvider = StateNotifierProvider<AuthManager, AuthState>((ref) {
  final apiService = ref.watch(apiServiceProvider);
  final prefs = ref.watch(sharedPreferencesProvider);
  return AuthManager(apiService, prefs);
});

// Alternative provider if you prefer to create ApiService within AuthManager
final simplifiedAuthManagerProvider = StateNotifierProvider<AuthManager, AuthState>((ref) {
  final prefs = ref.watch(sharedPreferencesProvider);
  return AuthManager.withPrefs(prefs);
});

