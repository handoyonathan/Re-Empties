// To parse this JSON data, do
//
//     final articleCarousel = articleCarouselFromJson(jsonString);
import 'dart:convert';

class ArticleCarouselList {
  List<Data>? data;

  ArticleCarouselList({required this.data});

  factory ArticleCarouselList.fromJson(Map<String, dynamic> json) =>
      ArticleCarouselList(
          data: List<Data>.from(json["data"].map((x) => Data.fromJson(x))));

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  int articleId;
  Null createdAt;
  Null updatedAt;
  String articleName;
  String author;
  String publishedDate;
  String articleDescription;
  String carouselPhoto;
  Null deletedAt;

  Data(
      {required this.articleId,
      this.createdAt,
      this.updatedAt,
      required this.articleName,
      required this.author,
      required this.publishedDate,
      required this.articleDescription,
      required this.carouselPhoto,
      this.deletedAt});

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        articleId: json['articleId'],
        createdAt: json['created_at'],
        updatedAt: json['updated_at'],
        articleName: json['articleName'],
        author: json['author'],
        publishedDate: json['publishedDate'],
        articleDescription: json['articleDescription'],
        carouselPhoto: (json['carouselPhoto'] as String).replaceAll(r'\/', '/'),
        deletedAt: json['deleted_at'],
      );

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['articleId'] = articleId;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['articleName'] = articleName;
    data['author'] = author;
    data['publishedDate'] = publishedDate;
    data['articleDescription'] = articleDescription;
    data['carouselPhoto'] = carouselPhoto;
    data['deleted_at'] = deletedAt;
    return data;
  }
}
