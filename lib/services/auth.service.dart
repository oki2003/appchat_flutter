import 'dart:convert';

import 'package:appchat_flutter/constants/api.dart';
import 'package:appchat_flutter/core/network/api_client.dart';
import 'package:appchat_flutter/models/app_user.dart';
import 'package:appchat_flutter/services/local_storage.dart';
import 'package:dio/dio.dart';

class AuthService {
  Future<AppUser> login(email, password) async {
    try {
      final response = await ApiClient.dio.post(
        Api.login,
        data: {"email": email, "password": password},
      );
      final AppUser currentUser = await _handleAuthServiceSuccess(response);
      return currentUser;
    } on DioException catch (e) {
      throw e.message ?? "Đăng nhập thất bại";
    }
  }

  Future<AppUser> register(String email, String name, String password) async {
    try {
      final response = await ApiClient.dio.post(
        Api.register,
        data: {"email": email, "name": name, "password": password},
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
        final response = await ApiClient.dio.get(
          Api.auth,
          options: Options(headers: {"Cookie": "token=$token"}),
        );
        final AppUser currentUser = await _handleAuthServiceSuccess(response);
        return currentUser;
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
    final token = response.data["token"];
    final currentUser = response.data["currentUser"];
    await LocalStorage.pref!.setString("token", token);
    await LocalStorage.pref!.setString("currentUser", jsonEncode(currentUser));
    return AppUser.fromJSON(currentUser);
  }
}
