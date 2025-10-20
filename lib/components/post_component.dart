import 'package:appchat_flutter/components/user_info.dart';
import 'package:appchat_flutter/models/post.dart';
import 'package:flutter/material.dart';

class PostComponent extends StatelessWidget {
  const PostComponent({super.key, required this.post});

  final Post post;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      margin: EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          width: 1,
          style: BorderStyle.solid,
          color: Color(0xFFE4E4E7),
        ),
      ),
      child: Column(
        children: [
          UserInfo(
            id: post.friend.id,
            avatarURL: post.friend.avatarURL,
            name: post.friend.name,
            time: post.createdAt.toDate().toString(),
          ),
          SizedBox(height: 10),
          Text(post.content, textAlign: TextAlign.justify),
        ],
      ),
    );
  }
}
