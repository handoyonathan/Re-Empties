import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:re_empties/features/home/view/model/carousel_model.dart';

class ArticleCarouselVM extends ChangeNotifier {
  final List<carouselArticle> carousel = [];
  List<String> imageUrls = [];
  bool isLoading = true;

  ArticleCarouselVM() {
    fetchCarousel();
  }

  Future<void> fetchCarousel() async {
    try {
      isLoading = true;
      notifyListeners();

      // Fetch carousel table from Firestore
      final snapshot =
          await FirebaseFirestore.instance.collection('carouselArticle').get();

      for (var doc in snapshot.docs) {
        final articleId = doc['articleID'];
        final carouselName = doc['carouselName'];
        final carouselPhoto = doc['carouselPhoto'];

        // fetch image url from storage
        final ref = FirebaseStorage.instance.refFromURL(carouselPhoto);
        final imageUrl = await ref.getDownloadURL();

        carousel.add(carouselArticle(
            articleId: articleId,
            carouselName: carouselName,
            carouselPhoto: imageUrl));
        imageUrls.add(imageUrl);
      }
    } catch (e) {
      print("Error fetching articles: $e");
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
