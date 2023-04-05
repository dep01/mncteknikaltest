// To parse this JSON data, do
//
//     final articleModel = articleModelFromJson(jsonString);

import 'dart:convert';

List<ArticleModel> articleModelFromJson(String str) => List<ArticleModel>.from(
    json.decode(str).map((x) => ArticleModel.fromJson(x)));

String articleModelToJson(List<ArticleModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ArticleModel {
  ArticleModel({
    this.id,
    this.createdAt,
    this.contributorName,
    this.contributorAvatar,
    this.title,
    this.content,
    this.contentThumbnail,
    this.slideshow,
  });

  String id;
  String createdAt;
  String contributorName;
  String contributorAvatar;
  String title;
  String content;
  String contentThumbnail;
  List<String> slideshow;

  ArticleModel copyWith({
    String id,
    String createdAt,
    String contributorName,
    String contributorAvatar,
    String title,
    String content,
    String contentThumbnail,
    List<String> slideshow,
  }) =>
      ArticleModel(
        id: id ?? this.id,
        createdAt: createdAt ?? this.createdAt,
        contributorName: contributorName ?? this.contributorName,
        contributorAvatar: contributorAvatar ?? this.contributorAvatar,
        title: title ?? this.title,
        content: content ?? this.content,
        contentThumbnail: contentThumbnail ?? this.contentThumbnail,
        slideshow: slideshow ?? this.slideshow,
      );

  factory ArticleModel.fromJson(Map<String, dynamic> json) => ArticleModel(
        id: json["id"],
        createdAt: json["createdAt"],
        contributorName: json["contributorName"],
        contributorAvatar: json["contributorAvatar"],
        title: json["title"],
        content: json["content"],
        contentThumbnail: json["contentThumbnail"],
        slideshow: List<String>.from(json["slideshow"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "createdAt": createdAt,
        "contributorName": contributorName,
        "contributorAvatar": contributorAvatar,
        "title": title,
        "content": content,
        "contentThumbnail": contentThumbnail,
        "slideshow": List<dynamic>.from(slideshow.map((x) => x)),
      };
}
