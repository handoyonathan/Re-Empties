class ApiConstants {
  static const String baseURL =
      'https://315b-2404-8000-1005-d0b-8407-69d0-e9fc-d4d.ngrok-free.app';
  static const String articleCarouselList = '$baseURL/article/';
  static String getArticleDetail(int articleId) =>
      '$baseURL/article/detail/$articleId/';
}
