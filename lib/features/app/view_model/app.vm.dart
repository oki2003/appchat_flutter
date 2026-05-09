import 'package:appchat_flutter/features//chat/chat_screen.dart';
import 'package:appchat_flutter/features/chat/cubit/chat_cubit.dart';
import 'package:appchat_flutter/features/movie/cubit/movie_cubit.dart';
import 'package:appchat_flutter/features/movie/movie_screen.dart';
import 'package:appchat_flutter/features/profile/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppViewModel {
  Map<String, dynamic> categories = {
    'icons': [Icons.chat_outlined, Icons.movie_outlined, Icons.person_outlined],
    'widget': [
      BlocProvider(
        create: (context) => ChatCubit()..fetchChats(),
        child: ChatScreen(),
      ),
      BlocProvider(
        create: (context) => MovieCubit()..fetchMovies(),
        child: MovieScreen(),
      ),
      ProfileScreen(),
    ],
    'label': ["Trò chuyện", "Giải trí", "Tôi"],
  };
  ValueNotifier<int> currentIndex = ValueNotifier<int>(0);

  loadTab(int index) {
    currentIndex.value = index;
  }
}
