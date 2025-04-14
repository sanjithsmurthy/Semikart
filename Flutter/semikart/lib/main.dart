import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart'; // Import Riverpod
import 'package:flutter/services.dart'; // Import SystemChrome
import 'package:semikart/Components/Login_SignUp/Loginpassword.dart';
import 'Components/trial/testing.dart'; // Import ButtonNavigationPage
import 'managers/auth_manager.dart'; // Import AuthManager provider

void main() {
  // Set global status bar and navigation bar styles
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.grey, // White background for the status bar
      statusBarIconBrightness: Brightness.dark, // Dark icons for visibility
      systemNavigationBarColor: Colors.white, // White background for the bottom navigation bar
      systemNavigationBarIconBrightness: Brightness.dark, // Dark icons for visibility
    ),
  );

  runApp(
    ProviderScope( // Initialize Riverpod
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Semikart Components',
      theme: ThemeData(
        primaryColor: const Color(0xFFA51414),
        scaffoldBackgroundColor: Colors.white,
      ),
      home: const ModeWrapper(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class ModeWrapper extends ConsumerWidget {
  const ModeWrapper({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Watch the current testing mode state
    final isTestingMode = ref.watch(authManagerProvider);

    // Navigate to LoginPasswordScreen by default
    return Scaffold(
      body: LoginPasswordScreen(), // Display LoginPasswordScreen
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navigate to testing.dart when the button is clicked
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const ButtonNavigationPage()),
          );
        },
        backgroundColor: isTestingMode ? Colors.green : Colors.grey,
        child: const Icon(Icons.bug_report), // Icon for testing mode
      ),
    );
  }
}