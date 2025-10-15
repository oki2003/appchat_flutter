import 'package:appchat_flutter/models/friend.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Chat {
  final String idChat;
  final int count;
  final String idLastUser;
  final String lastMessage;
  final Timestamp updatedAt;
  final Friend friend;

  const Chat({
    required this.idChat,
    required this.count,
    required this.idLastUser,
    required this.lastMessage,
    required this.updatedAt,
    required this.friend,
  });

  factory Chat.fromMap(Map<String, dynamic> data, Friend friend) {
    return Chat(
      count: data['count'] ?? 0,
      idChat: data['idChat'],
      idLastUser: data['idLastUser'],
      lastMessage: data['lastMessage'],
      updatedAt: data['updatedAt'] ?? Timestamp.now(),
      friend: friend,
    );
  }
}
