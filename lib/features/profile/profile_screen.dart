import 'package:appchat_flutter/features/auth/cubit/auth_cubit.dart';
import 'package:appchat_flutter/models/app_user.dart';
import 'package:appchat_flutter/widgets/user_presence.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final AppUser? curUser = context.read<AuthCubit>().state.appUser;
    final double layoutHeight = (MediaQuery.of(context).size.height / 3) / 2;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        _buildHeader(curUser, layoutHeight),
        _buildOption(),
        _buildLogoutButton(context),
      ],
    );
  }

  Widget _buildHeader(AppUser? curUser, double layoutHeight) {
    return SizedBox(
      height: layoutHeight * 2,
      child: Stack(
        children: [
          Container(height: layoutHeight, color: Color(0xFF7C3AED)),
          Align(
            alignment: Alignment.center,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 0),
              child: Container(
                margin: const EdgeInsets.only(bottom: 12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.04),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.02),
                      blurRadius: 4,
                      offset: const Offset(0, 1),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16.0,
                      vertical: 12.0,
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: layoutHeight / 2,
                          height: layoutHeight / 2,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [
                                Color(0xFF812E6B), // Deep purple
                                Color(0xFFC73659), // Magenta/red-purple
                                Color(0xFFE65C40), // Red-orange
                              ],
                            ),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(26),
                            child: Image.asset(
                              curUser?.avatarUrl ??
                                  "./assets/avatars/default.png",
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) =>
                                  const Center(
                                    child: Icon(
                                      Icons.person_outline_rounded,
                                      color: Colors.white,
                                      size: 28,
                                    ),
                                  ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 14),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                curUser?.displayName ?? "",
                                style: const TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 20,
                                  color: Color(0xFF1E293B),
                                  letterSpacing: -0.2,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                curUser?.userName == null
                                    ? ""
                                    : "@${curUser!.userName}",
                                style: const TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 17,
                                  color: Color(0xFF64748B),
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOption() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SizedBox(
        width: double.infinity,
        child: Material(
          color: Colors.white,
          elevation: 0.4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
            side: BorderSide(
              color: Colors.black.withValues(alpha: 0.1),
              style: BorderStyle.solid,
              width: 1,
            ),
          ),
          child: Column(
            children: [
              _buildOptionItem(
                Icons.description_outlined,
                "Điều khoản sử dụng",
                isFirst: true,
                () {},
              ),
              Divider(color: Colors.black.withValues(alpha: 0.1), height: 0.8),
              _buildOptionItem(
                Icons.shield_outlined,
                "Chính sách bảo vệ dữ liệu cá nhân",
                () {},
              ),
              Divider(color: Colors.black.withValues(alpha: 0.1), height: 0.8),
              _buildOptionItem(
                Icons.language_outlined,
                "Đổi ngôn ngữ",
                isLast: true,
                () {},
              ),
              Divider(color: Colors.black.withValues(alpha: 0.1), height: 0.8),
              _buildOptionItem(Icons.support_agent_outlined, "Hỗ trợ", () {}),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildOptionItem(
    IconData firstIcon,
    String text,
    onTap, {
    bool isFirst = false,
    bool isLast = false,
  }) {
    return InkWell(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(isFirst ? 10 : 0),
        topRight: Radius.circular(isFirst ? 10 : 0),
        bottomLeft: Radius.circular(isLast ? 10 : 0),
        bottomRight: Radius.circular(isLast ? 10 : 0),
      ),
      onTap: onTap,
      child: Container(
        height: 80,
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Icon(firstIcon, size: 30),
            SizedBox(width: 10),
            Expanded(child: Text(text, style: TextStyle(fontSize: 16))),
            const Icon(Icons.chevron_right_outlined, size: 30),
          ],
        ),
      ),
    );
  }

  Widget _buildLogoutButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ElevatedButton(
        onPressed: () {
          context.read<AuthCubit>().logout();
          Navigator.pushReplacementNamed(context, "/login");
        },
        style: ElevatedButton.styleFrom(
          minimumSize: const Size(double.infinity, 56),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadiusGeometry.all(Radius.circular(10)),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.logout_rounded),
            const SizedBox(width: 10),
            Text(
              "Đăng xuất",
              style: TextStyle(fontSize: 18, color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
