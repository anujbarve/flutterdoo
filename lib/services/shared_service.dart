import 'package:shared_preferences/shared_preferences.dart';

mixin SharedPreferenceService {
  static late SharedPreferences prefs;
  static Future<void> initPrefs() async {
    prefs = await SharedPreferences.getInstance();
  }
  static set isLogin(bool value) => prefs.setBool('login', value);
  static bool get isLogin => prefs.getBool('login') ?? false;

  static set username(String value) => prefs.setString('username', value);
  static String get username => prefs.getString('username') ?? "test";
}