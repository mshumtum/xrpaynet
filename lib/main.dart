import 'package:flutter/material.dart';
import 'package:xr_paynet/components/screens/WelcomeScreens/SplashScreen.dart';
import 'package:xr_paynet/components/screens/lifeStylePlusKYC/LifeStylePlusKYC.dart';
import 'package:xr_paynet/core/Locator.dart';
import 'package:xr_paynet/core/navigation/navigation_service.dart';
import 'package:xr_paynet/core/navigation/routers.dart';
import 'package:xr_paynet/theme/AppTheme.dart';
import 'components/utilities/ClassMediaQuery.dart';
import 'package:flutter/services.dart';

import 'core/dependency_injection.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DependencyInjection.init();
  setupLocator();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    ClassMediaQuery(context);

    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      // statusBarColor: Colors.white,
      statusBarBrightness: Brightness.dark,
    ));
    return SafeArea(
      child: MaterialApp(
        title: 'XR PayNet',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            primarySwatch: AppTheme.black,
            platform: TargetPlatform.iOS,
            fontFamily: AppTheme.fontFamily),
        home: const SplashScreen(),
        navigatorKey: locator<NavigationService>().navigatorKey,
        onGenerateRoute: (settings) => Routers.toGenerateRoute(settings),
      ),
    );
  }
}
