// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'chat_detail_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$ChatDetailState {
  StatusType get status => throw _privateConstructorUsedError;
  String? get msg => throw _privateConstructorUsedError;
  bool get isTyping => throw _privateConstructorUsedError;
  List<Message> get messages => throw _privateConstructorUsedError;

  /// Create a copy of ChatDetailState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ChatDetailStateCopyWith<ChatDetailState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ChatDetailStateCopyWith<$Res> {
  factory $ChatDetailStateCopyWith(
    ChatDetailState value,
    $Res Function(ChatDetailState) then,
  ) = _$ChatDetailStateCopyWithImpl<$Res, ChatDetailState>;
  @useResult
  $Res call({
    StatusType status,
    String? msg,
    bool isTyping,
    List<Message> messages,
  });
}

/// @nodoc
class _$ChatDetailStateCopyWithImpl<$Res, $Val extends ChatDetailState>
    implements $ChatDetailStateCopyWith<$Res> {
  _$ChatDetailStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ChatDetailState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? msg = freezed,
    Object? isTyping = null,
    Object? messages = null,
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
            isTyping: null == isTyping
                ? _value.isTyping
                : isTyping // ignore: cast_nullable_to_non_nullable
                      as bool,
            messages: null == messages
                ? _value.messages
                : messages // ignore: cast_nullable_to_non_nullable
                      as List<Message>,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ChatDetailStateImplCopyWith<$Res>
    implements $ChatDetailStateCopyWith<$Res> {
  factory _$$ChatDetailStateImplCopyWith(
    _$ChatDetailStateImpl value,
    $Res Function(_$ChatDetailStateImpl) then,
  ) = __$$ChatDetailStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    StatusType status,
    String? msg,
    bool isTyping,
    List<Message> messages,
  });
}

/// @nodoc
class __$$ChatDetailStateImplCopyWithImpl<$Res>
    extends _$ChatDetailStateCopyWithImpl<$Res, _$ChatDetailStateImpl>
    implements _$$ChatDetailStateImplCopyWith<$Res> {
  __$$ChatDetailStateImplCopyWithImpl(
    _$ChatDetailStateImpl _value,
    $Res Function(_$ChatDetailStateImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ChatDetailState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? msg = freezed,
    Object? isTyping = null,
    Object? messages = null,
  }) {
    return _then(
      _$ChatDetailStateImpl(
        status: null == status
            ? _value.status
            : status // ignore: cast_nullable_to_non_nullable
                  as StatusType,
        msg: freezed == msg
            ? _value.msg
            : msg // ignore: cast_nullable_to_non_nullable
                  as String?,
        isTyping: null == isTyping
            ? _value.isTyping
            : isTyping // ignore: cast_nullable_to_non_nullable
                  as bool,
        messages: null == messages
            ? _value._messages
            : messages // ignore: cast_nullable_to_non_nullable
                  as List<Message>,
      ),
    );
  }
}

/// @nodoc

class _$ChatDetailStateImpl implements _ChatDetailState {
  const _$ChatDetailStateImpl({
    this.status = StatusType.loading,
    this.msg,
    this.isTyping = false,
    final List<Message> messages = const [],
  }) : _messages = messages;

  @override
  @JsonKey()
  final StatusType status;
  @override
  final String? msg;
  @override
  @JsonKey()
  final bool isTyping;
  final List<Message> _messages;
  @override
  @JsonKey()
  List<Message> get messages {
    if (_messages is EqualUnmodifiableListView) return _messages;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_messages);
  }

  @override
  String toString() {
    return 'ChatDetailState(status: $status, msg: $msg, isTyping: $isTyping, messages: $messages)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ChatDetailStateImpl &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.msg, msg) || other.msg == msg) &&
            (identical(other.isTyping, isTyping) ||
                other.isTyping == isTyping) &&
            const DeepCollectionEquality().equals(other._messages, _messages));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    status,
    msg,
    isTyping,
    const DeepCollectionEquality().hash(_messages),
  );

  /// Create a copy of ChatDetailState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ChatDetailStateImplCopyWith<_$ChatDetailStateImpl> get copyWith =>
      __$$ChatDetailStateImplCopyWithImpl<_$ChatDetailStateImpl>(
        this,
        _$identity,
      );
}

abstract class _ChatDetailState implements ChatDetailState {
  const factory _ChatDetailState({
    final StatusType status,
    final String? msg,
    final bool isTyping,
    final List<Message> messages,
  }) = _$ChatDetailStateImpl;

  @override
  StatusType get status;
  @override
  String? get msg;
  @override
  bool get isTyping;
  @override
  List<Message> get messages;

  /// Create a copy of ChatDetailState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ChatDetailStateImplCopyWith<_$ChatDetailStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
