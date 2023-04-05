import 'dart:async';

import 'package:teknikaltest/app/locator.dart';
import 'package:teknikaltest/app/routes.gr.dart';
import 'package:stacked/stacked.dart';
import 'package:teknikaltest/providers/article.dart';
import 'package:teknikaltest/models/ArticleModel.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:flutter/material.dart';

class HomeViewModel extends BaseViewModel {
  NavigationService _nav = locator<NavigationService>();
  final articleService = new Article();
  ScrollController scrollController;

  List<ArticleModel> articleModel = [];
  bool init = true;

  Future initialize() async {
    init = true;
    final res = await articleService.getArticle();
    if (res.statusCode == 200) {
      articleModel = articleModelFromJson(res.body);
    }
    init = false;

    notifyListeners();
  }

  void gotoDetail(ArticleModel article) async {
    _nav.navigateTo(Routes.detailArticle,
        arguments: DetailArticelScreenArguments(article: article));
  }
}
