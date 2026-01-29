import 'package:appchat_flutter/enums/status_type.dart';
import 'package:appchat_flutter/features/auth/cubit/auth_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<StatefulWidget> createState() => _RegisterScreen();
}

class _RegisterScreen extends State<RegisterScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final nameController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          _buildContent(),
          BlocConsumer<AuthCubit, AuthState>(
            listener: (context, state) {
              final status = state.status;
              if (status == StatusType.error) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(state.msg ?? "Đăng kí thất bại"),
                    backgroundColor: Colors.red,
                  ),
                );
              }
              if (status == StatusType.loaded) {
                Navigator.pushReplacementNamed(context, "/app");
              }
            },
            builder: (context, state) {
              if (state.status == StatusType.loading) {
                return const Stack(
                  children: [
                    Opacity(
                      opacity: 0.6,
                      child: ModalBarrier(
                        dismissible: false,
                        color: Colors.black,
                      ),
                    ),
                    Center(child: CircularProgressIndicator()),
                  ],
                );
              } else {
                return const SizedBox.shrink();
              }
            },
          ),
        ],
      ),
    );
  }

  Widget _buildContent() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset('assets/logo.png', width: 150),
          Text('Tech Social', style: Theme.of(context).textTheme.titleLarge),
          Text(
            'Tạo tài khoản của bạn',
            style: const TextStyle(height: 3, color: Color(0xFF71717A)),
          ),
          Padding(
            padding: const EdgeInsets.all(25),
            child: Container(
              padding: const EdgeInsets.all(30),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadiusGeometry.all(Radius.circular(14)),
                boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 3)],
              ),
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Tên của bạn',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        height: 2,
                      ),
                    ),
                    TextFormField(
                      controller: nameController,
                      decoration: const InputDecoration(hintText: ''),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Không được để trống";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),
                    Text(
                      'Email',
                      style: TextStyle(fontWeight: FontWeight.bold, height: 2),
                    ),
                    TextFormField(
                      controller: emailController,
                      decoration: const InputDecoration(
                        hintText: 'abc@example.com',
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Không được để trống";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'Mật khẩu',
                      style: TextStyle(fontWeight: FontWeight.bold, height: 2),
                    ),
                    TextFormField(
                      controller: passwordController,
                      obscureText: true,
                      decoration: const InputDecoration(hintText: '*********'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Không được để trống";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      width: double.infinity,
                      height: 40,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadiusGeometry.all(
                              Radius.circular(10),
                            ),
                          ),
                        ),
                        onPressed: () async {
                          if (formKey.currentState!.validate()) {
                            context.read<AuthCubit>().register(
                              emailController.text,
                              nameController.text,
                              passwordController.text,
                            );
                          }
                        },
                        child: const Text('Đăng kí'),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Đã có tài khoản?',
                          style: TextStyle(height: 3),
                        ),
                        TextButton(
                          style: TextButton.styleFrom(
                            overlayColor: Colors.transparent,
                          ),
                          onPressed: () {
                            Navigator.pushReplacementNamed(context, '/login');
                          },
                          child: const Text('Đăng nhập'),
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
    );
  }
}
