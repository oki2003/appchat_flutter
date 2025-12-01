import 'package:appchat_flutter/services/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthRepository {
  final AuthService authService;

  AuthRepository(this.authService);

  Future<User?> login(email, password) async {
    try {
      return await authService.login(email, password);
    } on FirebaseAuthException catch (e) {
      String stringCode = e.code;
      if (stringCode == 'invalid-email') {
        throw 'Email không hợp lệ';
      } else if (stringCode == 'user-disabled') {
        throw 'Tài khoản của bạn đã bị khóa.';
      } else if (stringCode == 'user-not-found') {
        throw 'Không tìm thấy email này.';
      } else if (stringCode == 'network-request-failed') {
        throw 'Kiểm tra kết nối mạng và thử lại.';
      } else {
        throw 'Sai tên đăng nhập hoặc mật khẩu.';
      }
    }
  }

  Future<void> register(email, password, username) async {
    try {
      await authService.register(email, password, username);
    } on FirebaseAuthException catch (e) {
      String stringCode = e.code;
      if (stringCode == 'email-already-in-use') {
        throw 'Gmail này đã được đăng kí.';
      } else if (stringCode == 'invalid-email') {
        throw 'Gmail không hợp lệ.';
      } else if (stringCode == 'weak-password') {
        throw 'Mật khẩu quá yếu.';
      } else {
        throw 'Có lỗi khi đăng kí.';
      }
    }
  }
}
