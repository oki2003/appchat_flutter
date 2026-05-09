import "package:appchat_flutter/enums/message_status.dart";

class Message {
  int? id;
  int? chatId;
  final int senderId;
  final String content;
  DateTime? createdAt;
  MessageStatus status;

  Message({
    this.id,
    this.chatId,
    required this.senderId,
    required this.content,
    this.createdAt,
    this.status = MessageStatus.sent,
  });

  Message copyWith({
    int? id,
    int? chatId,
    int? senderId,
    String? content,
    DateTime? createdAt,
    MessageStatus? status,
  }) {
    return Message(
      id: id ?? this.id,
      chatId: chatId ?? this.chatId,
      senderId: senderId ?? this.senderId,
      content: content ?? this.content,
      createdAt: createdAt ?? this.createdAt,
      status: status ?? this.status,
    );
  }

  factory Message.fromJSON(Map<String, dynamic> json) => Message(
    id: json["id"],
    chatId: json["chatId"],
    senderId: json["senderId"],
    content: json["content"],
    createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
    status: MessageStatus.sent,
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "chatId": chatId,
    "senderId": senderId,
    "content": content,
    "createdAt": createdAt,
  };
}
