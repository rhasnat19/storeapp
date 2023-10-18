import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefsManager {
  final SharedPreferences _sharedPreferences;

  SharedPrefsManager(this._sharedPreferences);

  Future<void> saveData(String key, dynamic value) async {
    if (value is String) {
      await _sharedPreferences.setString(key, value);
    } else if (value is int) {
      await _sharedPreferences.setInt(key, value);
    } else if (value is double) {
      await _sharedPreferences.setDouble(key, value);
    } else if (value is bool) {
      await _sharedPreferences.setBool(key, value);
    }
  }

  dynamic getData(String key) {
    return _sharedPreferences.get(key);
  }

  final String isLogin = 'isLogin';
}
