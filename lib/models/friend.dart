import 'package:cloud_firestore/cloud_firestore.dart';

class Friend {
  final String id;
  final String name;
  final String avatarURL;

  const Friend({required this.id, required this.name, required this.avatarURL});

  factory Friend.fromDoc(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return Friend(
      id: data['idUser'],
      name: data['name'],
      avatarURL: data['avatarURL'],
    );
  }
}
