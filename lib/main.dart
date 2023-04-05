import 'package:teknikaltest/app/routes.gr.dart';
import 'package:teknikaltest/utils/theme.dart';
import 'package:flutter/material.dart' hide Router;
import 'package:stacked_services/stacked_services.dart';
import 'utils/session.dart';
import 'package:flutter/services.dart';

import 'app/locator.dart';

import 'dart:io';

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  HttpOverrides.global = new MyHttpOverrides();
  await sessions.initialize();
  setupLocator();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MaterialApp(
      title: 'Smart Office Customer',
      debugShowCheckedModeBanner: false,
      theme: getTheme(context),
      navigatorKey: locator<NavigationService>().navigatorKey,
      onGenerateRoute: Routers().onGenerateRoute,
      initialRoute: Routes.splashScreen,
    );
  }
}
