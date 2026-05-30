part of 'movie_detail_cubit.dart';

@freezed
class MovieDetailState with _$MovieDetailState {
  const factory MovieDetailState({
    @Default(StatusType.init) StatusType status,
    String? msg,
    @Default([]) List<Comment> comments,
    @Default([]) List<Actor> actors,
  }) = _MovieDetailState;
}
