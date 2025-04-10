import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AuthManager extends StateNotifier<bool> {
  AuthManager() : super(false); // Initial state: production mode

  // Toggle between testing and production modes
  void toggleTestingMode() {
    state = !state;
  }

  // Check if the app is in testing mode
  bool get isTestingMode => state;
}

// Riverpod provider for AuthManager
final authManagerProvider = StateNotifierProvider<AuthManager, bool>(
  (ref) => AuthManager(),
);