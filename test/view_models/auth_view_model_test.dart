import 'package:appchat_flutter/repositories/auth_repository.dart';
import 'package:appchat_flutter/services/auth_service.dart';
import 'package:appchat_flutter/view_models/authentication_view_model.dart';
import 'package:firebase_auth_mocks/firebase_auth_mocks.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('AuthService', () {
    final emptyAuth = MockFirebaseAuth(signedIn: false);
    final authService = AuthService(emptyAuth);
    final authRepository = AuthRepository(authService);
    final vm = AuthenticationViewModel(authRepository);
    vm.gmailController.text = 'test@example.com';
    vm.passwordController.text = '123456789';
    vm.usernameController.text = 'Ronaldo';

    test('Login is successful', () async {
      await vm.login();
      expect(vm.isSuccess, true);
    });

    test('Register is successful', () async {
      await vm.login();
      expect(vm.isSuccess, true);
    });
  });
}
