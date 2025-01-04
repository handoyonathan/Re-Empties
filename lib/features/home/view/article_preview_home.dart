import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

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
  final PageController _pageController = PageController();

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

          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                height: 142.h,
                width: 323.w,
                child: PageView.builder(
                  controller: _pageController,
                  itemCount: viewModel.imageUrls.length,
                  itemBuilder: (context, index) {
                    final carousel = viewModel.carousel[index];
                    return ArticleCard(
                      title: carousel.carouselName,
                      articleId: carousel.articleId,
                      imageUrl: carousel.carouselPhoto,
                      onTap: () {
                        print('Tapped article ID: ${carousel.articleId}');
                        ctx.pushNamed(paths.article, extra: carousel.articleId);
                      },
                    );
                  },
                ),
              ),
              SizedBox(height: 10.h),
              SmoothPageIndicator(
                controller: _pageController,
                count: viewModel.imageUrls.length,
                effect: ExpandingDotsEffect(
                  activeDotColor: colors.red4,
                  dotColor: colors.gray3,
                  dotHeight: 8.h,
                  dotWidth: 8.w,
                  
                ),
                onDotClicked: (index) {
                  // Ketika dot diklik, kita akan melompat ke artikel yang sesuai dengan index
                  _pageController.jumpToPage(index);
                  final carousel = viewModel.carousel[index];
                  print('Tapped article ID: ${carousel.articleId}');
                  // ctx.pushNamed(paths.article,
                  //     extra:
                  //         carousel.articleId); // Arahkan ke artikel yang sesuai
                },
              ),
            ],
          );
        },
      ),
    );
  }
}
