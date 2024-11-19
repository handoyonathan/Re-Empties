import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:go_router/go_router.dart';
import 'package:re_empties/cores/router/router_constant.dart';
import 'package:re_empties/cores/template/notifer.dart';

class IntroVM extends BaseNotifier {
  List<Map<String, dynamic>> articles = [];

  IntroVM(super.ref);

  Future<void> fetchArticleData() async {
    try {
      isLoading = true;
      DocumentSnapshot snapshot = await FirebaseFirestore.instance
          .collection('article')
          .doc('2LTkM5h03FVWgGZbWxxp')
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
      return 'Get Image not success';
    }
  }

  void goToLocationPage({required bool? isSend}) {
    ctx.pushNamed(paths.location, extra: isSend);
  }

  @override
  FutureOr<void> init() {
    fetchArticleData();
  }
}
