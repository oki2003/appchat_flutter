import 'package:appchat_flutter/enums/status_type.dart';
import 'package:appchat_flutter/models/message.dart';
import 'package:appchat_flutter/services/chat.service.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'chat_detail_cubit.freezed.dart';
part 'chat_detail_state.dart';

class ChatDetailCubit extends Cubit<ChatDetailState> {
  ChatDetailCubit() : super(const ChatDetailState());

  final chatService = ChatService();

  Future<void> fetchMessages(String idChat) async {
    emit(state.copyWith(status: StatusType.loading));
    try {
      final data = await chatService.getMessages(idChat);
      final list = data.map((json) => Message.fromJSON(json)).toList();
      emit(state.copyWith(status: StatusType.loaded, messages: list));
    } on DioException catch (e) {
      emit(state.copyWith(status: StatusType.error, msg: e.toString()));
    }
  }
}
