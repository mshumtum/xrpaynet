import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:xr_paynet/components/screens/WelcomeScreen.dart';
import 'package:xr_paynet/theme/AppTheme.dart';
import 'components/core/Locator.dart';
import 'components/core/bloc_providers.dart';
import 'components/core/navigation/navigation_service.dart';
import 'components/core/navigation/routers.dart';
import 'components/core/injection_container.dart' as di;



Future<void> main() async {
  // Service Locator Initialization
  // await di.init();
  setupLocator();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // SystemChrome.setPreferredOrientations([
    //   DeviceOrientation.portraitUp,
    //   DeviceOrientation.portraitDown,
    // ]);
    // return MultiBlocProvider(
    //   providers: BlocProviders.toGenerateProviders(),
    //   child: Builder(
    //     builder: (context) {
    //       return MaterialApp(
    //         home: const WelcomeScreen(),
    //         navigatorKey: di.sl<NavigationService>().navigatorKey,
    //         onGenerateRoute: (settings) =>
    //             Routers.toGenerateRoute(settings),
    //         debugShowCheckedModeBanner: false,
    //       );
    //     },
    //   ),
    // );
    return MaterialApp(
      title: 'Flutter UI',
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
