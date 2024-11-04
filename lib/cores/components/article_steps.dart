import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:re_empties/cores/constant/colors.dart';
import 'package:re_empties/cores/constant/text_theme.dart';

class ArticleSteps extends StatefulWidget {
  final String titleIsi;
  final String isi;
  final String photoUrl;

  const ArticleSteps(
      {super.key,
      required this.titleIsi,
      required this.isi,
      required this.photoUrl});

  @override
  State<ArticleSteps> createState() => _ArticleSteps();
}

class _ArticleSteps extends State<ArticleSteps> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        // JUDUL
        Text(widget.titleIsi, style: textTheme.introTitle),
        Gap(5.h),
        // Photo
        Padding(
          padding: const EdgeInsets.only(left: 25),
          child: widget.photoUrl.isNotEmpty
              ? ClipRRect(
                  borderRadius: BorderRadius.circular(15.0),
                  child: Image.network(
                    widget.photoUrl,
                    width: screenWidth * 0.8,
                    height: screenWidth * 0.5,
                    fit: BoxFit.cover,
                    alignment: Alignment.center,
                  ),
                )
              : Icon(Icons.error, color: colors.red1),
        ),
        Gap(5.h),
        // Description
        Padding(
          padding: const EdgeInsets.only(left: 27, top: 2),
          child: Text(widget.isi, style: textTheme.badgesText),
        ),
        Gap(20.h),
        // Divider(
        //   color: colors.gray4,
        // )
      ],
    );
  }
}
