import 'dart:async';
import 'package:flutter/material.dart';
import 'package:re_empties/cores/components/custom_toast_mixin.dart';
import 'package:re_empties/cores/template/notifer.dart';
import 'package:re_empties/features/article/model/article_detail_model.dart';
import 'package:re_empties/features/article/service/article_service.dart';

class ArticleVM extends BaseNotifier with CustomToastMixin {
  final ArticleService service = ArticleService();
  ArticleDetails? articleDetails;

  ArticleVM(super.ref);

  Future<void> getDetails(int articleId) async {
    isLoading = true;
    notifyListeners();
    try {
      final details = await service.fetchArticleDetails(articleId);
      print("ARTICLE DETAIL : $details");

      if (details != null) {
        articleDetails = details;
        showCustomToast("Data successfully loaded!");
      } else {
        showCustomToast("FAILED");
      }
    } catch (e) {
      print('Error fetching article data: $e');
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  @override
  FutureOr<void> init() {}
}
