import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage {
  static SharedPreferences? pref;

  static Future<SharedPreferences> initLocalStorage() async {
    pref ??= await SharedPreferences.getInstance();
    return pref!;
  }
}
