import 'package:shared_preferences/shared_preferences.dart';

class CasheHelper {
  static SharedPreferences? _sharedPreferences;

  static Future<void> init() async {
    _sharedPreferences = await SharedPreferences.getInstance();
  }

  static Future<bool?> saveDate({
    required String key,
    required dynamic value,
  }) async {
    if (value is int) {
      return _sharedPreferences!.setInt(key, value);
    }
    if (value is String) {
      return _sharedPreferences!.setString(key, value);
    }
    if (value is double) {
      return _sharedPreferences!.setDouble(key, value);
    }
    if (value is bool) {
      return _sharedPreferences!.setBool(key, value);
    }
    return null;
  }

  static dynamic getData({required String key}) {
    return _sharedPreferences!.get(key);
  }
}
