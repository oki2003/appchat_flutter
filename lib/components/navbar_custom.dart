import 'package:appchat_flutter/controller/authentication_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class NavbarCustom extends StatefulWidget {
  const NavbarCustom({super.key, required this.data});

  final List<Map<String, dynamic>> data;

  @override
  State<StatefulWidget> createState() {
    return _NavbarCustom();
  }
}

class _NavbarCustom extends State<NavbarCustom> {
  int currentIndex = 0;
  final Authentication authController = Authentication();

  @override
  void initState() {
    super.initState();
    if (authController.auth() == false) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Navigator.pushReplacementNamed(context, '/login');
      });
    } else {
      // updateUserStatus();
    }
  }

  void updateUserStatus() {
    final currentUserId = FirebaseAuth.instance.currentUser!.uid;
    try {
      FirebaseDatabase.instance
          .ref()
          .child('users')
          .child(currentUserId)
          .update({'isOnline': true});
    } catch (e) {
      print("Lỗi khi cập nhật trạng thái: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 70,
        title: Text(
          widget.data[currentIndex]["label"],
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
          behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
          child: widget.data[currentIndex]["page"],
        ),
      ),
      bottomNavigationBar: Container(
        height: 70,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(top: BorderSide(color: Color(0xFFE4E4E7), width: 1)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            ...widget.data.asMap().entries.map((entry) {
              return TextButton(
                onPressed: () {
                  if (currentIndex != entry.key) {
                    setState(() {
                      currentIndex = entry.key;
                    });
                  }
                },
                style: TextButton.styleFrom(
                  padding: EdgeInsets.all(8),
                  foregroundColor: currentIndex == entry.key
                      ? Color(0xFF7851DE)
                      : Colors.grey,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(entry.value["icon"], size: 24),
                    SizedBox(height: 4),
                    Text(entry.value["label"]),
                  ],
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}
