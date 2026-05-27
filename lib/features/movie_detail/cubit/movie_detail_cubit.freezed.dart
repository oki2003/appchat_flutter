// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'movie_detail_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$MovieDetailState {
  StatusType get status => throw _privateConstructorUsedError;
  String? get msg => throw _privateConstructorUsedError;
  List<Comment> get comments => throw _privateConstructorUsedError;

  /// Create a copy of MovieDetailState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $MovieDetailStateCopyWith<MovieDetailState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MovieDetailStateCopyWith<$Res> {
  factory $MovieDetailStateCopyWith(
    MovieDetailState value,
    $Res Function(MovieDetailState) then,
  ) = _$MovieDetailStateCopyWithImpl<$Res, MovieDetailState>;
  @useResult
  $Res call({StatusType status, String? msg, List<Comment> comments});
}

/// @nodoc
class _$MovieDetailStateCopyWithImpl<$Res, $Val extends MovieDetailState>
    implements $MovieDetailStateCopyWith<$Res> {
  _$MovieDetailStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of MovieDetailState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? msg = freezed,
    Object? comments = null,
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
            comments: null == comments
                ? _value.comments
                : comments // ignore: cast_nullable_to_non_nullable
                      as List<Comment>,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$MovieDetailStateImplCopyWith<$Res>
    implements $MovieDetailStateCopyWith<$Res> {
  factory _$$MovieDetailStateImplCopyWith(
    _$MovieDetailStateImpl value,
    $Res Function(_$MovieDetailStateImpl) then,
  ) = __$$MovieDetailStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({StatusType status, String? msg, List<Comment> comments});
}

/// @nodoc
class __$$MovieDetailStateImplCopyWithImpl<$Res>
    extends _$MovieDetailStateCopyWithImpl<$Res, _$MovieDetailStateImpl>
    implements _$$MovieDetailStateImplCopyWith<$Res> {
  __$$MovieDetailStateImplCopyWithImpl(
    _$MovieDetailStateImpl _value,
    $Res Function(_$MovieDetailStateImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of MovieDetailState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? msg = freezed,
    Object? comments = null,
  }) {
    return _then(
      _$MovieDetailStateImpl(
        status: null == status
            ? _value.status
            : status // ignore: cast_nullable_to_non_nullable
                  as StatusType,
        msg: freezed == msg
            ? _value.msg
            : msg // ignore: cast_nullable_to_non_nullable
                  as String?,
        comments: null == comments
            ? _value._comments
            : comments // ignore: cast_nullable_to_non_nullable
                  as List<Comment>,
      ),
    );
  }
}

/// @nodoc

class _$MovieDetailStateImpl implements _MovieDetailState {
  const _$MovieDetailStateImpl({
    this.status = StatusType.init,
    this.msg,
    final List<Comment> comments = const [],
  }) : _comments = comments;

  @override
  @JsonKey()
  final StatusType status;
  @override
  final String? msg;
  final List<Comment> _comments;
  @override
  @JsonKey()
  List<Comment> get comments {
    if (_comments is EqualUnmodifiableListView) return _comments;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_comments);
  }

  @override
  String toString() {
    return 'MovieDetailState(status: $status, msg: $msg, comments: $comments)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MovieDetailStateImpl &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.msg, msg) || other.msg == msg) &&
            const DeepCollectionEquality().equals(other._comments, _comments));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    status,
    msg,
    const DeepCollectionEquality().hash(_comments),
  );

  /// Create a copy of MovieDetailState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MovieDetailStateImplCopyWith<_$MovieDetailStateImpl> get copyWith =>
      __$$MovieDetailStateImplCopyWithImpl<_$MovieDetailStateImpl>(
        this,
        _$identity,
      );
}

abstract class _MovieDetailState implements MovieDetailState {
  const factory _MovieDetailState({
    final StatusType status,
    final String? msg,
    final List<Comment> comments,
  }) = _$MovieDetailStateImpl;

  @override
  StatusType get status;
  @override
  String? get msg;
  @override
  List<Comment> get comments;

  /// Create a copy of MovieDetailState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MovieDetailStateImplCopyWith<_$MovieDetailStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
