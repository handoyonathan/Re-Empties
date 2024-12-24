import 'dart:convert';

class ArticleModel {
  List<Article>? articles;

  ArticleModel({required this.articles});

  factory ArticleModel.fromJson(Map<String, dynamic> json) {
    return ArticleModel(
      articles: json["article"] != null
          ? [
              Article.fromJson(json["article"])
            ] // Wrap a single Article object into a list
          : [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "article": articles != null
          ? articles!.map((article) => article.toJson()).toList()
          : [],
    };
  }
}

class Article {
  int articleId;
  String articleName;
  String author;
  String publishedDate;
  String articleDescription;
  List<ArticleDetails> articleDetails;

  Article({
    required this.articleId,
    required this.articleName,
    required this.author,
    required this.publishedDate,
    required this.articleDescription,
    required this.articleDetails,
  });

  factory Article.fromJson(Map<String, dynamic> json) {
    return Article(
      articleId: json['articleId'],
      articleName: json['articleName'],
      author: json['author'],
      publishedDate: json['publishedDate'],
      articleDescription: json['articleDescription'],
      articleDetails: json['articleDetails'] != null
          ? List<ArticleDetails>.from(
              json['articleDetails'].map((x) => ArticleDetails.fromJson(x)))
          : [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "articleId": articleId,
      "articleName": articleName,
      "author": author,
      "publishedDate": publishedDate,
      "articleDescription": articleDescription,
      "articleDetails":
          articleDetails.map((detail) => detail.toJson()).toList(),
    };
  }
}

class ArticleDetails {
  int articleDetailId;
  int articleId;
  String articleTitleIsi;
  String articleIsi;
  String articlePhotos;

  ArticleDetails({
    required this.articleDetailId,
    required this.articleId,
    required this.articleTitleIsi,
    required this.articleIsi,
    required this.articlePhotos,
  });

  factory ArticleDetails.fromJson(Map<String, dynamic> json) {
    return ArticleDetails(
      articleDetailId: json['articleDetailId'],
      articleId: json['articleId'],
      articleTitleIsi: json['articleTitleIsi'],
      articleIsi: json['articleIsi'],
      articlePhotos: json['articlePhotos'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "articleDetailId": articleDetailId,
      "articleId": articleId,
      "articleTitleIsi": articleTitleIsi,
      "articleIsi": articleIsi,
      "articlePhotos": articlePhotos,
    };
  }
}
