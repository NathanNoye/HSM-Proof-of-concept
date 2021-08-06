import 'package:get_it/get_it.dart';

import 'navigator.dart';

GetIt locator = GetIt.instance;

// Required locators required to run the app like a localization service
Future<void> essentialLocatorsReady() async {}

// Setup locators to be accessed
void setupLocator() {
  print('Setting up locators');

  locator.registerLazySingleton(() => HsmNavigator());
}
