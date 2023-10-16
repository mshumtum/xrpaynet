import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:xr_paynet/components/screens/WelcomeScreens/SplashScreen.dart';
import 'package:xr_paynet/components/screens/activationFeesScreens/LSPFeeByLockXRP.dart';
import 'package:xr_paynet/components/screens/activeCardScreens/ActiveVirtualCards.dart';
import 'package:xr_paynet/components/screens/appliedCardScreens/LifeStylePlusApplied.dart';
import 'package:xr_paynet/components/screens/card_recharge/CardRecharge.dart';
import 'package:xr_paynet/components/screens/homePage/HomePage.dart';
import 'package:xr_paynet/components/screens/lifeStylePlusKYC/LspSuccessScreen.dart';
import 'package:xr_paynet/core/Locator.dart';
import 'package:xr_paynet/core/navigation/navigation_service.dart';
import 'package:xr_paynet/core/navigation/routers.dart';
import 'package:xr_paynet/theme/AppTheme.dart';
import 'components/screens/lifeStylePlusKYC/LifeStylePlusKYC.dart';
import 'components/screens/lifeStylePlusKYC/_link_card.dart';
import 'components/utilities/ClassMediaQuery.dart';
import 'package:flutter/services.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
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
            platform: TargetPlatform.fuchsia,
            fontFamily: AppTheme.fontFamily),
        home: const SplashScreen(),
        navigatorKey: locator<NavigationService>().navigatorKey,
        onGenerateRoute: (settings) => Routers.toGenerateRoute(settings),
      ),
    );
  }
}
