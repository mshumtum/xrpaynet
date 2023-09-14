import 'package:flutter/material.dart';
import 'package:xr_paynet/components/screens/WelcomeScreen.dart';
import 'package:xr_paynet/core/Locator.dart';
import 'package:xr_paynet/core/navigation/navigation_service.dart';
import 'package:xr_paynet/core/navigation/routers.dart';
import 'package:xr_paynet/theme/AppTheme.dart';
import 'components/utilities/ClassMediaQuery.dart';

Future<void> main() async {
  setupLocator();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    ClassMediaQuery(context);
    return SafeArea(
      child: MaterialApp(
        title: 'XR PayNet',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: AppTheme.black,
          platform: TargetPlatform.iOS,
        ),
        home: const WelcomeScreen(),
        navigatorKey: locator<NavigationService>().navigatorKey,
        onGenerateRoute: (settings) => Routers.toGenerateRoute(settings),
      ),
    );
  }
}
