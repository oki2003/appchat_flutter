import 'package:appchat_flutter/constants/api.dart';
import 'package:flutter/material.dart';

class UserPresence extends StatelessWidget {
  const UserPresence({
    super.key,
    required this.avatarURL,
    this.status = false,
    this.size = 40,
  });

  final String avatarURL;
  final bool status;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Hiển thị ảnh avatar
        Container(
          height: size,
          width: size,
          clipBehavior: Clip.hardEdge,
          decoration: BoxDecoration(shape: BoxShape.circle),
          child: Image.network(
            "${Api.baseURL}$avatarURL",
            height: double.infinity,
            width: double.infinity,
          ),
        ),
        status
            ? Positioned(
                bottom: size * 0.01,
                right: size * 0.1,
                child: Container(
                  width: size * 0.2,
                  height: size * 0.2,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.green,
                    border: Border.all(color: Colors.white, width: 2),
                  ),
                ),
              )
            : const SizedBox.shrink(),
      ],
    );
  }
}
