import 'package:appchat_flutter/models/chat.dart';
import 'package:appchat_flutter/models/message.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChatDetailViewModel extends ChangeNotifier {
  Stream<List<Message>>? messages;
  final currentUserId = FirebaseAuth.instance.currentUser!.uid;
  final TextEditingController textEditingController = TextEditingController();
  final ScrollController scrollController = ScrollController();
  late Chat chat;
  bool hasText = false;
  bool hasScroll = false;

  getMessages() {
    messages = FirebaseFirestore.instance
        .collection('chats')
        .doc(chat.idChat)
        .collection('messages')
        .snapshots()
        .asyncMap((snapshotList) {
          List<Message> newMessages = [];
          for (final snapshot in snapshotList.docs) {
            final data = Message.fromMap(snapshot.data());
            newMessages.add(data);
          }
          newMessages.sort((a, b) => a.createdAt.compareTo(b.createdAt));
          return newMessages;
        });
    notifyListeners();
  }

  sendMessage(message, idChat) async {
    final currentUserId = FirebaseAuth.instance.currentUser!.uid;
    final firestore = FirebaseFirestore.instance;

    final docSnapshot = await firestore.collection('chats').doc(idChat).get();
    bool isRead = false;
    if (docSnapshot.exists) {
      final data = docSnapshot.data();
      if (data!['currentIds'].length == 2) {
        isRead = true;
        firestore.collection('chats').doc(idChat).update({
          'count': 0,
          'idLastUser': currentUserId,
          'lastMessage': message,
        });
      } else {
        firestore.collection('chats').doc(idChat).update({
          'count': data['count'] + 1,
          'idLastUser': currentUserId,
          'lastMessage': message,
        });
      }
    }
    firestore.collection('chats').doc(idChat).collection('messages').add({
      'createdAt': Timestamp.now(),
      'isRead': isRead,
      'senderId': currentUserId,
      'text': message,
    });
  }

  updateCurrent() {
    FirebaseFirestore.instance.collection('chats').doc(chat.idChat).update({
      'currentIds': FieldValue.arrayRemove([currentUserId]),
    });
  }
}
