import 'package:appchat_flutter/models/chat.dart';
import 'package:appchat_flutter/utils/utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChatListViewModel extends ChangeNotifier {
  Stream<List<Chat>>? chats;
  final currentUserId = FirebaseAuth.instance.currentUser!.uid;

  Future<void> initStreamListChat() async {
    QuerySnapshot friendsSnapshot = await FirebaseFirestore.instance
        .collection('friendships')
        .doc(currentUserId)
        .collection('friends')
        .get();

    if (friendsSnapshot.docs.isNotEmpty) {
      final chatIds = friendsSnapshot.docs
          .map((doc) => Utils().combinedUid(currentUserId, doc.id))
          .toList();

      chats = FirebaseFirestore.instance
          .collection('chats')
          .where(FieldPath.documentId, whereIn: chatIds)
          .snapshots()
          .asyncMap((snapshot) async {
            List<Chat> listChat = [];
            for (int i = 0; i < snapshot.docs.length; i++) {
              var data = snapshot.docs[i].data();
              listChat.add(Chat.fromMap(data));
            }
            return listChat;
          });
    }
    notifyListeners();
  }

  updateCurrentAndCount(chat) {
    int count = 0;
    if (chat.idLastUser == currentUserId) count = chat.count;
    FirebaseFirestore.instance.collection('chats').doc(chat.idChat).update({
      'count': count,
      'currentIds': FieldValue.arrayUnion([currentUserId]),
    });
  }
}
