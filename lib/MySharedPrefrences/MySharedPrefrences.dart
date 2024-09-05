import 'package:shared_preferences/shared_preferences.dart';

class MySharedPrefrences {
  static late SharedPreferences sharedPreferences;

//! Here The Initialize of cache .
  init() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  String? getDataString({required String key}) {
    return sharedPreferences.getString(key);
  }

  void logSharedPreferences() async {
    Set<String> keys = sharedPreferences.getKeys();
    print("***********MyShared*************");
    for (String key in keys) {
      print('$key: ${sharedPreferences.get(key)}');
    }
    print("**********MySharedEnds***********");
  }

  Future<bool> saveData({required String key, required dynamic value}) async {
    if (value is bool) {
      return await sharedPreferences.setBool(key, value);
    }

    if (value is String) {
      return await sharedPreferences.setString(key, value);
    }
    if (value is int) {
      return await sharedPreferences.setInt(key, value);
    } else {
      return await sharedPreferences.setDouble(key, value);
    }
  }

  dynamic getData({required String key}) {
    return sharedPreferences.get(key);
  }

  Future<bool> removeData({required String key}) async {
    return await sharedPreferences.remove(key);
  }

  Future<bool> clearData({required String key}) async {
    return sharedPreferences.clear();
  }
}
