import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:dio/dio.dart';
import 'package:cookie_jar/cookie_jar.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:async'; // Import for Future
// import 'package:cookie_jar/file_storage.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'dart:io'; // Import for Directory
import 'package:path/path.dart' as path; // Import for path manipulation

// --- State Definition ---

/// Represents the possible authentication states.
enum AuthStatus {
  unknown, // Initial state before checking storage
  authenticated,
  unauthenticated,
}

/// Holds the current authentication state details.
class AuthState {
  final AuthStatus status;
  final String? userToken; // Example: Store a token upon login

  const AuthState({required this.status, this.userToken});

  /// Initial state before checking persistence.
  const AuthState.unknown() : status = AuthStatus.unknown, userToken = null;

  /// State when user is not logged in.
  const AuthState.unauthenticated() : status = AuthStatus.unauthenticated, userToken = null;
}

// --- State Notifier ---

/// Manages the application's authentication state.
/// Handles login, logout, signup, and checks initial authentication
/// status using secure storage for persistence.
class AuthManager extends StateNotifier<AuthState> {
  final FlutterSecureStorage _storage = const FlutterSecureStorage();
  final String _tokenKey = 'auth_token'; // Key for storing the token
  final Dio _dio = Dio();
  PersistCookieJar? _persistentCookies;
  final String url = "https://www.xxxx.in/rest/user/login.json";

  /// Initializes the AuthManager and checks the initial authentication state.
  AuthManager() : super(const AuthState.unknown()) {
    Future.microtask(() => _checkInitialAuthState());
    initializeDio();
  }

  /// Initializes Dio and persistent cookies.
  Future<void> initializeDio() async {
    final Directory dir = await _localCookieDirectory;
    final cookiePath = dir.path;
    _persistentCookies = PersistCookieJar(storage: FileStorage(cookiePath)); // Fixed FileStorage usage
    _dio.interceptors.add(CookieManager(_persistentCookies!));
    _dio.options = BaseOptions(
      baseUrl: url,
      contentType: Headers.jsonContentType,
      responseType: ResponseType.plain,
      headers: {
        HttpHeaders.userAgentHeader: "dio",
        "Connection": "keep-alive",
      },
    );
  }

  Future<Directory> get _localCookieDirectory async {
    final path = await _localPath;
    final Directory dir = Directory('$path/cookies');
    await dir.create(recursive: true);
    return dir;
  }

  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  /// Fetches CSRF token from the server.
  Future<String?> getCsrftoken() async {
    try {
      String? csrfTokenValue;
      _dio.interceptors.add(
        InterceptorsWrapper(
          onResponse: (Response response, ResponseInterceptorHandler handler) async {
            List<Cookie> cookies = await _persistentCookies!.loadForRequest(Uri.parse(url));
            csrfTokenValue = cookies.firstWhere((c) => c.name == 'csrftoken', orElse: () => Cookie('', '')).value;
            if (csrfTokenValue != null) {
              _dio.options.headers['X-CSRF-TOKEN'] = csrfTokenValue;
            }
            handler.next(response);
          },
        ),
      );
      await _dio.get(url);
      return csrfTokenValue;
    } catch (error) {
      print("Error fetching CSRF token: $error");
      return null;
    }
  }

  /// Checks secure storage for an existing token on app startup.
  Future<void> _checkInitialAuthState() async {
    print("AuthManager: Checking initial authentication state...");
    try {
      final token = await _storage.read(key: _tokenKey);

      if (!mounted) return;

      if (token != null && token.isNotEmpty) {
        state = AuthState(status: AuthStatus.authenticated, userToken: token);
        print("AuthManager: User is authenticated from storage (Token found).");
      } else {
        state = const AuthState.unauthenticated();
        print("AuthManager: User is unauthenticated (No token found or token is empty).");
      }
    } catch (e) {
      print("AuthManager: Error checking initial auth state: $e");
      if (mounted) {
        state = const AuthState.unauthenticated();
        print("AuthManager: Setting state to unauthenticated due to error.");
      }
    }
  }

  /// Handles login with CSRF token validation.
  Future<bool> login(String email, String password) async {
    print("AuthManager: Attempting login for $email...");
    try {
      final csrf = await getCsrftoken();
      if (csrf == null) {
        print("AuthManager: Failed to fetch CSRF token.");
        return false;
      }

      FormData formData = FormData.fromMap({
        "username": email,
        "password": password,
        "csrfmiddlewaretoken": csrf,
      });

      Response response = await _dio.post(url, data: formData);
      if (response.statusCode == 200) {
        const fakeToken = "fake_jwt_token_12345"; // Simulate receiving a token
        await _storage.write(key: _tokenKey, value: fakeToken);

        if (mounted) {
          state = AuthState(status: AuthStatus.authenticated, userToken: fakeToken);
        }
        return true;
      }

      return false;
    } catch (e) {
      print("AuthManager: Login error: $e");
      return false;
    }
  }

  /// Simulates a logout process.
  Future<void> logout() async {
    print("AuthManager: Logging out...");
    try {
      await _storage.delete(key: _tokenKey);
      _persistentCookies?.deleteAll();

      if (mounted) {
        state = const AuthState.unauthenticated();
      }
    } catch (e) {
      print("AuthManager: Logout error: $e");
    }
  }
}

final authManagerProvider = StateNotifierProvider<AuthManager, AuthState>((ref) {
  return AuthManager();
});