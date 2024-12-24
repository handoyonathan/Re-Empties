import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/src/size_extension.dart';
import 'package:gap/gap.dart';

import 'package:re_empties/cores/components/article_steps.dart';
import 'package:re_empties/cores/components/custom_app_bar.dart';
import 'package:re_empties/cores/components/image_asset.dart';
import 'package:re_empties/cores/constant/colors.dart';
import 'package:re_empties/cores/constant/image_path.dart';
import 'package:re_empties/cores/constant/text_theme.dart';
import 'package:re_empties/cores/template/view.dart';
import 'package:re_empties/features/article/viewmodel/articel_view_model.dart';

class ArticleView extends ConsumerWidget {
  final int articleId;
  final AutoDisposeChangeNotifierProvider<ArticleVM> _viewModel;

  ArticleView({super.key, required this.articleId})
      : _viewModel =
            ChangeNotifierProvider.autoDispose((ref) => ArticleVM(ref));

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Fetch article data usticleDeing the articleId passed to the view
    final vm = ref.watch(_viewModel);
    if (!vm.isLoading && vm.articleDetails == null) {
      vm.getDetails(articleId);
    }
    return BaseView(
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
  }

  Widget _buildScreen(BuildContext context, ArticleVM vm) => Scaffold(
      backgroundColor: colors.bgColor,
      body: vm.isLoading
          ? Center(
              child: CircularProgressIndicator(
                  color: colors.green1, backgroundColor: colors.background))
          : vm.articleDetails!.articles!.isEmpty
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
                      for (var article in vm.articleDetails!.articles!)
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // title
                            Text(
                              article.articleName,
                              style: textTheme.articleTitle,
                              textAlign: TextAlign.left,
                            ),
                            Text(
                              "${article.author} | ${article.publishedDate} ",
                              style: textTheme.badgesText,
                              textAlign: TextAlign.left,
                            ),
                            Gap(15),
                            Text(
                              article.articleDescription,
                              style: textTheme.articleIntro,
                              textAlign: TextAlign.left,
                            ),
                            Gap(10),

                            ListView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: article.articleDetails.length,
                                itemBuilder: (context, stepIndex) {
                                  final details =
                                      article.articleDetails[stepIndex];
                                  final titles = details.articleTitleIsi;
                                  final descriptions = details.articleIsi;
                                  final photos = details.articlePhotos;
                                  // Check if the current index is within bounds of each list.
                                  final title = stepIndex < titles.length
                                      ? titles[stepIndex]
                                      : '';
                                  final description =
                                      stepIndex < descriptions.length
                                          ? descriptions[stepIndex]
                                          : '';
                                  final photoUrl = stepIndex < photos.length
                                      ? photos[stepIndex]
                                      : '';

                                  return ArticleSteps(
                                      titleIsi: "${stepIndex + 1}. $title",
                                      isi: description,
                                      photoUrl: photoUrl);
                                }),
                            const Gap(5),
                          ],
                        ),
                    ],
                  )));
}
