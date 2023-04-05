// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:auto_route/auto_route.dart';
import 'package:teknikaltest/screen/splash.dart';
import 'package:teknikaltest/screen/home.dart';
import 'package:teknikaltest/screen/detail_article.dart';
import 'package:teknikaltest/models/ArticleModel.dart';

abstract class Routes {
  static const splashScreen = '/';
  static const home = '/home';
  static const detailArticle = '/detail-article';
  static const all = {
    splashScreen,
    home,
    detailArticle,
  };
}

class Routers extends RouterBase {
  @override
  Set<String> get allRoutes => Routes.all;

  @Deprecated('call ExtendedNavigator.ofRouter<Router>() directly')
  static ExtendedNavigatorState get navigator =>
      ExtendedNavigator.ofRouter<Routers>();

  @override
  Route<dynamic> onGenerateRoute(RouteSettings settings) {
    final args = settings.arguments;
    switch (settings.name) {
      case Routes.splashScreen:
        return MaterialPageRoute<dynamic>(
          builder: (context) => SplashScreen(),
          settings: settings,
        );
      case Routes.home:
        return MaterialPageRoute<dynamic>(
          builder: (context) => HomeScreen(),
          settings: settings,
        );
      case Routes.detailArticle:
        if (hasInvalidArgs<DetailArticelScreenArguments>(args)) {
          return misTypedArgsRoute<DetailArticelScreenArguments>(args);
        }
        final typedArgs = args as DetailArticelScreenArguments ??
            DetailArticelScreenArguments();
        return MaterialPageRoute<dynamic>(
          builder: (context) => DetailArticelScreen(article: typedArgs.article),
          settings: settings,
        );
      default:
        return unknownRoutePage(settings.name);
    }
  }
}

// *************************************************************************
// Arguments holder classes
// **************************************************************************

//DetailArticelScreen arguments holder class
class DetailArticelScreenArguments {
  final ArticleModel article;
  DetailArticelScreenArguments({this.article});
}
