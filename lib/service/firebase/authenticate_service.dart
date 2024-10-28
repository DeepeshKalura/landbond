import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthenticateService {
  final _auth = FirebaseAuth.instance;

  Future<void> signInWithEmail(String email, String password) async {
    _auth.signInWithEmailAndPassword(email: email, password: password);
  }

  Future<void> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      final credential = GoogleAuthProvider.credential(
          accessToken: googleAuth?.accessToken, idToken: googleAuth?.idToken);
      _auth.signInWithCredential(credential);
    } catch (e) {
      log(e.toString());
    }
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }

  Future<bool> isAuthenticate() async {
    final user = _auth.userChanges();
    final isUser = await user.isEmpty;

    log('isUser: $isUser');
    return !isUser;
  }
}
