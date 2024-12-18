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

    showCustomToast("Ini Masuk Load Article");
    print("LOAD ARTICLE");
    final articles = await _carouselService.fetchArticlesFromApi();
    if (articles != null) {
      carouselList = articles;
      showCustomToast("Data successfully loaded!");
      print("SUCCESS LOAD ARTICLE");
    } else {
      showCustomToast("FAILED");
      print("FAIL");
    }
    // } catch (e) {
    //   showCustomToast("An error occurred: $e");
    // }

    //   ArticleCarouselList? carouselList; = await _carouselService.fetchArticlesFromApi();
    //   isLoading = false;
    //   if (response?.statusCode == 200) {
    //     showCustomToast("Asik masuk brok datanya");
    //     carouselList =
    //         ArticleCarouselList.fromJson(response as Map<String, dynamic>);
    //   } else {
    //     showCustomToast("Seperti mati lampu ya sayang");
    //   }
  }
}
