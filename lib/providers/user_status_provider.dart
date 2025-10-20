import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Tạo provider để theo dõi dữ liệu từ Realtime Database
final userStatusProvider = StreamProvider<List<Map<dynamic, dynamic>>>((ref) {
  final database = FirebaseDatabase.instance.ref().child('users');
  return database.onValue.map((event) {
    final data = event.snapshot.value as Map<dynamic, dynamic>?;
    if (data != null) {
      return data.entries.map((entry) {
        return {
          'idUser': entry.key,
          'isOnline': entry.value['isOnline'] ?? false,
        };
      }).toList();
    }
    return [];
  });
});
