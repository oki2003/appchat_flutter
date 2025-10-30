import 'package:appchat_flutter/view_models/home_view_model.dart';
import 'package:appchat_flutter/widgets/post_item.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _HomeScreen();
  }
}

class _HomeScreen extends State<HomeScreen> {
  late final HomeViewModel homeViewModel;

  @override
  void initState() {
    super.initState();
    homeViewModel = HomeViewModel();
    homeViewModel.getPosts();
    homeViewModel.scrollController.addListener(() {
      if ((homeViewModel.scrollController.position.pixels ==
              homeViewModel.scrollController.position.maxScrollExtent) &&
          homeViewModel.hasMore) {
        print("load them");
        homeViewModel.loadMore();
      }
    });
  }

  @override
  void dispose() {
    homeViewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: homeViewModel,
      builder: (context, child) {
        if (homeViewModel.isLoading) {
          return Center(child: CircularProgressIndicator());
        }
        if (homeViewModel.posts.isEmpty) {
          return Center(child: Text('Chưa có bài đăng nào cả :('));
        }
        return RefreshIndicator(
          onRefresh: () async {
            homeViewModel.handleRefresh();
          },
          child: ListView.builder(
            controller: homeViewModel.scrollController,
            itemCount: homeViewModel.posts.length,
            itemBuilder: (context, index) {
              return PostItem(post: homeViewModel.posts[index]);
            },
          ),
        );
      },
    );
  }
}
