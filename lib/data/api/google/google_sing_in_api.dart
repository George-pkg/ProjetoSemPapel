import 'package:google_sign_in/google_sign_in.dart';

class GoogleSingInApi {
  static final _googleSingIn = GoogleSignIn(scopes: ['email']);

  static Future<GoogleSignInAccount?> login() => _googleSingIn.signIn();

  static Future<GoogleSignInAccount?> logout() => _googleSingIn.signOut();
}
