import 'package:appchat_flutter/view_models/navigation_view_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Navigation extends StatefulWidget {
  const Navigation({super.key});

  @override
  State<StatefulWidget> createState() {
    return _Navigation();
  }
}

class _Navigation extends State<Navigation> {
  late NavigationViewModel navigationViewModel;

  @override
  void initState() {
    super.initState();
    navigationViewModel = NavigationViewModel();
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: navigationViewModel,
      builder: (context, child) {
        if (FirebaseAuth.instance.currentUser == null) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            Navigator.pushReplacementNamed(context, '/login');
          });
        }
        return Scaffold(
          appBar: AppBar(
            toolbarHeight: 70,
            title: Text(
              navigationViewModel.categories['label'][navigationViewModel
                  .currentIndex],
              style: Theme.of(context).textTheme.titleMedium,
            ),
            backgroundColor: Colors.white,
            flexibleSpace: Container(
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(color: Color(0xFFE4E4E7), width: 1),
                ),
              ),
            ),
            automaticallyImplyLeading: false,
          ),
          body: Padding(
            padding: EdgeInsets.only(right: 30, left: 30),
            child: ScrollConfiguration(
              behavior: ScrollConfiguration.of(
                context,
              ).copyWith(scrollbars: false),
              child: IndexedStack(
                index: navigationViewModel.currentIndex,
                children: navigationViewModel.categories['widget']
                    .cast<Widget>(),
              ),
            ),
          ),
          bottomNavigationBar: Container(
            height: 70,
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border(
                top: BorderSide(color: Color(0xFFE4E4E7), width: 1),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: List.generate(
                navigationViewModel.categories['icons'].length,
                (index) {
                  return TextButton(
                    onPressed: () {
                      navigationViewModel.loadTab(index);
                    },
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.all(8),
                      foregroundColor: navigationViewModel.currentIndex == index
                          ? Color(0xFF7851DE)
                          : Colors.grey,
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          navigationViewModel.categories['icons'][index],
                          size: 24,
                        ),
                        SizedBox(height: 4),
                        Text(navigationViewModel.categories['label'][index]),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        );
      },
    );
  }
}
