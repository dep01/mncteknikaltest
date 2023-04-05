import 'package:teknikaltest/utils/constant.dart';
import 'package:teknikaltest/widgets/loading.dart';
import 'package:flutter/material.dart';
import 'package:responsive_screen/responsive_screen.dart';
import 'package:stacked/stacked.dart';
import 'model/splash_vm.dart';

class SplashScreen extends ViewModelBuilderWidget<SplashScreenViewModel> {
  @override
  SplashScreenViewModel viewModelBuilder(BuildContext context) =>
      SplashScreenViewModel();

  @override
  bool get reactive => true;

  @override
  bool get disposeViewModel => true;

  @override
  void onViewModelReady(SplashScreenViewModel model) {
    model.initialize();
    super.onViewModelReady(model);
  }

  @override
  Widget builder(
      BuildContext context, SplashScreenViewModel model, Widget child) {
    final Function wp = Screen(context).wp;
    final Function hp = Screen(context).hp;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(bottom: 50.0),
              child: Image(
                width: 150.0,
                image: AssetImage(Resources.logo),
                fit: BoxFit.fitWidth,
              ),
            ),
            LoadingBlock(Colors.amber)
          ],
        ),
      ),
    );
  }
}
