part of 'chat_cubit.dart';

@freezed
class ChatState with _$ChatState {
  const factory ChatState({
    @Default(StatusType.init) StatusType status,
    String? msg,
    @Default([]) List<Chat> chats,
  }) = _ChatState;
}
