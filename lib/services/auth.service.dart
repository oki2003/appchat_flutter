import 'dart:convert';

import 'package:appchat_flutter/constants/api.dart';
import 'package:appchat_flutter/core/network/api_client.dart';
import 'package:appchat_flutter/models/app_user.dart';
import 'package:appchat_flutter/services/local_storage.dart';
import 'package:appchat_flutter/services/socket.service.dart';
import 'package:dio/dio.dart';

class AuthService {
  Future<AppUser> login(userName, password) async {
    try {
      final response = await ApiClient.dio.post(
        Api.login,
        data: {"userName": userName, "password": password},
      );
      final AppUser currentUser = await _handleAuthServiceSuccess(response);
      return currentUser;
    } on DioException catch (e) {
      throw e.message ?? "Đăng nhập thất bại";
    }
  }

  Future<AppUser> register(
    String userName,
    String displayName,
    String password,
  ) async {
    try {
      final response = await ApiClient.dio.post(
        Api.register,
        data: {
          "userName": userName,
          "displayName": displayName,
          "password": password,
        },
      );
      final AppUser currentUser = await _handleAuthServiceSuccess(response);
      return currentUser;
    } on DioException catch (e) {
      throw e.message ?? "Đăng kí thất bại";
    }
  }

  Future<AppUser> auth() async {
    final token = LocalStorage.pref?.getString("token");
    if (token != null) {
      try {
        final response = await ApiClient.dio.get(Api.auth);
        final currentUser = response.data["data"];
        await LocalStorage.pref!.setString(
          "currentUser",
          jsonEncode(currentUser),
        );
        SocketService().connect(token);
        return AppUser.fromJSON(currentUser);
      } on DioException catch (e) {
        if (e.response?.statusCode == 403) {
          await LocalStorage.pref!.remove("token");
        }
        throw e.message ?? "Xác thực thất bại";
      }
    }
    throw "Xác thực thất bại";
  }

  Future<AppUser> _handleAuthServiceSuccess(response) async {
    final token = response.data["data"]["token"];
    final currentUser = response.data["data"];
    await LocalStorage.pref!.setString("token", token);
    await LocalStorage.pref!.setString("currentUser", jsonEncode(currentUser));
    SocketService().connect(token);
    return AppUser.fromJSON(currentUser);
  }
}
