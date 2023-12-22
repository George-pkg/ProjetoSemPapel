import 'package:shared_preferences/shared_preferences.dart';

class UserLocal {
  Map<String, String> localUser = {
    'id': '',
    'email': '',
    'name': '',
    'photoUrl': '',
  };

  UserLocal();

  static void setLocalUser(
    String email,
    String id,
    String photoUrl,
    String name,
  ) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.setString('id', id);
    prefs.setString('email', email);
    prefs.setString('photoUrl', photoUrl);
    prefs.setString('name', name);
  }

  Future<Map<String, String>> cleanLocalUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();

    return localUser = {
      'id': '',
      'email': '',
      'name': '',
      'photoUrl': '',
    };
  }

  Future<Map<String, String>> readLocal() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    final email = prefs.getString('email') ?? 'Null';
    final id = prefs.getString('id') ?? 'Null';
    final name = prefs.getString('name') ?? 'Null';
    final photoUrl = prefs.getString('photoUrl') ?? 'Null';

    return localUser = {
      'id': id,
      'email': email,
      'name': name,
      'photoUrl': photoUrl,
    };
  }
}
