import 'dart:convert';

class ArticleDetails {
  final int articleId;
  final String articleName;
  final String author;
  final String publishedDate;
  final String articleDescription;
  final List<ArticleDetail> articleDetails;

  ArticleDetails({
    required this.articleId,
    required this.articleName,
    required this.author,
    required this.publishedDate,
    required this.articleDescription,
    required this.articleDetails,
  });

  factory ArticleDetails.fromJson(Map<String, dynamic> json) {
    return ArticleDetails(
      articleId: json['articleId'],
      articleName: json['articleName'],
      author: json['author'],
      publishedDate: json['publishedDate'],
      articleDescription: json['articleDescription'],
      articleDetails: (json['articleDetails'] as List)
          .map((item) => ArticleDetail.fromJson(item))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'articleId': articleId,
      'articleName': articleName,
      'author': author,
      'publishedDate': publishedDate,
      'articleDescription': articleDescription,
      'articleDetails': articleDetails.map((item) => item.toJson()).toList(),
    };
  }
}

class ArticleDetail {
  final int articleDetailId;
  final int articleId;
  final String articleTitleIsi;
  final String articleIsi;
  final String articlePhotos;

  ArticleDetail({
    required this.articleDetailId,
    required this.articleId,
    required this.articleTitleIsi,
    required this.articleIsi,
    required this.articlePhotos,
  });

  factory ArticleDetail.fromJson(Map<String, dynamic> json) {
    return ArticleDetail(
      articleDetailId: json['articleDetailId'],
      articleId: json['articleId'],
      articleTitleIsi: json['articleTitleIsi'],
      articleIsi: json['articleIsi'],
      articlePhotos: json['articlePhotos'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'articleDetailId': articleDetailId,
      'articleId': articleId,
      'articleTitleIsi': articleTitleIsi,
      'articleIsi': articleIsi,
      'articlePhotos': articlePhotos,
    };
  }
}
