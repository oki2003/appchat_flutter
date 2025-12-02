import 'package:appchat_flutter/services/post_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class PostRepository {
  final PostService postService;

  PostRepository(this.postService);

  Future<QuerySnapshot> getPosts(String idUser) async {
    return postService.getPosts(idUser);
  }

  loadMorePosts(String idUser, DocumentSnapshot lastPost) {
    return postService.loadMorePosts(idUser, lastPost);
  }
}
