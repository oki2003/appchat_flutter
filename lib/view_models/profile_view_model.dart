import 'package:appchat_flutter/models/post.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ProfileViewModel extends ChangeNotifier {
  final ScrollController scrollController = ScrollController();
  bool hasMore = true;
  DocumentSnapshot? lastPost;

  Map<String, dynamic> user = {};
  int totalFriends = 0;
  int totalPosts = 0;
  List<Post> posts = [];
  final currentUserId = FirebaseAuth.instance.currentUser!.uid;

  Future<void> getInfomation() async {
    try {
      final firestore = FirebaseFirestore.instance;

      final List<dynamic> results = await Future.wait([
        firestore.collection('users').doc(currentUserId).get(),
        firestore
            .collection('friendships')
            .doc(currentUserId)
            .collection('friends')
            .count()
            .get(),
        firestore
            .collection('posts')
            .doc(currentUserId)
            .collection('my_posts')
            .count()
            .get(),
        firestore
            .collection('posts')
            .doc(currentUserId)
            .collection('my_posts')
            .orderBy('createdAt', descending: true)
            .limit(3)
            .get(),
      ]);
      user = results[0].data() as Map<String, dynamic>;
      totalFriends = results[1].count;
      totalPosts = results[2].count;
      if (results[3].docs.isNotEmpty) {
        posts = List<Post>.from(
          results[3].docs.map((doc) => Post.fromDoc(doc)),
        );
        lastPost = results[3].docs.last;
      }
      notifyListeners();
    } catch (e) {
      print("Lỗi khi lấy thông tin người dùng $e");
    }
  }

  Future<void> loadMore() async {
    try {
      final QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('posts')
          .doc(currentUserId)
          .collection('my_posts')
          .orderBy('createdAt', descending: true)
          .limit(3)
          .startAfterDocument(lastPost!)
          .get();
      if (querySnapshot.docs.isNotEmpty) {
        final List<Post> allPosts = List<Post>.from(
          querySnapshot.docs.map((doc) => Post.fromDoc(doc)),
        );
        posts.addAll(allPosts);
        lastPost = querySnapshot.docs.last;
      } else {
        hasMore = false;
      }
      notifyListeners();
    } catch (e) {
      print('Lỗi tải thêm: $e');
    }
  }
}
