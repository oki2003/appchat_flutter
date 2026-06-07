import 'package:appchat_flutter/features/auth/cubit/auth_cubit.dart';
import 'package:appchat_flutter/models/app_user.dart';
import 'package:appchat_flutter/theme/brand_theme.dart';
import 'package:appchat_flutter/widgets/user_presence.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key, required this.onChangedMode});
  final VoidCallback onChangedMode;

  @override
  Widget build(BuildContext context) {
    final AppUser? curUser = context.read<AuthCubit>().state.appUser;
    final double layoutHeight = (MediaQuery.of(context).size.height / 3) / 3;
    final BrandAppTheme brandAppTheme = BrandAppTheme(context: context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        _buildHeader(curUser, layoutHeight, brandAppTheme),
        _buildOption(brandAppTheme),
        _buildLogoutButton(context),
      ],
    );
  }

  Widget _buildHeader(
    AppUser? curUser,
    double layoutHeight,
    BrandAppTheme brandAppTheme,
  ) {
    return SizedBox(
      height: layoutHeight * 2,
      child: Stack(
        children: [
          Container(
            height: layoutHeight,
            color: brandAppTheme.primaryBrandColor,
          ),
          Align(
            alignment: Alignment.center,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 0),
              child: Container(
                margin: const EdgeInsets.only(bottom: 12),
                decoration: BoxDecoration(
                  color: brandAppTheme.containerColor,
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
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 20,
                                  color: brandAppTheme.textColor,
                                  letterSpacing: -0.2,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                curUser?.userName == null
                                    ? ""
                                    : "@${curUser!.userName}",
                                style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 17,
                                  color: brandAppTheme.noteBrandColor,
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

  Widget _buildOption(BrandAppTheme brandAppTheme) {
    final TextStyle textStyle = TextStyle(
      fontSize: 16,
      color: brandAppTheme.textColor,
    );
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SizedBox(
        width: double.infinity,
        child: Material(
          color: brandAppTheme.containerColor,
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
                Text("Điều khoản sử dụng", style: textStyle),
                isFirst: true,
                () {},
              ),
              Divider(color: Colors.black.withValues(alpha: 0.1), height: 0.8),
              _buildOptionItem(
                Icons.shield_outlined,
                Text("Chính sách bảo vệ dữ liệu cá nhân", style: textStyle),
                () {},
              ),
              Divider(color: Colors.black.withValues(alpha: 0.1), height: 0.8),
              _buildOptionItem(
                Icons.language_outlined,
                Text("Đổi ngôn ngữ", style: textStyle),
                isLast: true,
                () {},
              ),
              Divider(color: Colors.black.withValues(alpha: 0.1), height: 0.8),
              _buildOptionItem(
                Icons.support_agent_outlined,
                Text("Hỗ trợ", style: textStyle),
                () {},
              ),
              Divider(color: Colors.black.withValues(alpha: 0.1), height: 0.8),
              _buildOptionItem(
                Icons.dark_mode_outlined,
                Text("Chế độ tối", style: textStyle),
                isLast: true,
                secondIcon: Icons.toggle_off_rounded,
                () {
                  debugPrint("hehehe");
                  onChangedMode();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildOptionItem(
    IconData firstIcon,
    Text text,
    onTap, {
    bool isFirst = false,
    bool isLast = false,
    IconData? secondIcon,
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
            Expanded(child: text),
            Icon(secondIcon ?? Icons.chevron_right_outlined, size: 30),
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
            const Icon(Icons.logout_rounded, color: Colors.white),
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
