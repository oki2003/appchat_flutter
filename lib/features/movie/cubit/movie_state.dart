part of 'movie_cubit.dart';

@freezed
class MovieState with _$MovieState {
  const factory MovieState({
    @Default(StatusType.init) StatusType status,
    String? msg,
    @Default([]) List<Movie> movies,
  }) = _MovieState;
}
