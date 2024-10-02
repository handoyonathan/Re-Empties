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
  final List<String> titles = ["Article 1", "Article 2", "Article 3"];
  final List<String> descriptions = [
    "Description for Article 1",
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
          gradient: LinearGradient(
            colors: [
              Colors.yellow.shade500, // Start color
              Colors.orange.shade600, // End color
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
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
                // Sample image placeholder, replace with actual widget
                Container(
                  width: 80.w,
                  height: 80.h,
                  child: Center(
                    child: Icon(Icons.image, size: 40.w),
                  ),
                ),
                Gap(100.w),
                // Text section for each article
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        title,
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Gap(5.h),
                      Text(
                        description,
                        style: TextStyle(
                          fontSize: 12.sp,
                          color: Colors.grey.shade600,
                        ),
                      ),
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
