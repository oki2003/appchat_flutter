part of 'chat_detail_cubit.dart';

@freezed
class ChatDetailState with _$ChatDetailState {
  const factory ChatDetailState({
    @Default(StatusType.loading) StatusType status,
    String? msg,
    @Default(false) bool isTyping,
    @Default([]) List<Message> messages,
  }) = _ChatDetailState;
}
