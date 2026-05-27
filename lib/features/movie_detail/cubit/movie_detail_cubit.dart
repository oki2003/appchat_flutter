import 'package:appchat_flutter/enums/status_type.dart';
import 'package:appchat_flutter/models/comment.dart';
import 'package:appchat_flutter/models/movie.dart';
import 'package:appchat_flutter/services/movie_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'movie_detail_cubit.freezed.dart';
part 'movie_detail_state.dart';

class MovieDetailCubit extends Cubit<MovieDetailState> {
  MovieDetailCubit() : super(const MovieDetailState());

  final movieService = MovieService();

  Future<void> fetchComments(int idMovie) async {
    emit(state.copyWith(status: StatusType.loading));
    try {
      final data = await movieService.getComments(idMovie);
      final List<Comment> list = data
          .map((comment) => Comment.fromJson(comment))
          .toList();
      emit(state.copyWith(status: StatusType.loaded, comments: list));
    } catch (e) {
      emit(state.copyWith(status: StatusType.error, msg: e.toString()));
    }
  }
}
