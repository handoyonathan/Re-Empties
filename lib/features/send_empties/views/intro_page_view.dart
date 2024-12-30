import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/src/size_extension.dart';
import 'package:gap/gap.dart';

import 'package:re_empties/cores/components/article_steps.dart';
import 'package:re_empties/cores/components/button_main_app.dart';
import 'package:re_empties/cores/components/custom_app_bar.dart';
import 'package:re_empties/cores/components/image_asset.dart';
import 'package:re_empties/cores/constant/colors.dart';
import 'package:re_empties/cores/constant/image_path.dart';
import 'package:re_empties/cores/constant/text_theme.dart';
import 'package:re_empties/cores/template/view.dart';
import 'package:re_empties/features/send_empties/viewModel/intro_page_view_model.dart';

class IntroView extends ConsumerWidget {
  final bool isSend;
  final AutoDisposeChangeNotifierProvider<IntroVM> _viewModel;

  IntroView({
    super.key,
    required this.isSend,
  }) : _viewModel = ChangeNotifierProvider.autoDispose((ref) => IntroVM(ref));

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.read(_viewModel).fetchArticleData();
    return BaseView(
        provider: _viewModel,
        appBar: (_) => CustomAppBar(
              title: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "Let's make sure to pack the right way!",
                    style: textTheme.textButton.copyWith(color: colors.green1),
                    textAlign: TextAlign.left,
                  ),
                ],
              ),
            ),
        builder: _buildScreen);
  }

  Widget _buildScreen(BuildContext context, IntroVM vm) => Scaffold(
      backgroundColor: colors.bgColor,
      bottomNavigationBar: Container(
              color: colors.bgColor,
              alignment: Alignment.center,
              height: 70.h,
              child: AppMainButton(
                state: ButtonState.primary,
                text: 'Continue',
                onPressed: () {
                  vm.goToLocationPage(isSend: isSend);
                },
              ),
            ),
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
                      for (var article in vm.articles) ...[
                        ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: (article['articleIsi'] as List).length,
                          itemBuilder: (context, stepIndex) {
                            final titles = article['articleTitleIsi'] as List;
                            final descriptions = article['articleIsi'] as List;
                            final photos = article['articlePhotos'] as List;

                            final title = stepIndex < titles.length
                                ? titles[stepIndex]
                                : '';
                            final description = stepIndex < descriptions.length
                                ? descriptions[stepIndex]
                                : '';
                            final photoUrl = stepIndex < photos.length
                                ? photos[stepIndex]
                                : '';

                            return ArticleSteps(
                              titleIsi: "${stepIndex + 1}. $title",
                              isi: description,
                              photoUrl: photoUrl,
                            );
                          },
                        ),
                      ],
                      // Align(
                      //   alignment: Alignment.center,
                      //   child: AppMainButton(
                      //     state: ButtonState.primary,
                      //     text: 'Continue',
                      //     onPressed: () {
                      //       vm.goToLocationPage(isSend: isSend);
                      //     },
                      //   ),
                      // ),
                      // Gap(30.h)
                    ],
                  ),
                ));
}
