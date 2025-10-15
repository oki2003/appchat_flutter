import 'package:appchat_flutter/components/navbar_custom.dart';
import 'package:appchat_flutter/views/home.dart';
import 'package:appchat_flutter/views/chat_list.dart';
import 'package:appchat_flutter/views/profile.dart';
import 'package:flutter/material.dart';

class Navigation extends StatelessWidget {
  const Navigation({super.key});

  @override
  Widget build(BuildContext context) {
    return NavbarCustom(
      data: [
        {"icon": Icons.home_outlined, "page": Home(), "label": "Trang chủ"},
        {
          "icon": Icons.chat_outlined,
          "page": ChatList(),
          "label": "Trò chuyện",
        },
        {"icon": Icons.person_outlined, "page": Profile(), "label": "Tôi"},
      ],
    );
  }
}
