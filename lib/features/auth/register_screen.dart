import 'package:appchat_flutter/core/overlay/loading_overlay.dart';
import 'package:appchat_flutter/core/overlay/toast_overlay.dart';
import 'package:appchat_flutter/enums/status_type.dart';
import 'package:appchat_flutter/features/auth/cubit/auth_cubit.dart';
import 'package:appchat_flutter/theme/brand_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<StatefulWidget> createState() => _RegisterScreen();
}

class _RegisterScreen extends State<RegisterScreen> {
  final userNameController = TextEditingController();
  final passwordController = TextEditingController();
  final displayNameController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    userNameController.dispose();
    passwordController.dispose();
    displayNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final BrandAppTheme brandAppTheme = BrandAppTheme(context: context);
    return Scaffold(
      body: BlocListener<AuthCubit, AuthState>(
        listener: (context, state) {
          final status = state.status;
          LoadingOverlay.hideLoading();
          switch (status) {
            case StatusType.error:
              ToastOverlay.showToastBottom(state.msg!, false);
              break;
            case StatusType.loading:
              LoadingOverlay.showLoading();
              break;
            case StatusType.loaded:
              Navigator.pushReplacementNamed(context, "/app");
              break;
            default:
              break;
          }
        },
        child: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                brandAppTheme.primaryBrandColor,
                brandAppTheme.primaryLightBrandColor,
              ],
            ),
          ),
          child: TweenAnimationBuilder(
            tween: Tween(begin: 0.0, end: 1.0),
            duration: const Duration(milliseconds: 600),
            curve: Curves.easeOut,
            builder: (context, value, child) {
              return Opacity(
                opacity: value,
                child: Transform(
                  alignment: Alignment.center,
                  transform: Matrix4.identity()
                    ..translateByDouble(0, 40 * (1 - value), 0, 1)
                    ..scaleByDouble(0.9 + 0.1 * value, 0.9 + 0.1 * value, 1, 1),
                  child: child,
                ),
              );
            },
            child: _buildContent(brandAppTheme),
          ),
        ),
      ),
    );
  }

  Widget _buildContent(BrandAppTheme brandAppTheme) {
    return Center(
      child: Container(
        padding: const EdgeInsets.all(20),
        margin: const EdgeInsets.all(14),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadiusGeometry.all(Radius.circular(25)),
          boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 3)],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset('assets/logo.png', width: 80),
            Text('Tech Social', style: Theme.of(context).textTheme.titleLarge),
            const Text(
              'Tạo tài khoản của bạn',
              style: TextStyle(height: 3, color: Color(0xFF71717A)),
            ),
            Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Tên của bạn',
                    style: TextStyle(fontWeight: FontWeight.bold, height: 2),
                  ),
                  TextFormField(
                    controller: displayNameController,
                    decoration: const InputDecoration(hintText: ''),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Không được để trống";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'Tên đăng nhập',
                    style: TextStyle(fontWeight: FontWeight.bold, height: 2),
                  ),
                  TextFormField(
                    controller: userNameController,
                    decoration: const InputDecoration(
                      hintText: 'bigbangyutaka95',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Không được để trống";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 12),
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
                            userNameController.text,
                            displayNameController.text,
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
                          foregroundColor: brandAppTheme.primaryBrandColor,
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
          ],
        ),
      ),
    );
  }
}
