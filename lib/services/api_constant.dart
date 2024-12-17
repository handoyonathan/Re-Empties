class ApiConstants {
  static const String baseURL = 'https://d979-103-120-175-115.ngrok-free.app/';
  static const String articleCarouselList = '$baseURL/article/';
  static String getArticleDetail(int articleId) =>
      '$baseURL/article/detail/$articleId/';
}
