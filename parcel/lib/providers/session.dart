import 'package:shared_preferences/shared_preferences.dart';

class SessionService{
  static const logInKey = 'isLoggedIn';
  static const idKey = 'id';
  Future<void> setLoggedIn(String id) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(logInKey, true);
    await prefs.setString(idKey, id);
  }

  Future<bool> isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(logInKey) ?? false;
  }

  Future<String?> getId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(idKey);
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }
}