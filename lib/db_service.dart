import 'dart:async';
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class DbService {
  static DbService? _instance;
  DbService._internal();

  static DbService? getInstance() {
    if (_instance == null) {
      _instance = DbService._internal();
    }
    return _instance;
  }

  Future<bool> saveAsJson(String key, String value) async {
    SharedPreferences _sharedPrefs = await SharedPreferences.getInstance();
    return _sharedPrefs.setString(key, jsonEncode(value));
  }

  FutureOr<String?> getJson(String key) async {
    SharedPreferences _sharedPrefs = await SharedPreferences.getInstance();
    String? res = _sharedPrefs.getString(key);
    return res;
  }
}
