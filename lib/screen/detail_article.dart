import 'package:teknikaltest/utils/constant.dart';
import 'package:teknikaltest/widgets/loading.dart';
import 'package:teknikaltest/utils/indonesia.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:responsive_screen/responsive_screen.dart';
import 'package:stacked/stacked.dart';
import 'model/detail_vm.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:teknikaltest/models/ArticleModel.dart';

class DetailArticelScreen
    extends ViewModelBuilderWidget<DetailArticleViewModel> {
  final ArticleModel article;
  DetailArticelScreen({this.article});
  @override
  DetailArticleViewModel viewModelBuilder(BuildContext context) =>
      DetailArticleViewModel();

  @override
  bool get reactive => true;

  @override
  bool get disposeViewModel => true;

  @override
  void onViewModelReady(DetailArticleViewModel model) {
    model.initialize(article);
    super.onViewModelReady(model);
  }

  @override
  Widget builder(
      BuildContext context, DetailArticleViewModel model, Widget child) {
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
        body: ListView(
          padding: EdgeInsets.only(top: 24, left: 12, right: 12),
          children: [
            Text(
              model.articleModel.title,
              textAlign: TextAlign.left,
              style: TextStyle(
                  color: AppColors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 24),
            ),
            SizedBox(
              height: 30,
            ),
            Text(
              "By " + model.articleModel.contributorName,
              textAlign: TextAlign.left,
              style: TextStyle(
                  color: AppColors.textSecondary, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              tanggal(DateTime.parse(model.articleModel.createdAt),
                  shortMonth: true),
              textAlign: TextAlign.left,
              style: TextStyle(
                  color: AppColors.black, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 30,
            ),
            CarouselSlider(
              options: CarouselOptions(
                  aspectRatio: 16 / 9,
                  enlargeCenterPage: true,
                  scrollDirection: Axis.horizontal,
                  onPageChanged: (index, e) {
                    model.changeIndex(index);
                  }

                  // autoPlay: true,
                  ),
              items: model.imgCarousel
                  .map((e) =>
                      // return
                      CachedNetworkImage(
                        width: wp(100),
                        height: hp(70),
                        imageUrl: e ?? 'https://via.placeholder.com/150',
                        errorWidget: (_, i, o) =>
                            Image.network('https://via.placeholder.com/150'),
                        placeholder: (_, z) => LoadingBlock(),
                      ))
                  .toList(),
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                for (var i = 0; i < model.imgCarousel.length; i++)
                  GestureDetector(
                    child: Container(
                      margin: EdgeInsets.only(right: 5),
                      decoration: BoxDecoration(
                          border: Border.all(
                              color: i == model.carouselIndex
                                  ? Colors.blue
                                  : Colors.transparent,
                              width: i == model.carouselIndex ? 3 : 0)),
                      child: CachedNetworkImage(
                        width: wp(20),
                        imageUrl: model.imgCarousel[i] ??
                            'https://via.placeholder.com/150',
                        errorWidget: (_, i, o) =>
                            Image.network('https://via.placeholder.com/150'),
                        placeholder: (_, z) => LoadingBlock(),
                      ),
                    ),
                  )
              ],
            ),
            SizedBox(
              height: 30,
            ),
            Text(
              model.articleModel.content,
              textAlign: TextAlign.left,
              style: TextStyle(
                  color: AppColors.black, fontWeight: FontWeight.normal),
            ),
          ],
        ));
  }
}
