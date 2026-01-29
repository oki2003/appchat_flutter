part of 'movies_cubit.dart';

@freezed
class MoviesState with _$MoviesState {
  const factory MoviesState({
    @Default(StatusType.init) StatusType status,
    String? msg,
    @Default([]) List<Movie> trendingMovies,
    @Default([]) List<Movie> allMovies,
    Movie? movieBanner,
  }) = _MoviesState;
}
