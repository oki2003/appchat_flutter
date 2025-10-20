import 'package:appchat_flutter/models/friend.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserController {
  Future<Friend> getInfoFriend(String uid) async {
    final firestore = FirebaseFirestore.instance;
    try {
      DocumentSnapshot documentSnapshot;
      documentSnapshot = await firestore.collection('users').doc(uid).get();
      return Friend.fromDoc(documentSnapshot);
    } catch (e) {
      print('Lỗi khi lấy thông tin người dùng: $e');
      return Friend(
        id: "Unknow",
        name: "Unknow",
        avatarURL: "https://avatar.iran.liara.run/public/35",
      );
    }
  }
}
