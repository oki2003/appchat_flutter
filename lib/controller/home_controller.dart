import 'package:appchat_flutter/controller/user_controller.dart';
import 'package:appchat_flutter/models/post.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class HomeController {
  Future<List<Post>> getPosts() async {
    final firestore = FirebaseFirestore.instance;
    final currentUserId = FirebaseAuth.instance.currentUser!.uid;
    final UserController userController = UserController();

    try {
      //get list of id from your friends
      QuerySnapshot friendsSnapshot = await firestore
          .collection('friendships')
          .doc(currentUserId)
          .collection('friends')
          .get();

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
        final futuresPosts = snapshot.docs.map((doc) async {
          final friend = await userController.getInfoFriend(doc['authorId']);
          return Post.fromDoc(doc, friend);
        }).toList();
        final posts = await Future.wait(futuresPosts);
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
