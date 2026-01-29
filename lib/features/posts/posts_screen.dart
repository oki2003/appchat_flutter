// import 'package:appchat_flutter/repositories/post_repository.dart';
// import 'package:appchat_flutter/services/post_service.dart';
// import 'package:appchat_flutter/view_models/home_view_model.dart';
// import 'package:appchat_flutter/widgets/post_item.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
//
// class HomeScreen extends StatefulWidget {
//   const HomeScreen({super.key});
//
//   @override
//   State<StatefulWidget> createState() {
//     return _HomeScreen();
//   }
// }
//
// class _HomeScreen extends State<HomeScreen> {
//   late final HomeViewModel homeViewModel;
//
//   @override
//   void initState() {
//     super.initState();
//     PostService postService = PostService(FirebaseFirestore.instance);
//     PostRepository postRepository = PostRepository(postService);
//     homeViewModel = HomeViewModel(
//       postRepository,
//       FirebaseAuth.instance.currentUser!.uid,
//     );
//     homeViewModel.getPosts();
//     homeViewModel.initScroll();
//   }
//
//   @override
//   void dispose() {
//     homeViewModel.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return ListenableBuilder(
//       listenable: homeViewModel,
//       builder: (context, child) {
//         if (homeViewModel.isLoading) {
//           return Center(child: CircularProgressIndicator());
//         }
//         if (homeViewModel.posts.isEmpty) {
//           return Center(child: Text('Chưa có bài đăng nào cả :('));
//         }
//         return RefreshIndicator(
//           onRefresh: () async {
//             homeViewModel.handleRefresh();
//           },
//           child: ListView.builder(
//             controller: homeViewModel.scrollController,
//             itemCount: homeViewModel.posts.length,
//             itemBuilder: (context, index) {
//               return PostItem(post: homeViewModel.posts[index]);
//             },
//           ),
//         );
//       },
//     );
//   }
// }
