import 'package:flutter_riverpod/flutter_riverpod.dart';

// Provider to hold the currently selected login method ('Email' or 'Mobile')
final loginMethodProvider = StateProvider<String>((ref) {
  // Default value when the provider is first created
  return 'Email';
});

// You could add other login form related providers here in the future
// final rememberMeProvider = StateProvider<bool>((ref) => false);