import 'package:flutter/material.dart';
import 'package:re_empties/cores/components/custom_toast_mixin.dart';
import 'package:re_empties/features/home/model/article_carousel_model.dart';
import 'package:re_empties/features/home/services/carousel_service.dart';

// final articleCarouselVMProvider =
//     ChangeNotifierProvider.family<ArticleCarouselVM, Repository>(
//         (ref, repository) {
//   return ArticleCarouselVM(repository);
// });

class ArticleCarouselVM extends ChangeNotifier with CustomToastMixin {
  final CarouselService _carouselService = CarouselService();
  ArticleCarouselList? carouselList;
  bool isLoading = false;

  ArticleCarouselVM() {
    loadArticle();
  }

  Future<void> loadArticle() async {
    isLoading = true;
    notifyListeners(); // Notify listeners that loading has started

    try {
      print("LOAD ARTICLE");
      final articles = await _carouselService.fetchArticlesFromApi();
      print(articles);

      if (articles != null) {
        carouselList = articles;
        showCustomToast("Data successfully loaded!");
      } else {
        showCustomToast("FAILED");
      }
    } catch (e) {
      showCustomToast("An error occurred: $e");
    } finally {
      isLoading =
          false; // Set to false once the loading is complete (success or failure)
      notifyListeners(); // Notify listeners that loading has finished
    }
  }
}
