import 'dart:async';

import 'package:teknikaltest/app/locator.dart';
import 'package:teknikaltest/app/routes.gr.dart';
import 'package:stacked/stacked.dart';
import 'package:teknikaltest/providers/article.dart';
import 'package:teknikaltest/models/ArticleModel.dart';
import 'package:stacked_services/stacked_services.dart';

class DetailArticleViewModel extends BaseViewModel {
  NavigationService _nav = locator<NavigationService>();
  final articleService = new Article();

  ArticleModel articleModel;
  List<String> imgCarousel = [];
  int carouselIndex = 0;
  bool init = true;

  Future initialize(ArticleModel article) async {
    articleModel = article;
    imgCarousel.add(articleModel.contentThumbnail);
    for (var i = 0; i < articleModel.slideshow.length; i++) {
      imgCarousel.add(articleModel.slideshow[i]);
    }
    init = false;

    notifyListeners();
  }

  void changeIndex(int i) {
    carouselIndex = i;
    notifyListeners();
  }
}
