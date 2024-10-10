import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:re_empties/cores/constant/text_theme.dart';
import 'package:firebase_storage/firebase_storage.dart';

class ArticleSteps extends StatefulWidget {
  final String titleIsi;
  final String isi;
  final String photo;

  const ArticleSteps(
      {super.key,
      required this.titleIsi,
      required this.isi,
      required this.photo});

  @override
  State<ArticleSteps> createState() => _ArticleSteps();
}

class _ArticleSteps extends State<ArticleSteps> {
  String? imageUrl;

  @override
  void initState() {
    super.initState();
    _loadImageFromFirebase();
  }

  Future<void> _loadImageFromFirebase() async {
    try {
      // buat convert link gs ke link http
      String url = await FirebaseStorage.instance
          .refFromURL(widget.photo)
          .getDownloadURL();
      setState(() {
        imageUrl = url;
      });
    } catch (e) {
      print('Error loading image: $e');
    }
  }

  @override
  Widget build(BuildContext context) => Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // JUDUL
          Text(widget.titleIsi, style: textTheme.articleDetail),
          Gap(5.h),
          // Photo
          imageUrl != null
              ? Image.network(
                  imageUrl!,
                  width: double.infinity,
                  height: double.infinity,
                  fit: BoxFit.cover,
                )
              : const CircularProgressIndicator(),
          Gap(5.h),
          // Description
          Text(widget.isi, style: textTheme.articleDesc),
          Gap(5.h),
        ],
      );
}
