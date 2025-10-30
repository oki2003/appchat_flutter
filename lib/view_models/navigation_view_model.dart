import 'package:appchat_flutter/views/chat_list_screen.dart';
import 'package:flutter/material.dart';

class NavigationViewModel extends ChangeNotifier {
  Map<String, dynamic> categories = {
    'icons': [
      // Icons.home_outlined,
      // Icons.chat_outlined,
      Icons.person_outlined,
    ],
    'widget': [
      // HomeScreen(),
      ChatListScreen(),
      // ProfileScreen(),
    ],
    'label': [
      // 'Trang chủ',
      'Trò chuyện',
      // 'Tôi'
    ],
  };
  int currentIndex = 0;

  loadTab(index) {
    currentIndex = index;
    notifyListeners();
  }
}
