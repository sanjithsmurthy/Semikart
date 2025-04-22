import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/services.dart';
import 'package:Semikart/Components/login_signup/login_password.dart'; // Import your login screen
import 'package:logging/logging.dart';
import 'base_scaffold.dart'; // Import BaseScaffold for the main app structure
import 'managers/auth_manager.dart'; // Import the AuthManager provider

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  // Lock Orientation
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  // ✅ System UI Overlay Style (Ensure flutter/services.dart is imported)
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.white,
    statusBarIconBrightness: Brightness.dark,
    systemNavigationBarColor: Colors.white,
    systemNavigationBarIconBrightness: Brightness.dark,
  ));

  _setupLogging();

  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

void _setupLogging() {
  Logger.root.level = Level.ALL;
  Logger.root.onRecord.listen((record) {
    debugPrint('${record.level.name}: ${record.loggerName}: ${record.message}');
    // Optional: Add more details like time, error, stacktrace
    // if (record.error != null) {
    //   debugPrint('Error: ${record.error}');
    // }
    // if (record.stackTrace != null) {
    //   debugPrint('StackTrace: ${record.stackTrace}');
    // }
  });
}

class MyApp extends StatelessWidget { // Can be StatelessWidget as AuthWrapper handles state changes
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      title: 'Semikart',
      theme: ThemeData(
        // Define your app's theme
        primaryColor: const Color(0xFFA51414), // Example primary color
        scaffoldBackgroundColor: Colors.white, // Example background color
        // Add other theme properties like primarySwatch, textTheme, etc.
        primarySwatch: Colors.red, // Keep or adjust as needed
        visualDensity: VisualDensity.adaptivePlatformDensity, // Standard density
      ),
      // *** Use AuthWrapper as the home widget ***
      // AuthWrapper will decide whether to show LoginPasswordNewScreen or BaseScaffold
      home: const AuthWrapper(),
      debugShowCheckedModeBanner: false,
    );
  }
}

/// This widget acts as a gatekeeper, showing the appropriate UI
/// based on the user's authentication status.
class AuthWrapper extends ConsumerWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Listen to the authentication state provided by AuthManager
    final authState = ref.watch(authManagerProvider);

    // Handle the initial state while checking authentication status
    if (authState.status == AuthStatus.unknown) {
      print("AuthWrapper: State is Unknown. Showing Loading Indicator.");
      // Show a loading indicator while checking auth status
      return const Scaffold(
        backgroundColor: Colors.white, // Match app background
        body: Center(
          child: CircularProgressIndicator(
            color: Color(0xFFA51414), // Use app's primary color
          ),
        ),
      );
    }

    // Determine which screen to show based on the authentication status
    if (authState.status == AuthStatus.authenticated) {
      // User is logged in - Show the main application structure (BaseScaffold)
      // BaseScaffold internally shows HomePageContent as the first tab (index 0)
      print("AuthWrapper: State is Authenticated. Showing BaseScaffold.");
      return BaseScaffold(
        key: BaseScaffold.navigatorKey, // Assign the static key
        initialIndex: 0, // Start on the home tab (which contains HomePageContent)
      );
    } else {
      // User is not logged in (AuthStatus.unauthenticated) - Show the Login Screen
      print("AuthWrapper: State is Unauthenticated. Showing LoginPasswordScreen.");
      return const LoginPasswordNewScreen(); // Your designated login screen widget
    }
  }
}
