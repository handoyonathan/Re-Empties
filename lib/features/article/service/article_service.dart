import 'dart:convert';

import 'package:re_empties/features/article/model/article_detail_model.dart';
import 'package:re_empties/services/base_service.dart';

class ArticleService extends BaseService {
  Future<ArticleModel?> fetchArticleDetails(int articleId) async {
    try {
      final response = await get(url: '/article/detail/$articleId');
      if (response != null && response.statusCode == 200) {
        final responseData = response.data is String
            ? json.decode(response.data)
            : response.data;

        print("Response Data: ${json.encode(responseData)}");

        return ArticleModel.fromJson(responseData);
      } else {
        print("Request failed with status: ${response?.statusCode}");
      }
    } catch (e) {
      print("Error Fetching Article Details: $e");
    }
    return null;
  }
}
