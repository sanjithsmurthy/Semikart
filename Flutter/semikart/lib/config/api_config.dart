import 'dart:developer';

/// API Configuration class for Semikart app
class ApiConfig {
  // Base URL for the API
  static const String baseUrl = 'http://172.16.1.160:8080/semikartapi';

  // Timeouts in seconds
  static const int connectTimeout = 10;
  static const int receiveTimeout = 15;

  // Error messages as direct constants on ApiConfig
  static const String timeoutError = 'Request timed out. Please try again.';
  static const String connectionError =
      'Connection failed. Please check your internet connection.';
  static const String serverError = 'Server error. Please try again later.';
  static const String unauthorizedError =
      'Session expired. Please login again.';
  static const String defaultError = 'Something went wrong. Please try again.';

  // Add static references to the other classes
  static final auth = Auth();
  static final users = Users();
  static final categories = Categories();
  static final products = Products();
  static final cart = Cart();
  static final orders = Orders();

  /// Build headers with optional authentication token
  static Map<String, String> getHeaders({String? authToken}) {
    final headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };

    // Add auth token if available
    if (authToken != null && authToken.isNotEmpty) {
      headers['Authorization'] = 'Bearer $authToken';
    }

    return headers;
  }

  /// Build a full URL for an endpoint
  static String buildUrl(String endpoint) {
    return '$baseUrl$endpoint';
  }

  /// Log API request for debugging
  static void logRequest(String method, String endpoint,
      {dynamic data, Map<String, dynamic>? queryParams}) {
    log('🌐 API $method: $endpoint');
    if (data != null) {
      if (data is Map<String, dynamic>) {
        log('📦 Data: $data');
      } else if (data.runtimeType.toString() == 'FormData') {
        log('📦 Data: FormData (not JSON-encodable)');
      } else {
        log('📦 Data: ${data.toString()}');
      }
    }
    if (queryParams != null) log('🔍 Query: $queryParams');
  }
}

// Authentication endpoints
class Auth {
  static const String login = '/login';
  static const String register = '/auth/register';
  static const String googleSignIn = '/auth/google';
  static const String resetPassword = '/auth/password-reset';
  static const String refreshToken = '/auth/refresh-token';
  static const String logout = '/auth/logout';
}

// User-related endpoints
class Users {
  static String profile(String userId) => '/users/$userId';
  static const String updateProfileImage = '/users/profile-image';
}

// Product category endpoints
class Categories {
  // L1 Categories
  static const String l1List = '/products/l1';
  static const String l1Add = '/products/l1';

  // L2 Categories
  static const String l2List = '/products/l2'; // Use with ?l1id=X query param
  static const String l2Add = '/products/l2';

  // L3 Categories
  static const String l3List = '/products/l3'; // Use with ?l2id=X query param
  static const String l3Add = '/products/l3';
}

// Product endpoints
class Products {
  // Keep your existing endpoints
  static String details(String productId) => '/products/$productId';
  static const String search = '/products'; // Use with ?query=X&category=Y
  static const String featured = '/products/featured';

  // Add these new endpoints
  static String related(String productId) => '/products/$productId/related';
  static String reviews(String productId) => '/products/$productId/reviews';
}

// Cart endpoints
class Cart {
  static String userCart(String userId) => '/carts/$userId';
  static const String addItem = '/carts';
  static String updateItem(String userId, String productId) =>
      '/carts/$userId/$productId';
  static String removeItem(String userId, String productId) =>
      '/carts/$userId/$productId';
  static String clearCart(String userId) => '/carts/$userId';
}

// Order endpoints
class Orders {
  static String userOrders(String userId) => '/orders/$userId';
  static const String createOrder = '/orders';
  static String orderDetails(String orderId) => '/orders/$orderId';
}

// Notification endpoints
class Notifications {
  static String userNotifications(String userId) => '/notifications/$userId';
  static String markAsRead(String notificationId) =>
      '/notifications/$notificationId/read';
  static String deleteNotification(String notificationId) =>
      '/notifications/$notificationId';
  static const String registerDevice = '/notifications/register-device';
}

// Search endpoints
class Search {
  static const String suggestions = '/search/suggestions';
  static const String history = '/search/history';
  static String userHistory(String userId) => '/search/history/$userId';
}

// User address endpoints
class UserAddresses {
  static String list(String userId) => '/users/$userId/addresses';
  static String details(String userId, String addressId) =>
      '/users/$userId/addresses/$addressId';
}
