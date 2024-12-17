// To parse this JSON data, do
//
//     final articleDetails = articleDetailsFromJson(jsonString);

import 'dart:convert';

ArticleDetails articleDetailsFromJson(String str) =>
    ArticleDetails.fromJson(json.decode(str));

String articleDetailsToJson(ArticleDetails data) => json.encode(data.toJson());

class ArticleDetails {
  ArticleDetailsClass articleDetails;

  ArticleDetails({
    required this.articleDetails,
  });

  factory ArticleDetails.fromJson(Map<String, dynamic> json) => ArticleDetails(
        articleDetails: ArticleDetailsClass.fromJson(json["articleDetails"]),
      );

  Map<String, dynamic> toJson() => {
        "articleDetails": articleDetails.toJson(),
      };
}

class ArticleDetailsClass {
  int articleId;
  String articleName;
  String author;
  String publishedDate;
  String articleDescription;
  List<ArticleDetail> articleDetails;

  ArticleDetailsClass({
    required this.articleId,
    required this.articleName,
    required this.author,
    required this.publishedDate,
    required this.articleDescription,
    required this.articleDetails,
  });

  factory ArticleDetailsClass.fromJson(Map<String, dynamic> json) =>
      ArticleDetailsClass(
        articleId: json["articleId"],
        articleName: json["articleName"],
        author: json["author"],
        publishedDate: json["publishedDate"],
        articleDescription: json["articleDescription"],
        articleDetails: List<ArticleDetail>.from(
            json["article_details"].map((x) => ArticleDetail.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "articleId": articleId,
        "articleName": articleName,
        "author": author,
        "publishedDate": publishedDate,
        "articleDescription": articleDescription,
        "article_details":
            List<dynamic>.from(articleDetails.map((x) => x.toJson())),
      };
}

class ArticleDetail {
  int articleDetailId;
  int articleId;
  String articleTitleIsi;
  String articleIsi;
  String articlePhotos;

  ArticleDetail({
    required this.articleDetailId,
    required this.articleId,
    required this.articleTitleIsi,
    required this.articleIsi,
    required this.articlePhotos,
  });

  factory ArticleDetail.fromJson(Map<String, dynamic> json) => ArticleDetail(
        articleDetailId: json["articleDetailId"],
        articleId: json["articleId"],
        articleTitleIsi: json["articleTitleIsi"],
        articleIsi: json["articleIsi"],
        articlePhotos: json["articlePhotos"],
      );

  Map<String, dynamic> toJson() => {
        "articleDetailId": articleDetailId,
        "articleId": articleId,
        "articleTitleIsi": articleTitleIsi,
        "articleIsi": articleIsi,
        "articlePhotos": articlePhotos,
      };
}
