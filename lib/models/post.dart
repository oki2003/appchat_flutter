import 'package:appchat_flutter/models/friend.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Post {
  final String authorId;
  final Timestamp createdAt;
  final String content;
  final Friend friend;

  const Post({
    required this.authorId,
    required this.createdAt,
    required this.content,
    required this.friend,
  });

  factory Post.fromDoc(DocumentSnapshot doc, Friend friend) {
    final data = doc.data() as Map<String, dynamic>;
    return Post(
      authorId: data['authorId'],
      content: data['content'] ?? '',
      createdAt: data['createdAt'] ?? Timestamp.now(),
      friend: friend,
    );
  }
}
