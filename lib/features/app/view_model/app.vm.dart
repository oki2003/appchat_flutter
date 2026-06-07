import 'package:appchat_flutter/features//chat/chat_screen.dart';
import 'package:appchat_flutter/features/chat/cubit/chat_cubit.dart';
import 'package:appchat_flutter/features/movie/cubit/movie_cubit.dart';
import 'package:appchat_flutter/features/movie/movie_screen.dart';
import 'package:appchat_flutter/features/profile/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppViewModel {
  AppViewModel({required this.onChangedMode});
  final VoidCallback onChangedMode;

  Map<String, dynamic> get categories => {
    'icons': [
      Icons.chat_bubble_outline,
      Icons.explore_outlined,
      Icons.account_circle,
    ],
    'widget': [
      BlocProvider(
        create: (context) => ChatCubit()..fetchChats(),
        child: ChatScreen(),
      ),
      BlocProvider(
        create: (context) => MovieCubit()..fetchMovies(),
        child: MovieScreen(),
      ),
      ProfileScreen(onChangedMode: onChangedMode),
    ],
    'label': ["Trò chuyện", "Khám phá", "Tôi"],
  };
  ValueNotifier<int> currentIndex = ValueNotifier<int>(0);

  loadTab(int index) {
    currentIndex.value = index;
  }
}
