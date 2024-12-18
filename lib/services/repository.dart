import 'package:re_empties/services/api_constant.dart';

import '../services/base_service.dart';

// final repositoryProvider = Provider<Repository>((ref) {
//   return Repository(
//       BaseService()); // Replace with the actual implementation of your repository
// });

class Repository extends BaseService {
  Future<dynamic> getArticleDetails(int articleId) async {
    final url = ApiConstants.getArticleDetail(articleId);
    return await get(url: url);
  }

  // Future<ArticleCarouselList> fetchArticleCarousel() async {
  //   try {
  //     dynamic response = await get(url: '/article');
  //     return response = ArticleCarouselList.fromJson(response);
  //   } catch (e) {
  //     rethrow;
  //   }
  // }

  
}
