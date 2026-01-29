class Message {
  final String content;
  final int idUserSend;
  final int idUserReceive;
  final bool isRead;
  final int type;
  final DateTime createdAt;

  const Message({
    required this.content,
    required this.idUserSend,
    required this.idUserReceive,
    required this.isRead,
    required this.type,
    required this.createdAt,
  });

  factory Message.fromJSON(Map<String, dynamic> json) => Message(
    content: json['content'],
    idUserSend: json['user_id_send'],
    idUserReceive: json['user_id_receive'],
    isRead: json['isRead'],
    type: json['typeId'],
    createdAt: DateTime.parse(json['createdAt']),
  );
}
