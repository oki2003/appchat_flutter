import 'package:appchat_flutter/constants/api.dart';
import 'package:appchat_flutter/core/network/api_client.dart';
import 'package:dio/dio.dart';

class MovieService {
  Future<List> getMovies() async {
    try {
      final response = await ApiClient.dio.get(Api.movies);
      return response.data["data"];
    } on DioException catch (e) {
      throw e.message ?? "Lấy danh sách phim thất bại";
    }
  }
}
