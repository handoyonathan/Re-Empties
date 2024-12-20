import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import 'package:re_empties/cores/components/article_card.dart';
import 'package:re_empties/cores/constant/colors.dart';
import 'package:re_empties/cores/router/router_constant.dart';
import 'package:re_empties/features/article/view/article_view.dart';
import 'package:re_empties/features/home/view%20model/article_carouselVM.dart';

class ArticlePreviewHome extends StatefulWidget {
  const ArticlePreviewHome({super.key});

  @override
  State<ArticlePreviewHome> createState() => _ArticlePreviewHomeState();
}

class _ArticlePreviewHomeState extends State<ArticlePreviewHome> {
  @override
  void initState() {
    super.initState();
    // No need to load the article here, let the Consumer handle the data loading.
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ArticleCarouselVM(),
      child: Consumer<ArticleCarouselVM>(
        builder: (context, viewModel, child) {
          // Call loadArticle only if it's not already loading
          if (!viewModel.isLoading && viewModel.carouselList == null) {
            viewModel
                .loadArticle(); // Fetch articles only if not already loaded
          }

          if (viewModel.isLoading) {
            return Center(
              child: CircularProgressIndicator(
                color: colors.green2,
              ),
            );
          }

          if (viewModel.carouselList == null ||
              viewModel.carouselList!.data == null) {
            return Text("No article Available");
          }

          return SizedBox(
            height: 142.h,
            width: 323.w,
            child: PageView.builder(
                itemCount: viewModel.carouselList!.data!.length,
                itemBuilder: (context, index) {
                  final carousel = viewModel.carouselList!.data![index];
                  return Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8.w),
                    child: ArticleCard(
                      title: carousel.articleName,
                      articleId: carousel.articleId,
                      imageUrl: carousel.carouselPhoto,
                      onTap: () async {
                        print('Tapped article ID: ${carousel.articleId}');
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                ArticleView(articleId: carousel.articleId),
                          ),
                        );
                        ctx.pushNamed(paths.article, extra: <String, dynamic>{
                          'articleId': carousel.articleId,
                        });
                      },
                    ),
                  );
                }),
          );
        },
      ),
    );
  }
}
