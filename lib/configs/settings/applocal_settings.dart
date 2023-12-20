import 'package:shared_preferences/shared_preferences.dart';

class ApplocalSettings {
  Map<String, String> localUser = {
    'id': '',
    'email': '',
    'displayName': '',
    'photoUrl': '',
    'serverAuthCode': '',
  };

  static void setLoacalUser(
      String email, String id, String photoUrl, String displayName, ) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.setString('id', id);
    prefs.setString('email', email);
    prefs.setString('photoUrl', photoUrl);
    prefs.setString('displayName', displayName);
  }

  cleanLocalUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();

    return localUser = {
      'id': '',
      'email': '',
      'displayName': '',
      'photoUrl': '',
      'serverAuthCode': '',
    };
  }

  Future<Map<String, String>> readLocal() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    final email = prefs.getString('email') ?? 'Null';
    final id = prefs.getString('id') ?? 'Null';
    final displayName = prefs.getString('displayName') ?? 'Null';
    final photoUrl = prefs.getString('photoUrl') ?? 'Null';
    final serverAuthCode = prefs.getString('serverAuthCode') ?? 'Null';

    return localUser = {
      'id': id,
      'email': email,
      'displayName': displayName,
      'photoUrl': photoUrl,
      'serverAuthCode': serverAuthCode,
    };
  }
}
