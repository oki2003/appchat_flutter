import 'package:appchat_flutter/enums/status_type.dart';
import 'package:appchat_flutter/models/movie.dart';
import 'package:appchat_flutter/services/movie_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'movies_cubit.freezed.dart';
part 'movies_state.dart';

class MoviesCubit extends Cubit<MoviesState> {
  MoviesCubit() : super(const MoviesState());

  final movieService = MovieService();

  Future<void> fetchMovies() async {
    emit(state.copyWith(status: StatusType.loading));
    try {
      final data = await movieService.getMovies();
      final List<Movie> list = data
          .map((movie) => Movie.fromJson(movie))
          .toList();
      emit(
        state.copyWith(
          status: StatusType.loaded,
          movieBanner: list.first,
          trendingMovies: list.sublist(1, 14),
          allMovies: list.sublist(14, 20),
        ),
      );
    } catch (e) {
      emit(state.copyWith(status: StatusType.error, msg: e.toString()));
    }
  }
}
