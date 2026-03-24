import 'package:shared_preferences/shared_preferences.dart';

class StorageHelper {
  static const dynamic tokenKey = 'user_token';
  static const String userIdKey = 'user_id';
  static const String foodIdKey = 'food_id';
  static const String userIdfavorate = 'userIdfavorate';
  static Future<void> saveToken(dynamic token) async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setString(tokenKey, token);
  }


  static Future<void> save1Token(int id) async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setInt(userIdKey, id);
  }


  static Future<void> save3Token(int id) async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setInt(userIdfavorate, id);
  }


  static Future<int?> get3Token() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(userIdfavorate);
  }
  static Future<void> save2Token(int id) async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setInt(foodIdKey, id);
  }

  static Future<int?> get2Token() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(foodIdKey);
  }


  static Future<int?> get1Token() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(userIdKey);
  }


  static Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(tokenKey);
  }

  static Future<String?> clearToken() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(tokenKey);
  }
}
