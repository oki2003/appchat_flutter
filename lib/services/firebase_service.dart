import 'package:appchat_flutter/constants/api.dart';
import 'package:appchat_flutter/core/network/api_client.dart';

class FirebaseService {
  Future<void> upsertFCMToken(String fcmToken) async {
    try {
      await ApiClient.dio.post(Api.upsertFCMToken(fcmToken));
    } catch (e) {
      throw e.toString();
    }
  }

  Future<void> deleteFCMToken(String fcmToken) async {
    try {
      await ApiClient.dio.delete(Api.deleteFCMToken(fcmToken));
    } catch (e) {
      throw e.toString();
    }
  }
}
