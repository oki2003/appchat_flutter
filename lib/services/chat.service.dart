import 'package:appchat_flutter/constants/api.dart';
import 'package:appchat_flutter/core/network/api_client.dart';
import 'package:dio/dio.dart';

class ChatService {
  Future<List> getChats(int idCurrentUser) async {
    try {
      final response = await ApiClient.dio.post(
        Api.friendships,
        data: {"id": idCurrentUser},
      );
      return response.data["data"];
    } on DioException catch (e) {
      throw e.message ?? "Lấy danh sách chat thất bại";
    }
  }

  Future<List> getMessages(String idChat) async {
    try {
      final response = await ApiClient.dio.get(Api.messages(idChat));
      return response.data["data"];
    } on DioException catch (e) {
      throw e.message ?? "Lấy danh sách chat thất bại";
    }
  }
}
