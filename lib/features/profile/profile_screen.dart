import 'package:appchat_flutter/features/auth/cubit/auth_cubit.dart';
import 'package:appchat_flutter/widgets/user_presence.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final curUser = context.read<AuthCubit>().state.appUser;
    return Padding(
      padding: EdgeInsetsGeometry.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 30),
          Image.asset(
            curUser?.avatarUrl ?? "./assets/avatars/default.png",
            height: 160,
          ),
          const SizedBox(height: 10),
          Text(
            curUser?.displayName ?? "",
            style: TextStyle(fontSize: 27, fontWeight: FontWeight.bold),
          ),
          Text(
            "@${curUser?.userName}",
            style: TextStyle(
              fontSize: 17,
              color: Colors.black.withValues(alpha: 0.5),
            ),
          ),
          const SizedBox(height: 20),
          _buildProfileItemBar(
            Icons.person_outline_rounded,
            "Chỉnh sửa thông tin",
            () {},
          ),
          _buildProfileItemBar(Icons.people_outline_rounded, "Bạn bè", () {}),
          _buildProfileItemBar(
            Icons.security_rounded,
            "Chính sách bảo mật",
            () {},
          ),
          _buildProfileItemBar(Icons.help_outline_rounded, "Hỗ trợ", () {}),
          _buildProfileItemBar(Icons.logout_rounded, "Đăng xuất", () {
            context.read<AuthCubit>().logout();
            Navigator.pushReplacementNamed(context, "/login");
          }),
        ],
      ),
    );
  }

  Widget _buildProfileItemBar(IconData icon, String text, onPressed) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        width: double.infinity,
        height: 60,
        decoration: BoxDecoration(
          color: Color(0xFF7C3AED),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            Expanded(flex: 1, child: Icon(icon, color: Colors.white)),
            Expanded(
              flex: 8,
              child: Text(text, style: TextStyle(color: Colors.white)),
            ),
            const Expanded(
              flex: 1,
              child: Align(
                alignment: Alignment.centerRight,
                child: Icon(Icons.chevron_right_rounded, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
