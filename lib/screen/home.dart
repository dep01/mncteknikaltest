import 'package:teknikaltest/utils/constant.dart';
import 'package:teknikaltest/widgets/loading.dart';
import 'package:teknikaltest/utils/indonesia.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:responsive_screen/responsive_screen.dart';
import 'package:stacked/stacked.dart';
import 'model/home_vm.dart';

class HomeScreen extends ViewModelBuilderWidget<HomeViewModel> {
  @override
  HomeViewModel viewModelBuilder(BuildContext context) => HomeViewModel();

  @override
  bool get reactive => true;

  @override
  bool get disposeViewModel => true;

  @override
  void onViewModelReady(HomeViewModel model) {
    model.initialize();
    super.onViewModelReady(model);
  }

  @override
  Widget builder(BuildContext context, HomeViewModel model, Widget child) {
    final Function wp = Screen(context).wp;
    final Function hp = Screen(context).hp;
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Center(
            child: Image(
              width: 150.0,
              image: AssetImage(Resources.logo),
              fit: BoxFit.fitWidth,
            ),
          ),
        ),
        body: ListView.builder(
          padding: EdgeInsets.only(top: 24, left: 12, right: 12),
          controller: model.scrollController,
          itemCount: model.articleModel.length,
          itemBuilder: (lContext, index) {
            return GestureDetector(
              onTap: () => model.gotoDetail(model.articleModel[index]),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  CachedNetworkImage(
                    width: wp(100),
                    imageUrl: model.articleModel[index].contentThumbnail ??
                        'https://via.placeholder.com/150',
                    errorWidget: (_, i, o) =>
                        Image.network('https://via.placeholder.com/150'),
                    placeholder: (_, z) => LoadingBlock(),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    // tanggal(DateTime.parse(model.articleModel[index].createdAt),
                    // shortMonth: true),
                    model.articleModel[index].contributorName,
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        color: AppColors.textSecondary,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    model.articleModel[index].title,
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        color: AppColors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 24),
                  ),
                  Divider(
                    color: AppColors.textSecondary,
                    thickness: 1,
                    height: 10,
                  ),
                  SizedBox(
                    height: 30,
                  ),
                ],
              ),
            );
          },
        ));
  }
}
