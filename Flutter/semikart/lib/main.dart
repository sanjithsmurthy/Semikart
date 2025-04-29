import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/services.dart';
import 'package:Semikart/Components/login_signup/login_password.dart';
import 'package:logging/logging.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:Semikart/firebase_options.dart'; // Import Firebase Core
import 'base_scaffold.dart';
import 'managers/auth_manager.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

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
    const ProviderScope(
      child: MyApp(),
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
      ),
      home: const AuthWrapper(), // ⬅️ Important: AuthWrapper is the home widget
      debugShowCheckedModeBanner: false,
    );
  }
}

class AuthWrapper extends ConsumerWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Watch the provider to trigger rebuilds on state changes
    final authState = ref.watch(authManagerProvider);

    // --- Add diagnostic print statement ---
    // This will print every time AuthWrapper rebuilds, showing the current auth status.
    print("🔁 AuthWrapper: Building with AuthStatus = ${authState.status}");

    // Handle unknown state (initial check)
    if (authState.status == AuthStatus.unknown) {
      print(" -> AuthStatus is Unknown. Showing loading indicator.");
      return const Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: CircularProgressIndicator(
            color: Color(0xFFA51414),
          ),
        ),
      );
    }

    // Handle authenticated state
    if (authState.status == AuthStatus.authenticated) {
      print(" -> AuthStatus is Authenticated. Showing BaseScaffold.");
      // It's crucial that BaseScaffold uses its own Navigator keys
      // for internal navigation, separate from the root navigator.
      return BaseScaffold(
        key: BaseScaffold.navigatorKey, // Continue using the static key if required by AppNavigator
        initialIndex: 0,
      );
    }

    // Handle unauthenticated state (or any other state as fallback)
    // This block will execute if status is AuthStatus.unauthenticated
    print(" -> AuthStatus is Unauthenticated (or fallback). Showing LoginPasswordNewScreen.");
    return const LoginPasswordNewScreen();
  }
}
