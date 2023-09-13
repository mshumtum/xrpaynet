import 'package:flutter/material.dart';
import 'package:xr_paynet/components/screens/WelcomeScreen.dart';
import 'package:xr_paynet/theme/AppTheme.dart';
import 'components/core/Locator.dart';
import 'components/core/navigation/navigation_service.dart';
import 'components/core/navigation/routers.dart';

Future<void> main() async {
  setupLocator();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'XR PayNet',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: AppTheme.black,
        platform: TargetPlatform.iOS,
      ),
      home: const WelcomeScreen(),
      navigatorKey: locator<NavigationService>().navigatorKey,
      onGenerateRoute: (settings) => Routers.toGenerateRoute(settings),
    );
  }
}
