part of 'chat_detail_cubit.dart';

@freezed
class ChatDetailState with _$ChatDetailState {
  const factory ChatDetailState({
    @Default(StatusType.init) StatusType status,
    String? msg,
    @Default([]) List<Message> messages,
  }) = _ChatDetailState;
}
