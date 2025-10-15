import 'package:appchat_flutter/models/post.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class HomeController {
  Future<List<Post>> getPosts(fromCache) async {
    final firestore = FirebaseFirestore.instance;
    final currentUserId = FirebaseAuth.instance.currentUser!.uid;
    final source = fromCache ? Source.cache : Source.server;

    try {
      //get list of id from your friends
      QuerySnapshot friendsSnapshot;
      friendsSnapshot = await firestore
          .collection('friendships')
          .doc(currentUserId)
          .collection('friends')
          .get(GetOptions(source: source));
      if (friendsSnapshot.docs.isEmpty) {
        friendsSnapshot = await firestore
            .collection('friendships')
            .doc(currentUserId)
            .collection('friends')
            .get(GetOptions(source: source));
      }

      final friendIds = friendsSnapshot.docs.map((doc) => doc.id).toList();
      if (friendIds.isEmpty) {
        return [];
      }

      //get posts via friend's id
      List<Post> allPosts = [];
      List<Future<QuerySnapshot>> futures = friendIds.map((friendId) {
        return firestore
            .collection('posts')
            .where('authorId', isEqualTo: friendId)
            .get();
      }).toList();

      final results = await Future.wait(futures);

      for (final snapshot in results) {
        final posts = snapshot.docs.map((doc) => Post.fromDoc(doc)).toList();
        allPosts.addAll(posts);
      }

      //sort all posts by time
      allPosts.sort((a, b) => b.createdAt.compareTo(a.createdAt));
      return allPosts;
    } catch (e) {
      print('Có lỗi khi lấy bài đăng: $e');
      return [];
    }
  }
}
