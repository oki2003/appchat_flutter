import 'package:appchat_flutter/models/author_detail.dart';

class Comment {
  final String id;
  final String author;
  final AuthorDetails authorDetails;
  final String content;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String url;

  Comment({
    required this.id,
    required this.author,
    required this.authorDetails,
    required this.content,
    required this.createdAt,
    required this.updatedAt,
    required this.url,
  });

  factory Comment.fromJson(Map<String, dynamic> json) {
    return Comment(
      id: json['id'],
      author: json['author'],
      authorDetails: AuthorDetails.fromJson(json['author_details']),
      content: json['content'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      url: json['url'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'author': author,
      'author_details': authorDetails.toJson(),
      'content': content,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
      'url': url,
    };
  }
}
