import 'package:cloud_firestore/cloud_firestore.dart';

class Message {
  final Timestamp createdAt;
  final bool isRead;
  final String senderId;
  final String text;

  const Message({
    required this.createdAt,
    required this.isRead,
    required this.senderId,
    required this.text,
  });

  factory Message.fromMap(Map<String, dynamic> data) {
    return Message(
      createdAt: data['createdAt'] ?? Timestamp.now(),
      isRead: data['isRead'],
      senderId: data['senderId'],
      text: data['text'],
    );
  }
}
