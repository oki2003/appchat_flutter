import 'package:appchat_flutter/models/app_user.dart';

class Chat {
  final String idChat;
  final int isBlock;
  final AppUser friend;
  final int unreadMessages;
  final String? userIdReceive;
  final bool status;

  const Chat({
    required this.idChat,
    required this.isBlock,
    required this.friend,
    required this.unreadMessages,
    required this.userIdReceive,
    required this.status,
  });

  factory Chat.fromJSON(Map<String, dynamic> json) => Chat(
    idChat: json["friendshipsID"],
    isBlock: json["isBlock"],
    friend: AppUser(
      id: json["id"],
      email: json["email"],
      name: json["name"],
      avatarURL: json["avatarURL"],
      backgroundURL: json["backgroundURL"],
    ),
    unreadMessages: json["unreadMessages"],
    status: json["status"],
    userIdReceive: json["userIdReceive"],
  );
}
