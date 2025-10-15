import 'package:appchat_flutter/components/post_component.dart';
import 'package:appchat_flutter/controller/home_controller.dart';
import 'package:appchat_flutter/models/post.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<StatefulWidget> createState() {
    return _Home();
  }
}

class _Home extends State<Home> {
  late Future<List<Post>> posts;
  final HomeController homeController = HomeController();

  @override
  void initState() {
    super.initState();
    posts = homeController.getPosts(true);
  }

  Future<void> handleRefresh() async {
    final Future<List<Post>> fetchPosts = homeController.getPosts(false);
    setState(() {
      posts = fetchPosts;
    });
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: handleRefresh,
      child: FutureBuilder(
        future: posts,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data!.isEmpty) {
              return Center(child: Text("Không có bài viết nào hết :(("));
            } else {
              return ListView(
                children: [
                  SizedBox(height: 20),
                  ...snapshot.data!.map((post) {
                    return PostComponent(post: post);
                  }),
                ],
              );
            }
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
