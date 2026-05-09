import 'package:appchat_flutter/constants/api.dart';
import 'package:appchat_flutter/core/network/api_client.dart';
import 'package:dio/dio.dart';

class ChatService {
  Future<List> getChats() async {
    try {
      final response = await ApiClient.dio.get(Api.chats);
      return response.data["data"];
    } on DioException catch (e) {
      throw e.message ?? "Lấy danh sách chat thất bại";
    }
  }

  Future<List> getMessages(int idChat) async {
    try {
      final response = await ApiClient.dio.get(Api.messages(idChat));
      return response.data["data"];
    } on DioException catch (e) {
      throw e.message ?? "Tải tin nhắn thất bại";
    }
  }

  Future<List> getMoreMessages(
    int idChat,
    int cursorId,
    DateTime cursorCreatedAt,
  ) async {
    try {
      final response = await ApiClient.dio.get(
        Api.moreMessages(idChat, cursorId, cursorCreatedAt),
      );
      return response.data["data"];
    } on DioException catch (e) {
      throw e.message ?? "Tải tin nhắn thất bại";
    }
  }
}
