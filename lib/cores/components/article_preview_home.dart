import 'package:flutter/material.dart';
import 'package:re_empties/cores/constant/colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:re_empties/cores/components/image_asset.dart';
import 'package:re_empties/cores/components/tap_detector.dart';
import 'package:re_empties/cores/constant/image_path.dart';
import 'package:re_empties/cores/constant/text_theme.dart';

class ArticlePreviewHome extends StatefulWidget {
  const ArticlePreviewHome({super.key});

  @override
  State<ArticlePreviewHome> createState() => _ArticlePreviewHomeState();
}

class _ArticlePreviewHomeState extends State<ArticlePreviewHome> {
  final List<String> titles = ["Tutorial", "article 2", "Article 3"];
  final List<String> descriptions = [
    "Types of Waste Accepted",
    "Description for Article 2",
    "Description for Article 3"
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 142.h,
      child: PageView.builder(
        itemCount: titles.length,
        itemBuilder: (context, index) {
          return ArticleCard(
            title: titles[index],
            description: descriptions[index],
            onTap: () {
              // Add tap action here if needed
              print("Tapped on ${titles[index]}");
            },
          );
        },
      ),
    );
  }
}

// Stateless widget for the Article Card
class ArticleCard extends StatelessWidget {
  final String title;
  final String description;
  final VoidCallback onTap;

  const ArticleCard({
    Key? key,
    required this.title,
    required this.description,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [
              Color(0xFFFCF5D8),
              Color(0xFFFCF5D8), // Start color
              // Start color
              Color(0xFFFFCC75), // End color
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            stops: [0.0, 0.5, 1.0],
          ),
          borderRadius: BorderRadius.circular(15.r),
        ),
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.r),
          ),
          color: Colors
              .transparent, // Set Card color to transparent to see the gradient

          elevation: 0,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
            child: Row(
              children: [
                ImageAsset(
                  imagePath: images.articlePreview,
                  height: 122.h,
                  width: 80.w,
                  fit: BoxFit.cover,
                  // Sample image placeholder, replace with actual widget
                ),
                Gap(10.w),
                // Text section for each article
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment
                        .end, // Aligns the children to the right
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        title,
                        textAlign: TextAlign.right,
                        style: textTheme.importantNotes
                            .copyWith(fontWeight: FontWeight.w500),
                      ),
                      Gap(5.h),
                      Text(
                        description,
                        textAlign: TextAlign.right,
                        style: textTheme.voucher
                            .copyWith(fontWeight: FontWeight.w700, height: 1.0),
                      ),
                      Gap(18.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment
                            .end, // Aligns the entire Row to the right
                        children: [
                          Text(
                            "Learn More",
                            style: textTheme.pointLabel,
                          ),
                          Gap(2.w),
                          Icon(
                            Icons.arrow_forward, // Arrow icon
                            size: 12,
                            color: colors
                                .red2, // Adjust the size to match the text
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
