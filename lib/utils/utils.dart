import 'package:cloud_firestore/cloud_firestore.dart';

class Utils {
  combinedUid(String uid_1, String uid_2) {
    if (uid_1.compareTo(uid_2) < 0) {
      return "${uid_1}_$uid_2";
    } else {
      return "${uid_2}_$uid_1";
    }
  }

  formatTime(Timestamp timestamp) {
    DateTime dateTime = timestamp.toDate();
    String hour = dateTime.hour.toString().padLeft(2, '0');
    String minute = dateTime.minute.toString().padLeft(2, '0');
    return '$hour:$minute';
  }
}
