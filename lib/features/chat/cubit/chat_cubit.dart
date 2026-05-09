import 'package:appchat_flutter/enums/status_type.dart';
import 'package:appchat_flutter/models/chat.dart';
import 'package:appchat_flutter/services/chat.service.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'chat_cubit.freezed.dart';
part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  ChatCubit() : super(const ChatState());

  final ChatService chatService = ChatService();

  Future<void> fetchChats() async {
    emit(state.copyWith(status: StatusType.loading));
    try {
      final data = await chatService.getChats();
      final list = data.map((json) => Chat.fromJSON(json)).toList();
      emit(state.copyWith(status: StatusType.loaded, chats: list));
    } catch (e) {
      emit(state.copyWith(status: StatusType.error, msg: e.toString()));
    }
  }
}
