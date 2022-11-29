import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPref {
  // SaveData._privateConstructor();
  // static final SaveData instance = SaveData._privateConstructor();

  bool isEmpty(value) {
    return value == null || value == "";
  }

  setStringValue(String key, String? value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    print('Save Data Success...');
    prefs.setString(key, value!);
  }

  Future<String> getStringValue(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(key) ?? "";
  }

  setStringArrayMenu(String key, List<dynamic> value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(key, json.encode(value));
  }

  Future<String> getStringArrayMenu(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(key) ?? "";
  }
}
