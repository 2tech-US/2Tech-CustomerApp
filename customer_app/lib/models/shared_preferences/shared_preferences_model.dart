import 'package:shared_preferences/shared_preferences.dart';

class SharedPref {
  static save(String key, dynamic value) async {
    final prefs = await SharedPreferences.getInstance();
    switch (value.runtimeType) {
      case double:
        prefs.setDouble(key, value);
        break;
      case int:
        prefs.setInt(key, value);
        break;
      case bool:
        prefs.setBool(key, value);
        break;
      case List<String>:
        prefs.setStringList(key, value);
        break;
      default:
        prefs.setString(key, value);
    }
  }

  static Future<dynamic> read(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.get(key);
  }

  static remove(String key) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove(key);
  }
}

class SharedPrefPath {
  static const String introductionFlag = "introductionFlag";
  static const String token = "token";
  static const String refreshToken = "refreshToken";
  static const String username = "username";
}
