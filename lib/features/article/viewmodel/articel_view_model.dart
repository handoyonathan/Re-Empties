import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:re_empties/cores/template/notifer.dart';

class ArticleVM extends BaseNotifier {
  List<Map<String, dynamic>> articles = [];

  ArticleVM(super.ref);

  Future<void> fetchArticleData(String articleId) async {
    try {
      isLoading = true;
      // QuerySnapshot snapshot =
      //     await FirebaseFirestore.instance.collection('article').get();

      // // Process each article and fetch images from Firebase Storage
      // articles = await Future.wait(snapshot.docs.map((doc) async {
      //   Map<String, dynamic> articleData = doc.data() as Map<String, dynamic>;

      DocumentSnapshot snapshot = await FirebaseFirestore.instance
          .collection('article')
          .doc(articleId)
          .get();

      if (snapshot.exists) {
        Map<String, dynamic> articleData =
            snapshot.data() as Map<String, dynamic>;

        List<String> articlePhotos = await Future.wait(
          (articleData['articlePhotos'] as List<dynamic>)
              .map((photoPath) async {
            return await _getFirebaseImageUrl(photoPath);
          }).toList(),
        );

        articleData['articlePhotos'] = articlePhotos;
        articles = [articleData];
      } else {
        articles = [];
      }
      notifyListeners();
      print("Data Article : $snapshot");
    } catch (e) {
      print('Error fetching article data: $e');
    } finally {
      isLoading = false;
    }
  }

  Future<String> _getFirebaseImageUrl(String photoPath) async {
    try {
      String url =
          await FirebaseStorage.instance.refFromURL(photoPath).getDownloadURL();
      return url;
    } catch (e) {
      print('Error loading image: $e');
      return 'Get Image not success';
    }
  }

  @override
  FutureOr<void> init() {}
}
