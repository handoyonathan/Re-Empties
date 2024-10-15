import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:re_empties/cores/components/article_steps.dart';
import 'package:re_empties/cores/components/custom_app_bar.dart';
import 'package:re_empties/cores/components/image_asset.dart';
import 'package:re_empties/cores/constant/text_theme.dart';
import 'package:re_empties/cores/template/view.dart';
import 'package:re_empties/features/article/viewmodel/articel_view_model.dart';
import 'package:re_empties/cores/constant/colors.dart';
import 'package:re_empties/cores/constant/image_path.dart';
import 'package:flutter_screenutil/src/size_extension.dart';

class ArticleView extends ConsumerWidget {
  ArticleView({super.key})
      : _viewModel =
            ChangeNotifierProvider.autoDispose((ref) => ArticleVM(ref));

  final AutoDisposeChangeNotifierProvider<ArticleVM> _viewModel;

  @override
  Widget build(BuildContext context, WidgetRef ref) => BaseView(
      provider: _viewModel,
      appBar: (_) => CustomAppBar(
            title: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  'Article Detail',
                  style: textTheme.textButton.copyWith(color: colors.green1),
                  textAlign: TextAlign.left,
                ),
              ],
            ),
          ),
      builder: _buildScreen);

  Widget _buildScreen(BuildContext context, ArticleVM vm) => Scaffold(
      backgroundColor: colors.bgColor,
      body: vm.isLoading
          ? Center(
              child: CircularProgressIndicator(
                  color: colors.green1, backgroundColor: colors.background))
          : vm.articles.isEmpty
              ? Center(
                  child: ImageAsset(
                  imagePath: images.errorIllustration,
                  height: 550.h,
                  width: 250.w,
                ))
              : SingleChildScrollView(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      for (var article in vm.articles)
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // title
                            // Text(
                            //   article['articleName'] ?? '',
                            //   style: textTheme.articleTitle,
                            //   textAlign: TextAlign.left,
                            // ),
                            Text(
                              article['articleDescription'] ?? '',
                              style: textTheme.articleTitle,
                              textAlign: TextAlign.left,
                            ),
                            Gap(2),
                            Text(
                              "${article['author']} | ${article['publishedDate']} ",
                              style: textTheme.badgesText,
                              textAlign: TextAlign.left,
                            ),
                            Gap(5),
                            // Text(
                            //   article['articleDescription'] ?? '',
                            //   style: textTheme.articleTitle,
                            //   textAlign: TextAlign.left,
                            // ),
                            Gap(5),

                            ListView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount:
                                    (article['articleIsi'] as List).length,
                                itemBuilder: (context, stepIndex) {
                                  return ArticleSteps(
                                      titleIsi:
                                          "${stepIndex + 1}. ${article['articleTitleIsi'][stepIndex]}",
                                      isi: article['articleIsi'][stepIndex],
                                      photoUrl: article['articlePhotos']
                                          [stepIndex]);
                                }),
                            Gap(5),
                          ],
                        ),
                    ],
                  )));
}
