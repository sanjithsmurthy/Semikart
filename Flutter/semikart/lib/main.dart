import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart'; // Import Riverpod
import 'Components/Login_SignUp/Loginpassword.dart';
import 'Components/Login_SignUp/LoginOTP.dart';
import 'Components/Login_SignUp/signupscreen.dart';
import 'Components/trial/testing.dart';
import 'managers/auth_manager.dart'; // Import AuthManager provider

void main() {
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

    // Navigate to different pages based on the mode
    return isTestingMode ? const TestingPage() : const LoginOptions();
  }
}

class LoginOptions extends ConsumerWidget {
  const LoginOptions({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login Options'),
        backgroundColor: const Color(0xFFA51414),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LoginPasswordScreen()),
                );
              },
              child: const Text('Login with Password'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LoginOTPScreen()),
                );
              },
              child: const Text('Login with OTP'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SignUpScreen()),
                );
              },
              child: const Text('Sign Up'),
            ),
            const SizedBox(height: 32),
            // Button to toggle testing mode
            ElevatedButton(
              onPressed: () {
                ref.read(authManagerProvider.notifier).toggleTestingMode();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.grey,
              ),
              child: const Text('Enter Testing Mode'),
            ),
          ],
        ),
      ),
    );
  }
}

class TestingPage extends ConsumerWidget {
  const TestingPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Testing Mode'),
        actions: [
          IconButton(
            icon: const Icon(Icons.swap_horiz),
            onPressed: () {
              // Toggle back to production mode
              ref.read(authManagerProvider.notifier).toggleTestingMode();
            },
          ),
        ],
      ),
      body: const ButtonNavigationPage(), // Call ButtonNavigationPage here
    );
  }
}