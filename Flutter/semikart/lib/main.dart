import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/services.dart'; // Ensure this is imported
import 'package:Semikart/Components/login_signup/login_password.dart';
import 'package:logging/logging.dart'; // Assuming this is needed
import 'base_scaffold.dart'; // Import BaseScaffold
import 'managers/auth_manager.dart'; // Assuming this is needed

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
  });
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      title: 'Semikart',
      theme: ThemeData(
        primarySwatch: Colors.red, // Or your custom theme
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      debugShowCheckedModeBanner: false,
      home: BaseScaffold(
        key: BaseScaffold.navigatorKey, // <<< CORRECT
        initialIndex: 0,
      ),
    );
  }
}
