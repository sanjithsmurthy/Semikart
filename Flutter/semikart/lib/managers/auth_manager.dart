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
  // You could add more user details here if needed (e.g., User object from Firebase Auth or your backend)

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
  final FlutterSecureStorage _storage = const FlutterSecureStorage(
    // Optional: Configure Android options for encrypted shared preferences
    // aOptions: AndroidOptions(encryptedSharedPreferences: true),
  );
  final String _tokenKey = 'auth_token'; // Key for storing the token in secure storage
  // --- New Key for First Launch Flag ---
  final String _firstLaunchKey = 'has_launched_before'; // Key for first launch flag

  /// Initializes the AuthManager and checks the initial authentication state.
  AuthManager() : super(const AuthState.unknown()) {
    // Use a microtask to ensure the check runs after the constructor completes
    // This prevents potential issues if the check completes synchronously during construction.
    Future.microtask(() => _checkInitialAuthState());
  }

  /// Checks secure storage for an existing token and first launch status on app startup.
  Future<void> _checkInitialAuthState() async {
    print("AuthManager: Checking initial authentication state...");
    try {
      // Read both values concurrently for efficiency
      final results = await Future.wait([
        _storage.read(key: _tokenKey),
        _storage.read(key: _firstLaunchKey), // Read the first launch flag
      ]);
      final token = results[0];
      final hasLaunchedBeforeStr = results[1];
      final bool hasLaunchedBefore = hasLaunchedBeforeStr == 'true'; // Check if flag is 'true'

      if (!mounted) return; // Check if the notifier is still mounted before updating state

      if (!hasLaunchedBefore) {
        // --- First Launch Ever ---
        print("AuthManager: First launch detected. Forcing unauthenticated state.");
        state = const AuthState.unauthenticated(); // Show login screen

        // Set the flag in storage so this block doesn't run again
        try {
          await _storage.write(key: _firstLaunchKey, value: 'true');
          print("AuthManager: 'hasLaunchedBefore' flag set successfully.");
        } catch (writeError) {
          // Log error but proceed; the app will just show login again next time if write failed
          print("AuthManager: Error setting 'hasLaunchedBefore' flag: $writeError");
        }
      } else {
        // --- Not the First Launch ---
        print("AuthManager: Not first launch. Checking token...");
        if (token != null && token.isNotEmpty) {
          // Subsequent launch & token exists: User is logged in
          state = AuthState(status: AuthStatus.authenticated, userToken: token);
          print("AuthManager: User is authenticated from storage (Token: $token).");
        } else {
          // Subsequent launch & no token: User is logged out
          state = const AuthState.unauthenticated();
          print("AuthManager: User is unauthenticated (No token found).");
        }
      }
    } catch (e) {
      // Handle potential errors reading from storage
      print("AuthManager: Error checking initial auth state: $e");
      if (mounted) {
        // Default to unauthenticated on error, but respect first launch logic if possible
        final hasLaunchedBeforeStr = await _storage.read(key: _firstLaunchKey);
        if (hasLaunchedBeforeStr != 'true') {
           print("AuthManager: Error occurred, but likely first launch. Setting unauthenticated.");
           state = const AuthState.unauthenticated();
           // Attempt to set the flag again in case the error was reading it
           try { await _storage.write(key: _firstLaunchKey, value: 'true'); } catch (_) {}
        } else {
           print("AuthManager: Error occurred on subsequent launch. Setting unauthenticated.");
           state = const AuthState.unauthenticated();
        }
      }
    }
  }


  /// Simulates a login process with email and password.
  ///
  /// Replace the simulation with your actual API call.
  /// Returns `true` on successful login, `false` otherwise.
  Future<bool> login(String email, String password) async {
    print("AuthManager: Attempting login for $email...");
    // --- Simulate API Call ---
    await Future.delayed(const Duration(seconds: 1)); // Simulate network delay

    // TODO: Replace this with your actual API call and validation
    // Example: final response = await yourApiService.login(email, password);
    // if (response.isSuccessful && response.token != null) { ... }

    // Simulate success for any non-empty credentials for now
    if (email.isNotEmpty && password.isNotEmpty) {
      const fakeToken = "fake_jwt_token_12345"; // Simulate receiving a token

      try {
        // --- Store Token ---
        await _storage.write(key: _tokenKey, value: fakeToken);

        // --- Update State ---
        if (mounted) {
          state = AuthState(status: AuthStatus.authenticated, userToken: fakeToken);
        }
        print("AuthManager: Login successful.");
        return true; // Indicate success
      } catch (e) {
        print("AuthManager: Error saving token during login: $e");
        if (mounted) {
          state = const AuthState.unauthenticated(); // Revert state on error
        }
        return false; // Indicate failure
      }
    } else {
      // --- Login Failed ---
      print("AuthManager: Login failed (Invalid credentials in simulation).");
      // Ensure state is unauthenticated
      if (mounted && state.status != AuthStatus.unauthenticated) {
         state = const AuthState.unauthenticated();
      }
      return false; // Indicate failure
    }
  }

  /// Simulates a signup process (optional).
  ///
  /// Replace the simulation with your actual API call.
  /// Returns `true` on successful signup (and potential auto-login), `false` otherwise.
  Future<bool> signUp(String email, String password, String name) async {
    print("AuthManager: Attempting signup for $email...");
    // --- Simulate API Call for Signup ---
    await Future.delayed(const Duration(seconds: 1));

    // TODO: Replace with your actual signup API call
    // Example: final response = await yourApiService.signUp(email, password, name);
    // if (response.isSuccessful && response.token != null) { ... }

    // Assume signup is successful and potentially logs the user in immediately
    const fakeToken = "fake_jwt_token_after_signup_67890";

    try {
      await _storage.write(key: _tokenKey, value: fakeToken);
      if (mounted) {
        state = AuthState(status: AuthStatus.authenticated, userToken: fakeToken);
      }
      print("AuthManager: Signup successful and user logged in.");
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
      // --- Clear Token ---
      await _storage.delete(key: _tokenKey);

      // --- Update State ---
      if (mounted) {
        state = const AuthState.unauthenticated();
      }
      print("AuthManager: User logged out successfully.");
    } catch (e) {
      print("AuthManager: Error during logout: $e");
      // Even if deletion fails, set state to unauthenticated for safety
      if (mounted) {
        state = const AuthState.unauthenticated();
      }
    }
  }
}

// --- Provider Definition ---

/// The global provider for accessing the [AuthManager] instance and its [AuthState].
///
/// Use `ref.watch(authManagerProvider)` to listen to state changes in widgets.
/// Use `ref.read(authManagerProvider.notifier)` to call methods like `login`, `logout`.
final authManagerProvider = StateNotifierProvider<AuthManager, AuthState>((ref) {
  return AuthManager();
});