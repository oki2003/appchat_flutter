import 'package:appchat_flutter/features//chat/chat_screen.dart';
import 'package:appchat_flutter/features/auth/cubit/auth_cubit.dart';
import 'package:appchat_flutter/features/chat/cubit/chat_cubit.dart';
import 'package:appchat_flutter/features/movies/cubit/movies_cubit.dart';
import 'package:appchat_flutter/features/movies/movies_screen.dart';
import 'package:appchat_flutter/features/profile/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppViewModel extends ChangeNotifier {
  Map<String, dynamic> categories = {
    'icons': [Icons.chat_outlined, Icons.movie_outlined, Icons.person_outlined],
    'widget': [
      BlocProvider(
        create: (context) =>
            ChatCubit()
              ..fetchChats(context.read<AuthCubit>().state.appUser!.id),
        child: ChatScreen(),
      ),
      BlocProvider(
        create: (context) => MoviesCubit()..fetchMovies(),
        child: MoviesScreen(),
      ),
      ProfileScreen(),
    ],
    'label': ["Trò chuyện", "Giải trí", "Tôi"],
  };
  int currentIndex = 0;

  loadTab(index) {
    currentIndex = index;
    notifyListeners();
  }
}
