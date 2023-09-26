import 'package:flutter/material.dart';
import 'package:xr_paynet/core/Locator.dart';
import 'package:xr_paynet/core/navigation/navigation_service.dart';
import 'package:xr_paynet/core/navigation/routers.dart';
import 'package:xr_paynet/theme/AppTheme.dart';
import 'components/screens/cards_screens/ClubCard.dart';
import 'components/screens/cards_screens/LifeStylePlusCards.dart';
import 'components/utilities/ClassMediaQuery.dart';
import 'package:flutter/services.dart';

Future<void> main() async {
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
        home: const LifeStylePlusCards(),
        navigatorKey: locator<NavigationService>().navigatorKey,
        onGenerateRoute: (settings) => Routers.toGenerateRoute(settings),
      ),
    );
  }
}
