import 'package:shared_preferences/shared_preferences.dart';

abstract class SharedPreferencesInstance {
  static SharedPreferences? instance;

  static Future<void> initializeInstance() async {
    instance = await SharedPreferences.getInstance();
    return;
  }
}