import 'package:appchat_flutter/models/post.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomeViewModel extends ChangeNotifier {
  List<Post> posts = [];
  final currentUserId = FirebaseAuth.instance.currentUser!.uid;
  final ScrollController scrollController = ScrollController();
  DocumentSnapshot? lastPost;
  bool isLoading = true;
  bool hasMore = true;

  Future<void> getPosts() async {
    try {
      QuerySnapshot postsSnapshot = await FirebaseFirestore.instance
          .collection('posts')
          .doc(currentUserId)
          .collection(currentUserId)
          .orderBy('createdAt', descending: true)
          .limit(4)
          .get();

      if (postsSnapshot.docs.isNotEmpty) {
        posts = postsSnapshot.docs.map((doc) => Post.fromDoc(doc)).toList();
        lastPost = postsSnapshot.docs.last;
      }
      isLoading = false;
      notifyListeners();
    } catch (e) {
      print('Có lỗi lấy posts $e');
    }
  }

  Future<void> handleRefresh() async {
    isLoading = true;
    hasMore = true;
    lastPost = null;
    notifyListeners();
    getPosts();
  }

  Future<void> loadMore() async {
    QuerySnapshot postsSnapshot = await FirebaseFirestore.instance
        .collection('posts')
        .doc(currentUserId)
        .collection(currentUserId)
        .orderBy('createdAt', descending: true)
        .limit(4)
        .startAfterDocument(lastPost!)
        .get();
    if (postsSnapshot.docs.isNotEmpty) {
      List<Post> allPosts = postsSnapshot.docs
          .map((doc) => Post.fromDoc(doc))
          .toList();
      posts.addAll(allPosts);
      lastPost = postsSnapshot.docs.last;
      notifyListeners();
    } else {
      hasMore = false;
    }
  }
}
