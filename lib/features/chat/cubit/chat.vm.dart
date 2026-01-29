import 'dart:convert';

import 'package:appchat_flutter/models/app_user.dart';
import 'package:appchat_flutter/models/chat.dart';
import 'package:appchat_flutter/models/message.dart';
import 'package:appchat_flutter/services/chat.service.dart';
import 'package:appchat_flutter/services/local_storage.dart';
import 'package:dio/dio.dart';
import 'package:stacked/stacked.dart';

class ChatViewModel extends BaseViewModel {
  List<Chat> chats = [];
  List<Message> messages = [];
  String errorMessage = "";
  final ChatService chatService = ChatService();
  final AppUser currentUser = AppUser.fromJSON(
    jsonDecode(LocalStorage.pref!.getString("currentUser")!),
  );

  Future<void> init() async {
    try {
      setBusy(true);
      await fetchChats();
    } finally {
      setBusy(false);
    }
  }

  Future<void> fetchChats() async {
    try {
      final data = await chatService.getChats(currentUser.id);
      final list = data.map((json) => Chat.fromJSON(json)).toList();
      chats.addAll(list);
    } on DioException catch (e) {
      errorMessage = e.toString();
    }
  }

  Future<void> initMessages(String idChat) async {
    try {
      setBusy(true);
      await fetchMessages(idChat);
    } finally {
      setBusy(false);
    }
  }

  Future<void> fetchMessages(String idChat) async {
    try {
      final data = await chatService.getMessages(idChat);
      final list = data.map((json) => Message.fromJSON(json)).toList();
      messages.addAll(list);
    } on DioException catch (e) {
      errorMessage = e.toString();
    }
  }
}
