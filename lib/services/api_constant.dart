class ApiConstants {
  static const String baseURL = 'https://d0f8-103-19-110-25.ngrok-free.app';
  static const String articleCarouselList = '$baseURL/article/';
  static String getArticleDetail(int articleId) =>
      '$baseURL/article/detail/$articleId/';
}
