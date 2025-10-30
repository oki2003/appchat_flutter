import 'package:appchat_flutter/view_models/authentication_view_model.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _LoginScreen();
  }
}

class _LoginScreen extends State<LoginScreen> {
  late final AuthenticationViewModel viewModel;

  @override
  void initState() {
    super.initState();
    viewModel = AuthenticationViewModel();
  }

  @override
  void dispose() {
    viewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListenableBuilder(
        listenable: viewModel,
        builder: (context, child) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (viewModel.errorMessage != '') {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(viewModel.errorMessage),
                  backgroundColor: Colors.red,
                ),
              );
            }
            if (viewModel.isSuccess) {
              Navigator.pushReplacementNamed(context, '/');
            }
          });

          return Stack(
            children: [
              Center(
                child: Column(
                  children: [
                    Image.asset('assets/logo.png', width: 150),
                    Text(
                      'Chào mừng trở lại',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    Text(
                      'Đăng nhập để tiếp tục',
                      style: TextStyle(height: 3, color: Color(0xFF71717A)),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(25),
                      child: Container(
                        padding: EdgeInsets.all(30),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(14),
                          boxShadow: const [
                            BoxShadow(color: Colors.black26, blurRadius: 3),
                          ],
                        ),
                        child: Form(
                          key: viewModel.formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Gmail',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  height: 2,
                                ),
                              ),
                              TextFormField(
                                controller: viewModel.gmailController,
                                decoration: InputDecoration(
                                  hintText: 'abc@example.com',
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "Không được để trống";
                                  }
                                  return null;
                                },
                              ),
                              SizedBox(height: 20),
                              Text(
                                'Mật khẩu',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  height: 2,
                                ),
                              ),
                              TextFormField(
                                controller: viewModel.passwordController,
                                obscureText: true,
                                decoration: InputDecoration(
                                  hintText: '*********',
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "Không được để trống";
                                  }
                                  return null;
                                },
                              ),
                              SizedBox(height: 20),
                              SizedBox(
                                width: double.infinity,
                                height: 40,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadiusGeometry.circular(10),
                                    ),
                                  ),
                                  onPressed: () {
                                    if (viewModel.formKey.currentState!
                                        .validate()) {
                                      viewModel.login();
                                    }
                                  },
                                  child: Text('Đăng nhập'),
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Chưa có tài khoản?',
                                    style: TextStyle(height: 3),
                                  ),
                                  TextButton(
                                    style: TextButton.styleFrom(
                                      overlayColor: Colors.transparent,
                                    ),
                                    onPressed: () {
                                      Navigator.pushReplacementNamed(
                                        context,
                                        '/register',
                                      );
                                    },
                                    child: Text('Đăng kí'),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              if (viewModel.isLoading)
                const Opacity(
                  opacity: 0.6,
                  child: ModalBarrier(dismissible: false, color: Colors.black),
                ),
              if (viewModel.isLoading)
                const Center(child: CircularProgressIndicator()),
            ],
          );
        },
      ),
    );
  }
}
