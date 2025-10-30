import 'package:appchat_flutter/models/post.dart';
import 'package:appchat_flutter/widgets/user_info.dart';
import 'package:flutter/material.dart';

class PostItem extends StatelessWidget {
  const PostItem({super.key, required this.post});

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
            id: post.authorId,
            avatarURL: post.avatarURL,
            name: post.authorName,
            time: post.createdAt.toDate().toString(),
          ),
          SizedBox(height: 10),
          Text(
            post.content.replaceAll(r'\n', '\n'),
            textAlign: TextAlign.justify,
          ),
        ],
      ),
    );
  }
}
