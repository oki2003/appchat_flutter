import 'package:appchat_flutter/models/message.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class MessageController {
  Stream<List<Message>> getMessages(idChat) {
    final firestore = FirebaseFirestore.instance;

    return firestore
        .collection('chats')
        .doc(idChat)
        .collection('messages')
        .snapshots()
        .asyncMap((snapshotList) {
          List<Message> listMessages = [];
          for (final snapshot in snapshotList.docs) {
            final data = Message.fromMap(snapshot.data());
            listMessages.add(data);
          }
          listMessages.sort((a, b) => a.createdAt.compareTo(b.createdAt));
          return listMessages;
        });
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
}
