import 'package:flutter/material.dart';
import '../Components/home/home_page.dart';
import '../Components/rfq_bom/rfq_full.dart';

class HomeNavigator extends StatelessWidget {
  final GlobalKey<NavigatorState> navigatorKey;

  const HomeNavigator({super.key, required this.navigatorKey});

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: navigatorKey,
      initialRoute: 'home',
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case 'rfq':
            return MaterialPageRoute(builder: (_) => const RFQFullPage());
          case 'home':
          default:
            return MaterialPageRoute(builder: (_) => const HomePageContent());
        }
      },
    );
  }
}
