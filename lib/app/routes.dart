import 'package:auto_route/auto_route_annotations.dart';
import 'package:teknikaltest/screen/splash.dart';
import 'package:teknikaltest/screen/home.dart';
import 'package:teknikaltest/screen/detail_article.dart';

@MaterialAutoRouter(routesClassName: "Routes")
class $Routers {
  @initial
  SplashScreen splashScreen;
  HomeScreen home;
  DetailArticelScreen detailArticle;
}
