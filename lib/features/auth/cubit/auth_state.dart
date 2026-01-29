part of 'auth_cubit.dart';

@freezed
class AuthState with _$AuthState {
  const factory AuthState({
    @Default(StatusType.init) StatusType status,
    String? msg,
    AppUser? appUser,
    @Default(false) bool isAuthenticated,
  }) = _AuthState;
}
