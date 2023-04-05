import 'dart:async';

import 'package:teknikaltest/app/locator.dart';
import 'package:teknikaltest/app/routes.gr.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class SplashScreenViewModel extends BaseViewModel {
  NavigationService _nav = locator<NavigationService>();

  Future initialize() async {
    await runBusyFuture(Future.delayed(const Duration(seconds: 3)));
    _nav.replaceWith(Routes.home);
  }
}
