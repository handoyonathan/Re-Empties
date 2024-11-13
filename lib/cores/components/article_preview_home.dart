import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import 'package:re_empties/cores/components/article_card.dart';
import 'package:re_empties/cores/constant/colors.dart';
import 'package:re_empties/features/article/view/article_view.dart';
import 'package:re_empties/features/home/view%20model/article_carouselVM.dart';

class ArticlePreviewHome extends StatefulWidget {
  const ArticlePreviewHome({super.key});

  @override
  State<ArticlePreviewHome> createState() => _ArticlePreviewHomeState();
}

class _ArticlePreviewHomeState extends State<ArticlePreviewHome> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ArticleCarouselVM(),
      child: Consumer<ArticleCarouselVM>(
        builder: (context, viewModel, child) {
          if (viewModel.isLoading) {
            return Center(
                child: CircularProgressIndicator(
              color: colors.green2,
            ));
          }

          return SizedBox(
            height: 142.h,
            width: 323.w,
            child: PageView.builder(
                itemCount: viewModel.imageUrls.length,
                itemBuilder: (context, index) {
                  final carousel = viewModel.carousel[index];
                  return Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8.w),
                    child: ArticleCard(
                      title: carousel.carouselName,
                      articleId: carousel.articleId,
                      imageUrl: carousel.carouselPhoto,
                      onTap: () {
                        print('Tapped article ID: ${carousel.articleId}');
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                ArticleView(articleId: carousel.articleId),
                          ),
                        );
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