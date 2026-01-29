// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'movies_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$MoviesState {
  StatusType get status => throw _privateConstructorUsedError;
  String? get msg => throw _privateConstructorUsedError;
  List<Movie> get trendingMovies => throw _privateConstructorUsedError;
  List<Movie> get allMovies => throw _privateConstructorUsedError;
  Movie? get movieBanner => throw _privateConstructorUsedError;

  /// Create a copy of MoviesState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $MoviesStateCopyWith<MoviesState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MoviesStateCopyWith<$Res> {
  factory $MoviesStateCopyWith(
    MoviesState value,
    $Res Function(MoviesState) then,
  ) = _$MoviesStateCopyWithImpl<$Res, MoviesState>;
  @useResult
  $Res call({
    StatusType status,
    String? msg,
    List<Movie> trendingMovies,
    List<Movie> allMovies,
    Movie? movieBanner,
  });
}

/// @nodoc
class _$MoviesStateCopyWithImpl<$Res, $Val extends MoviesState>
    implements $MoviesStateCopyWith<$Res> {
  _$MoviesStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of MoviesState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? msg = freezed,
    Object? trendingMovies = null,
    Object? allMovies = null,
    Object? movieBanner = freezed,
  }) {
    return _then(
      _value.copyWith(
            status: null == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                      as StatusType,
            msg: freezed == msg
                ? _value.msg
                : msg // ignore: cast_nullable_to_non_nullable
                      as String?,
            trendingMovies: null == trendingMovies
                ? _value.trendingMovies
                : trendingMovies // ignore: cast_nullable_to_non_nullable
                      as List<Movie>,
            allMovies: null == allMovies
                ? _value.allMovies
                : allMovies // ignore: cast_nullable_to_non_nullable
                      as List<Movie>,
            movieBanner: freezed == movieBanner
                ? _value.movieBanner
                : movieBanner // ignore: cast_nullable_to_non_nullable
                      as Movie?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$MoviesStateImplCopyWith<$Res>
    implements $MoviesStateCopyWith<$Res> {
  factory _$$MoviesStateImplCopyWith(
    _$MoviesStateImpl value,
    $Res Function(_$MoviesStateImpl) then,
  ) = __$$MoviesStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    StatusType status,
    String? msg,
    List<Movie> trendingMovies,
    List<Movie> allMovies,
    Movie? movieBanner,
  });
}

/// @nodoc
class __$$MoviesStateImplCopyWithImpl<$Res>
    extends _$MoviesStateCopyWithImpl<$Res, _$MoviesStateImpl>
    implements _$$MoviesStateImplCopyWith<$Res> {
  __$$MoviesStateImplCopyWithImpl(
    _$MoviesStateImpl _value,
    $Res Function(_$MoviesStateImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of MoviesState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? msg = freezed,
    Object? trendingMovies = null,
    Object? allMovies = null,
    Object? movieBanner = freezed,
  }) {
    return _then(
      _$MoviesStateImpl(
        status: null == status
            ? _value.status
            : status // ignore: cast_nullable_to_non_nullable
                  as StatusType,
        msg: freezed == msg
            ? _value.msg
            : msg // ignore: cast_nullable_to_non_nullable
                  as String?,
        trendingMovies: null == trendingMovies
            ? _value._trendingMovies
            : trendingMovies // ignore: cast_nullable_to_non_nullable
                  as List<Movie>,
        allMovies: null == allMovies
            ? _value._allMovies
            : allMovies // ignore: cast_nullable_to_non_nullable
                  as List<Movie>,
        movieBanner: freezed == movieBanner
            ? _value.movieBanner
            : movieBanner // ignore: cast_nullable_to_non_nullable
                  as Movie?,
      ),
    );
  }
}

/// @nodoc

class _$MoviesStateImpl implements _MoviesState {
  const _$MoviesStateImpl({
    this.status = StatusType.init,
    this.msg,
    final List<Movie> trendingMovies = const [],
    final List<Movie> allMovies = const [],
    this.movieBanner,
  }) : _trendingMovies = trendingMovies,
       _allMovies = allMovies;

  @override
  @JsonKey()
  final StatusType status;
  @override
  final String? msg;
  final List<Movie> _trendingMovies;
  @override
  @JsonKey()
  List<Movie> get trendingMovies {
    if (_trendingMovies is EqualUnmodifiableListView) return _trendingMovies;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_trendingMovies);
  }

  final List<Movie> _allMovies;
  @override
  @JsonKey()
  List<Movie> get allMovies {
    if (_allMovies is EqualUnmodifiableListView) return _allMovies;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_allMovies);
  }

  @override
  final Movie? movieBanner;

  @override
  String toString() {
    return 'MoviesState(status: $status, msg: $msg, trendingMovies: $trendingMovies, allMovies: $allMovies, movieBanner: $movieBanner)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MoviesStateImpl &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.msg, msg) || other.msg == msg) &&
            const DeepCollectionEquality().equals(
              other._trendingMovies,
              _trendingMovies,
            ) &&
            const DeepCollectionEquality().equals(
              other._allMovies,
              _allMovies,
            ) &&
            (identical(other.movieBanner, movieBanner) ||
                other.movieBanner == movieBanner));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    status,
    msg,
    const DeepCollectionEquality().hash(_trendingMovies),
    const DeepCollectionEquality().hash(_allMovies),
    movieBanner,
  );

  /// Create a copy of MoviesState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MoviesStateImplCopyWith<_$MoviesStateImpl> get copyWith =>
      __$$MoviesStateImplCopyWithImpl<_$MoviesStateImpl>(this, _$identity);
}

abstract class _MoviesState implements MoviesState {
  const factory _MoviesState({
    final StatusType status,
    final String? msg,
    final List<Movie> trendingMovies,
    final List<Movie> allMovies,
    final Movie? movieBanner,
  }) = _$MoviesStateImpl;

  @override
  StatusType get status;
  @override
  String? get msg;
  @override
  List<Movie> get trendingMovies;
  @override
  List<Movie> get allMovies;
  @override
  Movie? get movieBanner;

  /// Create a copy of MoviesState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MoviesStateImplCopyWith<_$MoviesStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
