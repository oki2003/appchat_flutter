import 'package:appchat_flutter/controller/authentication_controller.dart';
import 'package:flutter/material.dart';

class Register extends StatelessWidget {
  Register({super.key});

  final nameController = TextEditingController();
  final gmailController = TextEditingController();
  final passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  final Authentication authController = Authentication();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Image.asset('assets/logo.png', width: 150),
            Text('Tech Social', style: Theme.of(context).textTheme.titleLarge),
            Text(
              'Tạo tài khoản của bạn',
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
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Tên hiện thị',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          height: 2,
                        ),
                      ),
                      TextFormField(
                        controller: nameController,
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
                        'Gmail',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          height: 2,
                        ),
                      ),
                      TextFormField(
                        controller: gmailController,
                        decoration: InputDecoration(hintText: 'abc@gmail.com'),
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
                        controller: passwordController,
                        obscureText: true,
                        decoration: InputDecoration(hintText: '*********'),
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
                              borderRadius: BorderRadiusGeometry.circular(10),
                            ),
                          ),
                          onPressed: () async {
                            if (formKey.currentState!.validate()) {
                              showDialog(
                                context: context,
                                barrierDismissible: false,
                                builder: (context) =>
                                    Center(child: CircularProgressIndicator()),
                              );
                              final result = await authController.register(
                                gmailController.text,
                                passwordController.text,
                                nameController.text,
                              );
                              if (!context.mounted) return;
                              if (result == '') {
                                Navigator.pushReplacementNamed(context, '/');
                              } else {
                                Navigator.pop(context);
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(result),
                                    backgroundColor: Colors.red,
                                  ),
                                );
                              }
                            }
                          },
                          child: Text('Đăng kí'),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Đã có tài khoản?', style: TextStyle(height: 3)),
                          TextButton(
                            style: TextButton.styleFrom(
                              overlayColor: Colors.transparent,
                            ),
                            onPressed: () {
                              Navigator.pushNamed(context, '/');
                            },
                            child: Text('Đăng nhập'),
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
    );
  }
}
