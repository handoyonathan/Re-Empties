class ApiConstants {
  static const String baseURL = 'https://3317-103-121-244-122.ngrok-free.app';
  static const String articleCarouselList = '$baseURL/article/';
  static String getArticleDetail(int articleId) =>
      '$baseURL/article/detail/$articleId/';
}
