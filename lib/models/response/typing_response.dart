class TypingResponse {
  final bool isTyping;
  TypingResponse({required this.isTyping});

  factory TypingResponse.fromJson(Map<String, dynamic> json) {
    return TypingResponse(isTyping: json["isTyping"] ?? false);
  }
}
