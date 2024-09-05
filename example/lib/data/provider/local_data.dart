import 'package:shared_preferences/shared_preferences.dart';

class LocalData {
  static Future<String> getTokenFCM() async {
    final SharedPreferencesAsync prefs = SharedPreferencesAsync();
    return await prefs.getString('TokenFCM') ?? '';
  }

  static Future<void> setTokenFCM(String value) async {
    final SharedPreferencesAsync prefs = SharedPreferencesAsync();
    return prefs.setString('TokenFCM', value);
  }

  static Future<String> getTokenVoIP() async {
    final SharedPreferencesAsync prefs = SharedPreferencesAsync();
    return await prefs.getString('TokenVoIP') ?? '';
  }

  static Future<void> setTokenVoIP(String value) async {
    final SharedPreferencesAsync prefs = SharedPreferencesAsync();
    return prefs.setString('TokenVoIP', value);
  }

  static Future<String> getUserName() async {
    final SharedPreferencesAsync prefs = SharedPreferencesAsync();
    return await prefs.getString('UserName') ?? '';
  }

  static Future<void> setUserName(String value) async {
    final SharedPreferencesAsync prefs = SharedPreferencesAsync();
    return prefs.setString('UserName', value);
  }
}
