import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/services.dart';
import 'package:Semikart/Components/login_signup/login_password.dart';
import 'package:logging/logging.dart';
import 'base_scaffold.dart'; // Import BaseScaffold directly
import 'managers/auth_manager.dart'; // Import AuthManager provider

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  // Lock Orientation
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  // Set System UI Styles
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.white, // White status bar
      statusBarIconBrightness: Brightness.dark, // Dark icons for status bar
      systemNavigationBarColor: Colors.white, // White navigation bar
      systemNavigationBarIconBrightness: Brightness.dark, // Dark icons for navigation bar
    ),
  );

  // Configure logging
  _setupLogging();

  runApp(
    const ProviderScope( // Initialize Riverpod
      child: MyApp(),
    ),
  );
}

// Logging setup function
void _setupLogging() {
  Logger.root.level = Level.ALL; // Log messages of all levels
  Logger.root.onRecord.listen((record) {
    // Simple console output: [LEVEL] logger_name: message
    debugPrint('${record.level.name}: ${record.loggerName}: ${record.message}');
    // You could add more details like time, error, stacktrace if needed:
    // print('${record.level.name}: ${record.time}: ${record.loggerName}: ${record.message}');
    // if (record.error != null) {
    //   print('Error: ${record.error}');
    // }
    // if (record.stackTrace != null) {
    //   print('StackTrace: ${record.stackTrace}');
    // }
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Semikart',
      theme: ThemeData(
        primaryColor: const Color(0xFFA51414),
        scaffoldBackgroundColor: Colors.white,
        fontFamily: 'Product Sans',
      ),
      home: const AuthWrapper(), // Use AuthWrapper to decide the initial screen
      debugShowCheckedModeBanner: false,
      // Define routes for pre-login navigation if needed
      // routes: {
      //   '/signup': (context) => SignUpScreen(), // Example
      // },
    );
  }
}

/// This widget decides which UI flow to show based on auth state.
class AuthWrapper extends ConsumerWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Watch the authentication state from the provider
    final authState = ref.watch(authManagerProvider);

    // --- Handle Initial Unknown/Loading State ---
    if (authState.status == AuthStatus.unknown) {
      print("AuthWrapper: State is Unknown. Showing Loading Indicator.");
      // Show a loading indicator while checking storage
      return const Scaffold(
        body: Center(child: CircularProgressIndicator(color: Color(0xFFA51414))), // Use app's primary color
      );
    }

    // --- Determine Screen based on Status ---
    // *** CORRECTED CHECK: Use authState.status ***
    if (authState.status == AuthStatus.authenticated) {
      // User is logged in - Show the main app structure
      print("AuthWrapper: State is Authenticated. Showing BaseScaffold.");
      return const BaseScaffold();
    } else {
      // User is not logged in (AuthStatus.unauthenticated)
      print("AuthWrapper: State is Unauthenticated. Showing LoginPasswordScreen.");
      return LoginPasswordScreen(); // Show the pre-login entry screen
    }
  }
}