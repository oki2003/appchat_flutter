import 'dart:async';
import 'dart:convert';

import 'package:appchat_flutter/enums/message_status.dart';
import 'package:appchat_flutter/enums/socket_title.dart';
import 'package:appchat_flutter/enums/status_type.dart';
import 'package:appchat_flutter/models/app_user.dart';
import 'package:appchat_flutter/models/message.dart';
import 'package:appchat_flutter/models/response/send_message_response.dart';
import 'package:appchat_flutter/models/response/typing_response.dart';
import 'package:appchat_flutter/services/chat_service.dart';
import 'package:appchat_flutter/services/socket_service.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'chat_detail_cubit.freezed.dart';
part 'chat_detail_state.dart';

class ChatDetailCubit extends Cubit<ChatDetailState> {
  final chatService = ChatService();
  int? chatId;
  bool hasMore = true;
  late final StreamSubscription sub;
  ChatDetailCubit() : super(const ChatDetailState()) {
    sub = SocketService.messageController.stream.listen((
      Map<SocketTitle, dynamic> data,
    ) {
      if (isClosed) return;
      switch (data.keys.first) {
        case SocketTitle.sendMessage:
          _handleSendMessageResponse(data);
          break;
        case SocketTitle.receiveMessage:
          _handleReceiveMessageResponse(data);
          break;
        case SocketTitle.typing:
          _handleTypingResponse(data);
          break;
        default:
          break;
      }
    });
  }

  Future<void> fetchMessages(int? chatId) async {
    if (chatId == null) {
      emit(state.copyWith(status: StatusType.loaded, messages: []));
      return;
    }
    emit(state.copyWith(status: StatusType.loading));
    try {
      final data = await chatService.getMessages(chatId);
      final list = data.map((json) => Message.fromJSON(json)).toList();
      emit(state.copyWith(status: StatusType.loaded, messages: list));
    } catch (e) {
      emit(state.copyWith(status: StatusType.error, msg: e.toString()));
    }
  }

  Future<void> loadMoreMessages() async {
    if (!hasMore || state.status == StatusType.loadmore) return;
    emit(state.copyWith(status: StatusType.loadmore));
    final Message msg = state.messages.last;
    if (chatId == null || msg.id == null || msg.createdAt == null) {
      emit(state.copyWith(status: StatusType.loaded));
      return;
    }
    final data = await chatService.getMoreMessages(
      chatId!,
      msg.id!,
      msg.createdAt!,
    );
    if (data.isEmpty) {
      emit(state.copyWith(status: StatusType.loaded));
      hasMore = false;
      return;
    }
    final newListMessages = data.map((json) => Message.fromJSON(json)).toList();
    final List<Message> list = [...state.messages, ...newListMessages];
    emit(state.copyWith(status: StatusType.loaded, messages: list));
  }

  void sendMessage(String content, AppUser friend, AppUser? currentUser) async {
    try {
      if (currentUser == null) {
        // handle later
      } else {
        final Message msg = Message(
          chatId: chatId,
          senderId: currentUser.id,
          content: content,
          id: DateTime.now().microsecondsSinceEpoch.toInt(), // temporary id
          status: MessageStatus.sending,
        );
        final requestData = {"receiverId": friend.id, ...msg.toJson()};
        final List<Message> listMsg = [msg, ...state.messages];
        emit(state.copyWith(messages: listMsg));
        SocketService().sendToServer(SocketTitle.sendMessage, requestData);
      }
    } catch (_) {
      //handle later
    }
  }

  void startTyping(AppUser friend) {
    final requestData = {"receiverId": friend.id, "isTyping": true};
    SocketService().sendToServer(SocketTitle.typing, requestData);
  }

  void stopTyping(AppUser friend) {
    final requestData = {"receiverId": friend.id, "isTyping": false};
    SocketService().sendToServer(SocketTitle.typing, requestData);
  }

  void _handleSendMessageResponse(Map<SocketTitle, dynamic> data) {
    final key = SocketTitle.sendMessage;
    data[key] = SendMessageResponse.fromJson(data[key]!);
    final sendSuccess = data[key]!.success;
    final List<Message> listMsg = state.messages.map((msg) {
      if (msg.id == data[key]!.temporaryId) {
        return sendSuccess
            ? msg.copyWith(
                createdAt: data[key]!.createdAt!,
                id: data[key]!.messageId!,
                chatId: data[key]!.chatId!,
                status: MessageStatus.sent,
              )
            : msg.copyWith(status: MessageStatus.errorSending);
      }
      return msg;
    }).toList();
    chatId ??= data[key]!.chatId;

    emit(state.copyWith(messages: listMsg));
  }

  void _handleReceiveMessageResponse(Map<SocketTitle, dynamic> data) {
    final key = SocketTitle.receiveMessage;
    final Message msg = Message.fromJSON(data[key]["data"]);
    final List<Message> listMsg = [msg, ...state.messages];
    emit(state.copyWith(messages: listMsg));
  }

  void _handleTypingResponse(Map<SocketTitle, dynamic> data) {
    final key = SocketTitle.typing;
    final bool isTyping = TypingResponse.fromJson(data[key]["data"]).isTyping;
    emit(state.copyWith(isTyping: isTyping));
  }

  @override
  Future<void> close() {
    sub.cancel();
    return super.close();
  }
}
