import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:re_empties/features/home/model/article_carousel_model.dart';

import 'package:re_empties/services/base_service.dart';

class CarouselService extends BaseService {
  late ArticleCarouselList articleCarousel;

  Future<ArticleCarouselList?> fetchArticlesFromApi() async {
    try {
      final response = await get(url: '/article');
      if (response != null && response.statusCode == 200) {
        // final responseData = response.data as Map<String, dynamic>;
        var responseData = response.data;
        if (response.data is String) {
          responseData = json.decode(response.data); // Decode JSON string
        }
        if (responseData['data'] != null && responseData['data'] is List) {
          List<Data> articles = List<Data>.from(responseData['data']
              .map((item) => Data.fromJson(item as Map<String, dynamic>)));
          return ArticleCarouselList(data: articles);
        } else {
          print("Invalid 'data' structure");
        }
      } else {
        print("Request failed with status: ${response?.statusCode}");
      }
    } catch (e) {
      print("Error Fetching Article: $e");
    }
    return null;
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
