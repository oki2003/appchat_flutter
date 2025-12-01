import 'package:appchat_flutter/repositories/auth_repository.dart';
import 'package:flutter/material.dart';

class AuthenticationViewModel extends ChangeNotifier {
  final gmailController = TextEditingController();
  final passwordController = TextEditingController();
  final usernameController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  final AuthRepository authRepository;
  bool isLoading = false;
  bool isSuccess = false;
  String errorMessage = '';

  AuthenticationViewModel(this.authRepository);

  Future<void> login() async {
    isLoading = true;
    errorMessage = '';
    notifyListeners();
    try {
      await authRepository.login(gmailController.text, passwordController.text);
      isSuccess = true;
    } catch (e) {
      isSuccess = false;
      isLoading = false;
      errorMessage = e.toString();
    }
    notifyListeners();
  }

  Future<void> register() async {
    isLoading = true;
    errorMessage = '';
    notifyListeners();
    try {
      await authRepository.register(
        gmailController.text,
        passwordController.text,
        usernameController.text,
      );
      isSuccess = true;
    } catch (e) {
      isSuccess = false;
      isLoading = false;
      errorMessage = e.toString();
    }
    notifyListeners();
  }
}
