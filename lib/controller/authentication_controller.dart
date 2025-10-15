import 'package:firebase_auth/firebase_auth.dart';

class Authentication {
  Future<String> login(String email, String password) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return '';
    } on FirebaseAuthException catch (e) {
      String stringCode = e.code;
      if (stringCode == 'invalid-email') {
        return 'Email không hợp lệ';
      } else if (stringCode == 'user-disabled') {
        return 'Tài khoản của bạn đã bị khóa.';
      } else if (stringCode == 'user-not-found') {
        return 'Không tìm thấy email này.';
      } else if (stringCode == 'network-request-failed') {
        return 'Kiểm tra kết nối mạng và thử lại.';
      } else {
        return 'Sai tên đăng nhập hoặc mật khẩu.';
      }
    }
  }

  Future<String> register(
    String email,
    String password,
    String username,
  ) async {
    try {
      final userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);

      // Update profile user with username
      await userCredential.user!.updateDisplayName(username);
      return '';
    } on FirebaseAuthException catch (e) {
      String stringCode = e.code;
      if (stringCode == 'email-already-in-use') {
        return 'Gmail này đã được đăng kí.';
      } else if (stringCode == 'invalid-email') {
        return 'Gmail không hợp lệ.';
      } else if (stringCode == 'weak-password') {
        return 'Mật khẩu quá yếu.';
      } else {
        return 'Có lỗi khi đăng kí.';
      }
    }
  }

  auth() {
    if (FirebaseAuth.instance.currentUser == null) {
      return false;
    } else {
      return true;
    }
  }
}
