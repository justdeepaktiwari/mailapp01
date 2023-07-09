import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesUtils {
  static late SharedPreferences _prefs;

  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  static int getIntValuesSF(String key) {
    return _prefs.getInt(key) ?? 0;
  }

  static Future<void> addIntToSF(String key, int value) async {
    await _prefs.setInt(key, value);
  }

  static bool getBoolValuesSF(String key) {
    return _prefs.getBool(key) ?? false;
  }

  static Future<void> addBoolToSF(String key, bool value) async {
    await _prefs.setBool(key, value);
  }

  static String getStringValuesSF(String key) {
    return _prefs.getString(key) ?? "";
  }

  static Future<void> addStringToSF(String key, String value) async {
    await _prefs.setString(key, value);
  }

  static bool removeValue(List<String> keys) {
    for (var element in keys) {
      _prefs.remove(element);
    }
    return true;
  }
}
