import 'package:get_it/get_it.dart';

import 'navigation/navigation_service.dart';

GetIt locator = GetIt.instance;
// final sl = GetIt.instance;

void setupLocator(){
  locator.registerLazySingleton(() => NavigationService());
}