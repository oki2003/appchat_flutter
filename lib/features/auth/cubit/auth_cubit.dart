import 'package:appchat_flutter/enums/status_type.dart';
import 'package:appchat_flutter/models/app_user.dart';
import 'package:appchat_flutter/services/auth.service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_cubit.freezed.dart';
part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthService authService = AuthService();

  AuthCubit() : super(const AuthState());

  Future<void> login(String email, String password) async {
    emit(state.copyWith(status: StatusType.loading));
    try {
      final AppUser user = await authService.login(email, password);
      emit(
        state.copyWith(
          status: StatusType.loaded,
          appUser: user,
          isAuthenticated: true,
        ),
      );
    } catch (e) {
      emit(state.copyWith(status: StatusType.error, msg: e.toString()));
    }
  }

  Future<void> auth() async {
    try {
      final AppUser user = await authService.auth();
      emit(state.copyWith(isAuthenticated: true, appUser: user));
    } catch (e) {
      emit(state.copyWith(isAuthenticated: false));
    }
  }

  Future<void> register(String email, String name, String password) async {
    try {
      emit(state.copyWith(status: StatusType.loading));
      final AppUser user = await authService.register(email, name, password);
      emit(
        state.copyWith(
          status: StatusType.loaded,
          isAuthenticated: true,
          appUser: user,
        ),
      );
    } catch (e) {
      emit(state.copyWith(status: StatusType.error, msg: e.toString()));
    }
  }
}
