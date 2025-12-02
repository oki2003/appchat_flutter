import 'package:appchat_flutter/models/post.dart';
import 'package:appchat_flutter/repositories/post_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class HomeViewModel extends ChangeNotifier {
  final PostRepository postRepository;
  final String currentUserId;

  HomeViewModel(this.postRepository, this.currentUserId);

  List<Post> posts = [];
  final ScrollController scrollController = ScrollController();
  DocumentSnapshot? lastPost;
  bool isLoading = true;
  bool hasMore = true;

  initScroll() {
    scrollController.addListener(() {
      if ((scrollController.position.pixels ==
              scrollController.position.maxScrollExtent) &&
          hasMore) {
        loadMore();
      }
    });
  }

  Future<void> getPosts() async {
    try {
      QuerySnapshot postsSnapshot = await postRepository.getPosts(
        currentUserId,
      );

      if (postsSnapshot.docs.isNotEmpty) {
        posts = postsSnapshot.docs.map((doc) => Post.fromDoc(doc)).toList();
        lastPost = postsSnapshot.docs.last;
      }

      isLoading = false;
      notifyListeners();
    } catch (e) {
      debugPrint('Có lỗi lấy posts $e');
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
    try {
      QuerySnapshot postsSnapshot = await postRepository.loadMorePosts(
        currentUserId,
        lastPost!,
      );
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
    } catch (e) {
      debugPrint('Có lỗi tải thêm posts $e');
    }
  }
}
