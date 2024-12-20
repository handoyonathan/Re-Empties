import 'dart:convert';

import 'package:re_empties/features/article/model/article_detail_model.dart';
import 'package:re_empties/services/base_service.dart';

class ArticleService extends BaseService {
  Future<ArticleDetails?> fetchArticleDetails(int articleId) async {
    try {
      final response = await get(url: '/article/detail/$articleId');
      if (response != null && response.statusCode == 200) {
        var responseData = response.data;
        if (response.data is String) {
          responseData = json.decode(response.data); // Decode JSON string
        }
        if (responseData['data'] != null) {
          return ArticleDetails.fromJson(responseData['data']);
        } else {
          print("Invalid 'data' structure");
        }
      } else {
        print("Request failed with status: ${response?.statusCode}");
      }
    } catch (e) {
      print("Error Fetching Article Details: $e");
    }
    return null;
  }
}
