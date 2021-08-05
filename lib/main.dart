import 'package:flutter/material.dart';

import 'app.dart';
import 'core/locator.dart';

Future<void> main() async {
  setupLocator();

  // Instantiate our essentials and load data
  await init();
  //SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
  //    .then((_) {
  runApp(MyApp());
  //});
}

Future<void> init() async {
  // Let's not get ahead of ourselves
  await essentialLocatorsReady();
}
