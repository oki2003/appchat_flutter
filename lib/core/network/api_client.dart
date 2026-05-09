import 'package:appchat_flutter/constants/api.dart';
import 'package:appchat_flutter/services/local_storage.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

// class LoggingInterceptor extends Interceptor {
class ApiClient {
  static final Dio dio =
      Dio(
          BaseOptions(
            baseUrl: Api.baseURL,
            connectTimeout: const Duration(seconds: 20),
            receiveTimeout: const Duration(seconds: 20),
            contentType: "application/json",
          ),
        )
        ..interceptors.add(
          InterceptorsWrapper(
            onRequest: (options, handler) {
              final token = LocalStorage.pref?.getString("token");
              options.headers["Authorization"] = "Bearer $token";
              handler.next(options);
            },
            onResponse: (response, handler) {
              if (kDebugMode) {
                debugPrint("StatusCode: ${response.statusCode}");
                debugPrint("Data: ${response.data}");
              }
              handler.next(response);
            },
            onError: (error, handler) {
              if (kDebugMode) {
                debugPrint("Error: ${error.message}");
              }
              switch (error.type) {
                case DioExceptionType.connectionTimeout:
                case DioExceptionType.sendTimeout:
                case DioExceptionType.receiveTimeout:
                  error = error.copyWith(message: "Kết nối quá thời gian");
                  break;
                case DioExceptionType.cancel:
                  error = error.copyWith(message: "Yêu cầu bị hủy");
                  break;
                case DioExceptionType.unknown:
                  error = error.copyWith(message: "Kiểm tra lại kết nối");
                  break;
                case DioExceptionType.connectionError:
                  error = error.copyWith(message: "Mất kết nối mạng");
                  break;
                case DioExceptionType.badResponse:
                  if (error.response?.statusCode == 403 ||
                      error.response?.statusCode == 401) {
                    String message =
                        error.response?.data["message"].toString() ?? "";
                    if (message == "Invalid account") {
                      error = error.copyWith(
                        message: "Sai tên đăng nhập hoặc mật khẩu",
                      );
                    } else {
                      error = error.copyWith(
                        message: "Bạn đã hết phiên đăng nhập",
                      );
                    }
                  } else {
                    error = error.copyWith(
                      message: error.response?.data["message"].toString(),
                    );
                  }
                  break;
                default:
                  error = error.copyWith(message: "Lỗi không xác định");
              }
              handler.next(error);
            },
          ),
        );
}
