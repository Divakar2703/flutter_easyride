import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage {
  static Future<void> saveUsername(String username) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('username', username);
  }

  static Future<String> getUsername() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('username') ?? '';
  }

  static Future<void> savePassword(String password) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('password', password);
  }

  static Future<String> getPassword() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('password') ?? '';
  }

  // Save a string value to SharedPreferences
  static Future<void> saveString(String key, String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(key, value);
  }

  // Retrieve a string value from SharedPreferences
  // static Future<String?> getString(String key) async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   return prefs.getString(key);
  // }
  static Future<String> getString(String key, {String defaultValue = ""}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // Use null-coalescing operator to ensure the fallback default value is used
    return prefs.getString(key) ?? defaultValue;
  }

  // Remove a value from SharedPreferences
  static Future<void> remove(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(key);
  }

  // Check if a key exists
  static Future<bool> containsKey(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.containsKey(key);
  }

  static Future<void> saveUserID(String userID) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('userID', userID);
  }

  static Future<String> getUserID() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('userID') ?? "";
  }
}
