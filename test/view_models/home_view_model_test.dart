import 'package:appchat_flutter/repositories/post_repository.dart';
import 'package:appchat_flutter/services/post_service.dart';
import 'package:appchat_flutter/view_models/home_view_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('HomeModelTest', () {
    final fakeFirestore = FakeFirebaseFirestore();
    final postService = PostService(fakeFirestore);
    final postRepository = PostRepository(postService);
    final vm = HomeViewModel(postRepository, 'id_123456');

    setUp(() async {
      final posts = [
        {
          'authorId': '1',
          'authorName': 'Ronaldo',
          'avatarURL': 'assets/avatars/avatar_1.png',
          'content': 'content 1',
          'createdAt': Timestamp.now(),
        },
        {
          'authorId': '2',
          'authorName': 'Messi',
          'avatarURL': 'assets/avatars/avatar_1.png',
          'content': 'content 2',
          'createdAt': Timestamp.now(),
        },
        {
          'authorId': '3',
          'authorName': 'David',
          'avatarURL': 'assets/avatars/avatar_1.png',
          'content': 'content 3',
          'createdAt': Timestamp.now(),
        },
        {
          'authorId': '4',
          'authorName': 'Neymar',
          'avatarURL': 'assets/avatars/avatar_1.png',
          'content': 'content 4',
          'createdAt': Timestamp.now(),
        },
      ];
      for (var post in posts) {
        await fakeFirestore
            .collection('posts')
            .doc('id_123456')
            .collection('id_123456')
            .add(post);
      }
    });

    test('get posts from firestore', () async {
      await vm.getPosts();
      expect(vm.posts.length, 4);
      expect(vm.lastPost, isNotNull);
    });

    test('load more posts from firestore', () async {
      await vm.loadMore();
      expect(vm.posts.length, 4);
      expect(vm.lastPost, isNotNull);
    });
  });
}
