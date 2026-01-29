import 'package:appchat_flutter/features/profile/cubit/profile.vm.dart';
import 'package:appchat_flutter/features/profile/widgets/profile_item_bar.dart';
import 'package:appchat_flutter/widgets/user_presence.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ProfileViewModel>.nonReactive(
      viewModelBuilder: () => ProfileViewModel(),
      builder: (context, viewModel, child) => SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 30),
            UserPresence(
              avatarURL: viewModel.currentUser.avatarURL.toString(),
              size: 120,
            ),
            Text(
              viewModel.currentUser.name,
              style: TextStyle(fontSize: 27, fontWeight: FontWeight.bold),
            ),
            Text(
              viewModel.currentUser.email,
              style: TextStyle(
                fontSize: 17,
                color: Colors.black.withValues(alpha: 0.5),
              ),
            ),
            Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Column(
                    children: [
                      Text(
                        viewModel.totalPosts.toString(),
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Text("Bài đăng", style: TextStyle(fontSize: 14)),
                    ],
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Column(
                    children: [
                      Text(
                        viewModel.totalFriends.toString(),
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Text("Bạn bè", style: TextStyle(fontSize: 14)),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            ProfileItemBar(
              icon: const Icon(Icons.person_outline_rounded),
              text: "Chỉnh sửa thông tin",
              onPressed: () {},
            ),
            ProfileItemBar(
              icon: const Icon(Icons.people_outline),
              text: "Bạn bè",
              onPressed: () {},
            ),
            ProfileItemBar(
              icon: const Icon(Icons.security_outlined),
              text: "Chính sách bảo mật",
              onPressed: () {},
            ),
            ProfileItemBar(
              icon: const Icon(Icons.help_outline_rounded),
              text: "Hỗ trợ",
              onPressed: () {},
            ),
            ProfileItemBar(
              icon: const Icon(Icons.logout_outlined),
              text: "Đăng xuất",
              onPressed: () {
                viewModel.logout();
                Navigator.pushReplacementNamed(context, "/login");
              },
            ),
          ],
        ),
      ),
    );
  }
}
