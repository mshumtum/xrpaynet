import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:xr_paynet/components/screens/WelcomeScreens/SplashScreen.dart';
import 'package:xr_paynet/components/screens/card_recharge/CardRecharge.dart';
import 'package:xr_paynet/components/screens/homePage/HomePage.dart';
import 'package:xr_paynet/components/screens/onBoardingScreens/CreateAccount.dart';
import 'package:xr_paynet/components/screens/onBoardingScreens/LoginScreen.dart';
import 'package:xr_paynet/core/Locator.dart';
import 'package:xr_paynet/core/base_cubit/BaseRepository.dart';
import 'package:xr_paynet/core/base_cubit/BaseCubit.dart';
import 'package:xr_paynet/core/navigation/navigation_service.dart';
import 'package:xr_paynet/core/navigation/routers.dart';
import 'package:xr_paynet/theme/AppTheme.dart';
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
    return BlocProvider(
      create: (context) => BaseCubit(BaseRepo()),
      child: SafeArea(
        child: MaterialApp(
          title: 'XR PayNet',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
              primarySwatch: AppTheme.black,
              platform: TargetPlatform.iOS,
              fontFamily: AppTheme.fontFamily),
          home: const LoginScreen(),
          navigatorKey: locator<NavigationService>().navigatorKey,
          onGenerateRoute: (settings) => Routers.toGenerateRoute(settings),
        ),
      ),
    );
  }
}
