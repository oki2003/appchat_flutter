import "package:appchat_flutter/models/app_user.dart";

enum ChatType { private, group }

class Chat {
  final int id;
  final ChatType type;
  final String? name;
  final String? avatarUrl;
  final String lastMessage;
  final AppUser friend;

  const Chat({
    required this.id,
    required this.type,
    this.name,
    this.avatarUrl,
    required this.lastMessage,
    required this.friend,
  });

  factory Chat.fromJSON(Map<String, dynamic> json) => Chat(
    id: json["id"],
    type: ChatType.values.byName(json["type"]),
    name: json["name"],
    avatarUrl: json["avatarUrl"],
    lastMessage: json["lastMessage"]["type"] == "text"
        ? json["lastMessage"]["content"]
        : "Đã gửi một file",
    friend: AppUser.fromJSON(json["participants"][0]["user"]),
  );
}
