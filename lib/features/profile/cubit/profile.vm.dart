import 'dart:convert';

import 'package:appchat_flutter/models/app_user.dart';
import 'package:appchat_flutter/services/local_storage.dart';
import 'package:stacked/stacked.dart';

class ProfileViewModel extends BaseViewModel {
  final AppUser currentUser = AppUser.fromJSON(
    jsonDecode(LocalStorage.pref!.getString("currentUser")!),
  );

  int totalFriends = 0;
  int totalPosts = 0;

  void logout() {
    final token = LocalStorage.pref!.getString("token");
    if (token != null) {
      LocalStorage.pref!.remove("token");
    }
  }
}
