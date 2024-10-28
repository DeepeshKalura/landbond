import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesService {
  static const String _isNewUserKey = 'isNewUser';

  Future<bool> isNewUser() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_isNewUserKey) ?? true;
  }

  Future<void> setNewUser(bool isNewUser) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_isNewUserKey, isNewUser);
  }
}
