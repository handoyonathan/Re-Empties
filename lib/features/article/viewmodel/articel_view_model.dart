import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final articleProvider = ChangeNotifierProvider<ArticleVM>((ref) => ArticleVM());

class ArticleVM extends ChangeNotifier {
  List<Map<String, dynamic>> articles = [];

  bool isLoading = false;

  Future<void> fetchArticleData() async {
    try {
      QuerySnapshot snapshot =
          await FirebaseFirestore.instance.collection('article').get();

      articles = snapshot.docs
          .map((doc) => doc.data() as Map<String, dynamic>)
          .toList();

      isLoading = true;
      notifyListeners();
    } catch (e) {
      print('Error fetching article data: $e');
    }
  }
}
