import 'package:appchat_flutter/controller/user_controller.dart';
import 'package:appchat_flutter/models/chat.dart';
import 'package:appchat_flutter/utils/utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ChatController {
  Future<Map<String, dynamic>> initInformation() async {
    final currentUserId = FirebaseAuth.instance.currentUser!.uid;
    final firestore = FirebaseFirestore.instance;
    Map<String, dynamic> results = {};
    try {
      //get list of friend's id
      QuerySnapshot friendsSnapshot;
      friendsSnapshot = await firestore
          .collection('friendships')
          .doc(currentUserId)
          .collection('friends')
          .get(GetOptions(source: Source.cache));

      if (friendsSnapshot.docs.isEmpty) {
        friendsSnapshot = await firestore
            .collection('friendships')
            .doc(currentUserId)
            .collection('friends')
            .get(GetOptions(source: Source.server));
      }

      final friendIds = friendsSnapshot.docs.map((doc) => doc.id).toList();
      if (friendIds.isEmpty) {
        return {};
      }

      final chatIds = friendIds
          .map((friendId) => Utils().combinedUid(currentUserId, friendId))
          .toList();
      results = {"friendIds": friendIds, "chatIds": chatIds};
    } catch (e) {
      print('Lỗi khởi tạo thông tin: $e');
    }
    return results;
  }

  Stream<List<Chat>> listenChatList(friendIds, chatIds) {
    final firestore = FirebaseFirestore.instance;
    final UserController userController = UserController();
    return firestore
        .collection('chats')
        .where(FieldPath.documentId, whereIn: chatIds)
        .snapshots()
        .asyncMap((snapshot) async {
          List<Chat> listChat = [];
          for (int i = 0; i < snapshot.docs.length; i++) {
            var data = snapshot.docs[i].data();
            final friend = await userController.getInfoFriend(friendIds[i]);
            listChat.add(Chat.fromMap(data, friend));
          }
          return listChat;
        });
  }

  updateCurrentAndCount(idChat, count) {
    final currentUserId = FirebaseAuth.instance.currentUser!.uid;
    FirebaseFirestore.instance.collection('chats').doc(idChat).update({
      'count': count,
      'currentIds': FieldValue.arrayUnion([currentUserId]),
    });
  }

  updateCurrent(idChat) {
    final currentUserId = FirebaseAuth.instance.currentUser!.uid;
    FirebaseFirestore.instance.collection('chats').doc(idChat).update({
      'currentIds': FieldValue.arrayRemove([currentUserId]),
    });
  }
}
