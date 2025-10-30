import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Chat {
  final String idChat;
  final int count;
  final String idLastUser;
  final String lastMessage;
  final Timestamp updatedAt;
  final String idFriend;
  final String nameFriend;
  final String avatarURLFriend;

  const Chat({
    required this.idChat,
    required this.count,
    required this.idLastUser,
    required this.lastMessage,
    required this.updatedAt,
    required this.idFriend,
    required this.nameFriend,
    required this.avatarURLFriend,
  });

  factory Chat.fromMap(Map<String, dynamic> data) {
    final currentUserId = FirebaseAuth.instance.currentUser!.uid;
    Map<String, dynamic> infoFriend;
    if (currentUserId != (data['user_1']['id'])) {
      infoFriend = data['user_1'];
    } else {
      infoFriend = data['user_2'];
    }
    return Chat(
      count: data['count'] ?? 0,
      idChat: data['idChat'],
      idLastUser: data['idLastUser'],
      lastMessage: data['lastMessage'],
      updatedAt: data['updatedAt'] ?? Timestamp.now(),
      idFriend: infoFriend['id'],
      nameFriend: infoFriend['name'],
      avatarURLFriend: infoFriend['avatarURL'],
    );
  }
}
