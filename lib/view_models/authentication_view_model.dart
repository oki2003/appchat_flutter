import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthenticationViewModel extends ChangeNotifier {
  final gmailController = TextEditingController();
  final passwordController = TextEditingController();
  final usernameController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  bool isLoading = false;
  bool isSuccess = false;
  String errorMessage = '';

  Future<void> login() async {
    isLoading = true;
    errorMessage = '';
    notifyListeners();
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: gmailController.text,
        password: passwordController.text,
      );
      isSuccess = true;
    } on FirebaseAuthException catch (e) {
      isSuccess = false;
      isLoading = false;
      String stringCode = e.code;
      if (stringCode == 'invalid-email') {
        errorMessage = 'Email không hợp lệ';
      } else if (stringCode == 'user-disabled') {
        errorMessage = 'Tài khoản của bạn đã bị khóa.';
      } else if (stringCode == 'user-not-found') {
        errorMessage = 'Không tìm thấy email này.';
      } else if (stringCode == 'network-request-failed') {
        errorMessage = 'Kiểm tra kết nối mạng và thử lại.';
      } else {
        errorMessage = 'Sai tên đăng nhập hoặc mật khẩu.';
      }
    }
    notifyListeners();
  }

  Future<void> register() async {
    isLoading = true;
    errorMessage = '';
    notifyListeners();
    try {
      final userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
            email: gmailController.text,
            password: passwordController.text,
          );

      // Update profile user with username
      await userCredential.user!.updateDisplayName(usernameController.text);
      isSuccess = true;
    } on FirebaseAuthException catch (e) {
      isSuccess = false;
      isLoading = false;
      String stringCode = e.code;
      if (stringCode == 'email-already-in-use') {
        errorMessage = 'Gmail này đã được đăng kí.';
      } else if (stringCode == 'invalid-email') {
        errorMessage = 'Gmail không hợp lệ.';
      } else if (stringCode == 'weak-password') {
        errorMessage = 'Mật khẩu quá yếu.';
      } else {
        errorMessage = 'Có lỗi khi đăng kí.';
      }
    }
    notifyListeners();
  }
}
