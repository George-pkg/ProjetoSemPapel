import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ApplocalSettings extends ChangeNotifier {
  late SharedPreferences _prefs;

  Map<String, String> localUser = {
    'id': '',
    'name': '',
    'photoURL': '',
  };

  static saveLocalUser(String name) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.setString('id', name);
  }

  startSettings() async {
    await _startPreferences();
    await _readLocal();
  }

  Future<void> _startPreferences() async {
    _prefs = await SharedPreferences.getInstance();
  }

  _readLocal() {
    final local = _prefs.getString('local');
  }
}
