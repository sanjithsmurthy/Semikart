import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'dart:async'; // Import for Future

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
///
/// Handles login, logout, signup, and checks initial authentication
/// status using secure storage for persistence.
class AuthManager extends StateNotifier<AuthState> {
  final FlutterSecureStorage _storage = const FlutterSecureStorage();
  final String _tokenKey = 'auth_token'; // Key for storing the token

  // --- REMOVED First Launch Key ---
  // final String _firstLaunchKey = 'has_launched_before';

  /// Initializes the AuthManager and checks the initial authentication state.
  AuthManager() : super(const AuthState.unknown()) {
    // Check the initial state immediately or after a microtask
    // Using microtask is slightly safer if initialization involves async work
    Future.microtask(() => _checkInitialAuthState());
  }

  /// Checks secure storage for an existing token on app startup.
  Future<void> _checkInitialAuthState() async {
    print("AuthManager: Checking initial authentication state...");
    try {
      // --- Only check for the token ---
      final token = await _storage.read(key: _tokenKey);

      if (!mounted) return; // Check if the notifier is still mounted

      if (token != null && token.isNotEmpty) {
        // Token exists: User has logged in before and not logged out
        state = AuthState(status: AuthStatus.authenticated, userToken: token);
        print("AuthManager: User is authenticated from storage (Token found).");
      } else {
        // No token: User has never logged in, or has logged out
        state = const AuthState.unauthenticated();
        print("AuthManager: User is unauthenticated (No token found or token is empty).");
      }
    } catch (e) {
      // Handle potential errors reading from storage
      print("AuthManager: Error checking initial auth state: $e");
      if (mounted) {
        // Default to unauthenticated on error
        state = const AuthState.unauthenticated();
        print("AuthManager: Setting state to unauthenticated due to error.");
      }
    }
  }

  /// Simulates a login process with email and password.
  Future<bool> login(String email, String password) async {
    print("AuthManager: Attempting login for $email...");
    // --- Simulate API Call ---
    await Future.delayed(const Duration(seconds: 1));

    // TODO: Replace this with your actual API call and validation
    if (email.isNotEmpty && password.isNotEmpty) {
      const fakeToken = "fake_jwt_token_12345"; // Simulate receiving a token

      try {
        await _storage.write(key: _tokenKey, value: fakeToken);
        if (mounted) {
          state = AuthState(status: AuthStatus.authenticated, userToken: fakeToken);
        }
        print("AuthManager: Login successful. Token stored.");
        return true;
      } catch (e) {
        print("AuthManager: Error saving token during login: $e");
        if (mounted) {
          state = const AuthState.unauthenticated(); // Revert state on error
        }
        return false;
      }
    } else {
      print("AuthManager: Login failed (Simulated invalid credentials).");
      if (mounted && state.status != AuthStatus.unauthenticated) {
         state = const AuthState.unauthenticated();
      }
      return false;
    }
  }

  /// Simulates a signup process (optional).
  Future<bool> signUp(String email, String password, String name) async {
    print("AuthManager: Attempting signup for $email...");
    // --- Simulate API Call for Signup ---
    await Future.delayed(const Duration(seconds: 1));

    // TODO: Replace with your actual signup API call
    const fakeToken = "fake_jwt_token_after_signup_67890";

    try {
      await _storage.write(key: _tokenKey, value: fakeToken);
      if (mounted) {
        state = AuthState(status: AuthStatus.authenticated, userToken: fakeToken);
      }
      print("AuthManager: Signup successful and user logged in. Token stored.");
      return true;
    } catch (e) {
      print("AuthManager: Error saving token after signup: $e");
      if (mounted) {
        state = const AuthState.unauthenticated();
      }
      return false;
    }
  }


  /// Logs the user out by clearing the stored token and updating the state.
  Future<void> logout() async {
    print("AuthManager: Attempting logout...");
    try {
      await _storage.delete(key: _tokenKey);
      print("AuthManager: Token deleted from storage.");
      // Ensure state is updated *after* successful deletion
      if (mounted) {
        state = const AuthState.unauthenticated();
        print("AuthManager: State set to unauthenticated."); // Confirm state change
      } else {
        print("AuthManager: AuthManager is not mounted after logout. State not updated immediately.");
      }
    } catch (e) {
      print("AuthManager: Error deleting token during logout: $e");
      // Even on error, attempt to set state to unauthenticated
      if (mounted) {
        state = const AuthState.unauthenticated();
        print("AuthManager: State set to unauthenticated despite error during token deletion."); // Confirm state change
      }
    }
  }
}

// --- Provider Definition ---
final authManagerProvider = StateNotifierProvider<AuthManager, AuthState>((ref) {
  return AuthManager();
});