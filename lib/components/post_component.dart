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
          Row(
            children: [
              Image.network(
                post.avatarURL,
                width: 40,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: Colors.grey,
                    ),
                    width: 40,
                    height: 40,
                    child: Icon(Icons.person, size: 24),
                  );
                },
              ),
              SizedBox(width: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    post.name,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                  ),
                  Text(
                    post.createdAt.toDate().toString(),
                    style: TextStyle(fontSize: 12, color: Colors.black54),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 10),
          Text(post.content, textAlign: TextAlign.justify),
        ],
      ),
    );
  }
}
