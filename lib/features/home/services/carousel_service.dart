import 'package:dio/dio.dart';
import 'package:re_empties/features/home/model/article_carousel_model.dart';

import 'package:re_empties/services/base_service.dart';

class CarouselService extends BaseService {
  late ArticleCarouselList articleCarousel;

  Future<ArticleCarouselList?> fetchArticlesFromApi() async {
    try {
      Response response = await get(url: '/article');
      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = response.data;
        if (responseData['data'] != null && responseData['data'] is List) {
          List<Data> articles = (responseData['data'] as List)
              .map((item) => Data.fromJson(item))
              .toList();
          print("ARTICLE DATA : $articles");
          return ArticleCarouselList(data: articles);
        }
        print("Invalid 'data' structure");
        return null;
      }
      return null;
    } catch (e) {
      print("AAAAAAAAA ERROR REPOOOOOOOOO");
      print("Error Fetching Article: $e");
      return null;
    }
  }
}
  

//   // Future<ArticleCarouselList> fetchArticleCarousel() async {
//   //   try {
//   //     dynamic response = await get(ApiConstants.articleCarouselList);
//   //     return response = ArticleCarouselList.fromJson(response);
//   //   } catch (e) {
//   //     rethrow;
//   //   }
//   }
// }
