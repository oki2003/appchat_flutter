import 'package:appchat_flutter/view_models/profile_view_model.dart';
import 'package:appchat_flutter/widgets/post_item.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _ProfileScreen();
  }
}

class _ProfileScreen extends State<ProfileScreen> {
  late final ProfileViewModel profileViewModel;

  @override
  void initState() {
    super.initState();
    profileViewModel = ProfileViewModel();
    profileViewModel.getInfomation();
    profileViewModel.scrollController.addListener(() {
      if (profileViewModel.scrollController.position.pixels ==
          profileViewModel.scrollController.position.maxScrollExtent) {
        profileViewModel.loadMore();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: profileViewModel,
      builder: (context, child) {
        if (profileViewModel.user.isEmpty) {
          return Center(child: CircularProgressIndicator());
        }
        return ListView.builder(
          controller: profileViewModel.scrollController,
          itemCount: profileViewModel.posts.length + 1,
          itemBuilder: (context, index) {
            if (index == 0) {
              return Column(
                children: [
                  SizedBox(height: 25),
                  Image.asset(
                    profileViewModel.user['avatarURL'].toString(),
                    width: 100,
                  ),
                  Text(
                    profileViewModel.user['name'].toString(),
                    style: TextStyle(
                      height: 3,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Column(
                          children: [
                            Text(
                              profileViewModel.totalPosts.toString(),
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text("Bài đăng", style: TextStyle(fontSize: 14)),
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Column(
                          children: [
                            Text(
                              profileViewModel.totalFriends.toString(),
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text("Bạn bè", style: TextStyle(fontSize: 14)),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Container(
                    height: 0.5,
                    width: double.infinity,
                    color: Colors.grey,
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Bài đăng của bạn",
                      style: TextStyle(height: 5),
                    ),
                  ),
                  profileViewModel.posts.isEmpty
                      ? Align(
                          alignment: Alignment.center,
                          child: Text(
                            "Chưa có bài đăng nào cả :((",
                            style: TextStyle(height: 5),
                          ),
                        )
                      : Text(""),
                ],
              );
            } else {
              return PostItem(post: profileViewModel.posts[index - 1]);
            }
          },
        );
      },
    );
  }
}
