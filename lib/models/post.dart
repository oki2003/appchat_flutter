import 'package:cloud_firestore/cloud_firestore.dart';

class Post {
  final String id;
  final String avatarURL;
  final String name;
  final Timestamp createdAt;
  final String content;

  const Post({
    required this.id,
    required this.avatarURL,
    required this.name,
    required this.createdAt,
    required this.content,
  });

  factory Post.fromMap(Map<String, dynamic> map) {
    return Post(
      id: map['id'] ?? 0,
      avatarURL: map['avatarURL'] ?? '',
      name: map['name'] ?? '',
      createdAt: map['createdAt'] ?? '',
      content: map['content'] ?? '',
    );
  }

  factory Post.fromDoc(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return Post(
      id: doc.id,
      name: data['authorName'] ?? '',
      avatarURL: data['authorAvatar'] ?? '',
      content: data['content'] ?? '',
      createdAt: data['createdAt'] ?? Timestamp.now(),
    );
  }
}
