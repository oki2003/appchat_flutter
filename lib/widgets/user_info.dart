import 'package:flutter/material.dart';

class UserInfoComponent extends StatelessWidget {
  const UserInfoComponent({
    super.key,
    required this.id,
    required this.avatarURL,
    required this.name,
    required this.time,
  });

  final String id;
  final String avatarURL;
  final String name;
  final String time;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Stack(
          children: [
            // Hiển thị ảnh avatar
            Image.asset(avatarURL, width: 40),
            Positioned(
              bottom: -2,
              right: 0,
              child: Container(
                width: 15,
                height: 15,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.green,
                  border: Border.all(color: Colors.white, width: 2),
                ),
              ),
            ),
          ],
        ),

        // Khoảng cách giữa avatar và tên
        SizedBox(width: 20),

        // Hiển thị tên và thời gian
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              name,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
            ),
            Text(time, style: TextStyle(fontSize: 12, color: Colors.black54)),
          ],
        ),
      ],
    );
  }
}
