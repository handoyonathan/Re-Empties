import 'dart:async';
import 'package:re_empties/cores/template/notifer.dart';
import 'package:re_empties/features/article/model/article_detail_model.dart';
import 'package:re_empties/services/repository.dart';

class ArticleVM extends BaseNotifier {
  final Repository repository = Repository();
  late ArticleDetails articleDetails;

  ArticleVM(super.ref);

  Future<void> fetchArticleData(int articleId) async {
    try {
      isLoading = true;

      var response = await repository.getArticleDetails(articleId);
      articleDetails = ArticleDetails.fromJson(response);

      notifyListeners();
    } catch (e) {
      print('Error fetching article data: $e');
    } finally {
      isLoading = false;
    }
  }

  @override
  FutureOr<void> init() {}
}
