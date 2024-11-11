// ignore_for_file: public_member_api_docs, sort_constructors_first
class Article {
  final String articleName;
  final String articleDescription;
  final List<String> articleTitleIsi;
  final List<String> articleIsi;
  final List<String> articlePhotos;
  final String author;
  final String publishedDate;

  Article({
    required this.articleName,
    required this.articleDescription,
    required this.articleTitleIsi,
    required this.articleIsi,
    required this.articlePhotos,
    required this.author,
    required this.publishedDate,
  });

  factory Article.fromJson(Map<String, dynamic> json) {
    return Article(
      articleName: json['articleName'],
      articleDescription: json['articleDescription'],
      articleTitleIsi: json['articleTitleIsi'],
      articleIsi: json['articleIsi'],
      articlePhotos: json['articlePhotos'],
      author: json['articleAuthor'],
      publishedDate: json['publishedDate'],
    );
  }
}
