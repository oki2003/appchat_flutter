import 'package:appchat_flutter/constants/api.dart';
import 'package:appchat_flutter/core/network/api_client.dart';
import 'package:dio/dio.dart';
import "package:flutter_dotenv/flutter_dotenv.dart";

class MovieService {
  Future<List> getMovies() async {
    try {
      final String apiKey = dotenv.env["API_KEY"] ?? "";
      final response = await ApiClient.dio.get(Api.movies(apiKey));
      return response.data["results"];
    } on DioException catch (e) {
      throw e.message ?? "Lấy danh sách phim thất bại";
    }
  }
}
