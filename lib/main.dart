import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'app.dart';
import 'core/locator.dart';

Future<void> main() async {
  setupLocator();

  // Instantiate our essentials and load data
  await init();
  // add these lines
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(MyApp());
}

Future<void> init() async {
  // Let's not get ahead of ourselves
  await essentialLocatorsReady();
}
