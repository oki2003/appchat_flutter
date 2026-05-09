// import 'package:cloud_firestore/cloud_firestore.dart';

// class Post {
//   final String authorId;
//   final String authorName;
//   final String avatarURL;
//   final String content;
//   final Timestamp createdAt;

//   const Post({
//     required this.authorId,
//     required this.authorName,
//     required this.avatarURL,
//     required this.content,
//     required this.createdAt,
//   });

//   factory Post.fromDoc(DocumentSnapshot doc) {
//     final data = doc.data() as Map<String, dynamic>;
//     return Post(
//       authorId: data['authorId'] ?? '',
//       authorName: data['authorName'] ?? 'unknow',
//       avatarURL: data['avatarURL'] ?? '',
//       content: data['content'] ?? '',
//       createdAt: data['createdAt'] ?? Timestamp.now(),
//     );
//   }
// }
