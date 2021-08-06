import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hsm_poc/core/navigator.dart';
import 'package:hsm_poc/views/home_screen.dart';
import 'package:provider/provider.dart';

import 'core/locator.dart';

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => locator<HsmNavigator>())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'HSM POC App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: HomeScreen(),
      ),
    );
  }
}
