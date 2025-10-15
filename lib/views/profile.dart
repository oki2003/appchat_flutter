import 'package:appchat_flutter/components/post_component.dart';
import 'package:appchat_flutter/models/post.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Profile extends StatelessWidget {
  Profile({super.key});

  final Map<String, dynamic> data = {
    "id": 1,
    "avatarURL": "https://avatar.iran.liara.run/public/35",
    "name": "Đăng Khoa",
    "countPost": 127,
    "countFollower": 1200,
    "countFollowing": 384,
  };

  final List posts = [
    {
      "id": "1",
      "avatarURL": "https://avatar.iran.liara.run/public/35",
      "name": "Đăng Khoa",
      "createdAt": Timestamp.now(),
      "content":
          "Just launched my new mobile app! 🚀 Super excited to share this with everyone. Built with love and lots of coffee ☕",
    },
    {
      "id": "2",
      "avatarURL": "https://avatar.iran.liara.run/public/35",
      "name": "Đăng Khoa",
      "createdAt": Timestamp.now(),
      "content":
          "Beautiful sunset at the beach today 🌅 Nature never fails to amaze me. #photography #sunset",
    },
    {
      "id": "3",
      "avatarURL": "https://avatar.iran.liara.run/public/35",
      "name": "Đăng Khoa",
      "createdAt": Timestamp.now(),
      "content":
          "Pro tip: Always backup your code! Learned this the hard way today 😅 #coding #developerlife",
    },
    {
      "id": "4",
      "avatarURL": "https://avatar.iran.liara.run/public/35",
      "name": "Đăng Khoa",
      "createdAt": Timestamp.now(),
      "content":
          "Pro tip: Always backup your code! Learned this the hard way today 😅 #coding #developerlife",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        SizedBox(height: 25),
        Column(
          children: [
            Image.network(data["avatarURL"], width: 100),
            Text(
              data["name"],
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
                        data["countPost"].toString(),
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
                        data["countFollower"].toString(),
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text("Người theo dõi", style: TextStyle(fontSize: 14)),
                    ],
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Column(
                    children: [
                      Text(
                        data["countFollowing"].toString(),
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text("Đang theo dõi", style: TextStyle(fontSize: 14)),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            Container(height: 0.5, width: double.infinity, color: Colors.grey),
            Align(
              alignment: Alignment.centerLeft,
              child: Text("Bài đăng của bạn", style: TextStyle(height: 5)),
            ),
          ],
        ),
        ...posts.map((post) {
          final data = Post.fromMap(post);
          return PostComponent(post: data);
        }),
      ],
    );
  }
}
