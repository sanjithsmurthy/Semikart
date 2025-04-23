import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/services.dart';
import 'package:Semikart/Components/login_signup/login_password.dart';
import 'package:logging/logging.dart';
import 'base_scaffold.dart';
import 'managers/auth_manager.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

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
    final authState = ref.watch(authManagerProvider);

    print("🔁 AuthWrapper: Status is ${authState.status}"); // Debug print

    if (authState.status == AuthStatus.unknown) {
      return const Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: CircularProgressIndicator(
            color: Color(0xFFA51414),
          ),
        ),
      );
    }

    if (authState.status == AuthStatus.authenticated) {
      return BaseScaffold(
        key: BaseScaffold.navigatorKey,
        initialIndex: 0,
      );
    }

    // If unauthenticated or fallback
    return const LoginPasswordNewScreen();
  }
}
