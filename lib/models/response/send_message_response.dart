class SendMessageResponse {
  final bool success;
  final DateTime? createdAt;
  final int? chatId;
  final int? messageId;
  final int temporaryId;
  SendMessageResponse({
    required this.success,
    this.createdAt,
    this.chatId,
    this.messageId,
    required this.temporaryId,
  });

  factory SendMessageResponse.fromJson(Map<String, dynamic> json) {
    return SendMessageResponse(
      success: json["success"] ?? false,
      createdAt: DateTime.tryParse(json["data"]["createdAt"] ?? ""),
      messageId: json["data"]["messageId"],
      temporaryId: json["data"]["temporaryId"],
      chatId: json["data"]["chatId"],
    );
  }
}
