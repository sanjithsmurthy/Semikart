import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/services.dart';
import 'package:Semikart/Components/login_signup/login_password.dart';
import 'package:logging/logging.dart';
import 'package:shared_preferences/shared_preferences.dart'; // Add this import
import 'base_scaffold.dart';
import 'managers/auth_manager.dart'; // Import the AuthManager with sharedPreferencesProvider

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize SharedPreferences
  final prefs = await SharedPreferences.getInstance();

  // Lock Orientation
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.white,
    statusBarIconBrightness: Brightness.dark,
    systemNavigationBarColor: Colors.white,
    systemNavigationBarIconBrightness: Brightness.dark,
  ));

  _setupLogging();

  runApp(
    ProviderScope(
      overrides: [
        // Initialize sharedPreferencesProvider with the actual instance
        sharedPreferencesProvider.overrideWithValue(prefs),
      ],
      child: const MyApp(),
    ),
  );
}

void _setupLogging() {
  Logger.root.level = Level.ALL;
  Logger.root.onRecord.listen((record) {
    debugPrint('${record.level.name}: ${record.loggerName}: ${record.message}');
  });
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      title: 'Semikart',
      theme: ThemeData(
        primaryColor: const Color(0xFFA51414),
        scaffoldBackgroundColor: Colors.white,
        textSelectionTheme: const TextSelectionThemeData(
          cursorColor: Color(0xFFA51414),
          selectionColor: Color(0xAAEFA0A0), // Lighter red for selection
          selectionHandleColor: Color(0xFFA51414),
        ),
      ),
      home: const AuthWrapper(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class AuthWrapper extends ConsumerWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Watch the AuthManager's state
    final authState = ref.watch(authManagerProvider);

    print("🔁 AuthWrapper: Building with AuthStatus = ${authState.status}");

    // Listen for error messages from AuthManager and show Snackbars
    ref.listen<AuthState>(authManagerProvider, (previous, next) {
      if (next.errorMessage != null && next.errorMessage != previous?.errorMessage) {
        // Ensure context is still valid before showing Snackbar
        if (ScaffoldMessenger.maybeOf(context) != null) {
           ScaffoldMessenger.of(context).showSnackBar(
             SnackBar(
               content: Text(next.errorMessage!),
               backgroundColor: Colors.redAccent,
               duration: const Duration(seconds: 4),
             ),
           );
           // Optionally clear the error in the state after showing it
           // ref.read(authManagerProvider.notifier).clearError(); // Add a clearError method if needed
        } else {
           print("AuthWrapper: Cannot show Snackbar, ScaffoldMessenger not found.");
        }
      }
    });


    switch (authState.status) {
      case AuthStatus.unknown:
        print(" -> AuthStatus is Unknown. Showing loading indicator.");
        return const Scaffold(
          backgroundColor: Colors.white,
          body: Center(
            child: CircularProgressIndicator(
              color: Color(0xFFA51414),
            ),
          ),
        );
      case AuthStatus.authenticated:
        // print(" -> AuthStatus is Authenticated (User: ${authState.user?.uid}). Showing AuthRedirector.");
        // Return the redirector instead of BaseScaffold directly
        return const AuthRedirector();
      case AuthStatus.unauthenticated:
        print(" -> AuthStatus is Unauthenticated. Showing LoginPasswordNewScreen.");
        return const LoginPasswordNewScreen();
    }
  }
}

// +++ Add AuthRedirector Widget +++
class AuthRedirector extends StatefulWidget {
  const AuthRedirector({super.key});

  @override
  State<AuthRedirector> createState() => _AuthRedirectorState();
}

class _AuthRedirectorState extends State<AuthRedirector> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) { // Ensure widget is still mounted
         print("🔄 AuthRedirector: Navigating to BaseScaffold...");
         // Use pushReplacement to avoid having the redirector in the back stack
         Navigator.of(context).pushReplacement(
           MaterialPageRoute(
             builder: (context) => BaseScaffold(
               key: BaseScaffold.navigatorKey, // Use the key here
               initialIndex: 0,
             ),
           ),
         );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // Show a minimal loading indicator while redirecting
    print("🔄 AuthRedirector: Building processing screen..."); // Updated log
    return const Scaffold(
      backgroundColor: Colors.white, // Change background to white
      body: Center(
        child: Column( // Center content vertically
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(
              color: Color(0xFFA51414),
            ),
            SizedBox(height: 16), // Add some space
            Text(
              "Processing...",
              style: TextStyle(
                color: Colors.black54,
                fontSize: 16,
                decoration: TextDecoration.none, // Ensure no underline
                fontFamily: 'Roboto', // Use a known font
              ),
              textDirection: TextDirection.ltr,
            ),
          ],
        ),
      ),
    );
  }
}
// +++ End AuthRedirector Widget +++
