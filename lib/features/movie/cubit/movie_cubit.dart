import 'package:appchat_flutter/enums/status_type.dart';
import 'package:appchat_flutter/models/movie.dart';
import 'package:appchat_flutter/services/movie_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'movie_cubit.freezed.dart';
part 'movie_state.dart';

class MovieCubit extends Cubit<MovieState> {
  MovieCubit() : super(const MovieState());

  final movieService = MovieService();

  Future<void> fetchMovies() async {
    emit(state.copyWith(status: StatusType.loading));
    try {
      final data = await movieService.getMovies();
      final List<Movie> list = data
          .map((movie) => Movie.fromJson(movie))
          .toList();
      emit(state.copyWith(status: StatusType.loaded, movies: list));
    } catch (e) {
      emit(state.copyWith(status: StatusType.error, msg: e.toString()));
    }
  }
}
