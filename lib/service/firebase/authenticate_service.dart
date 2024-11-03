import 'dart:math' show Random;
import 'dart:developer';
import 'dart:io';
import 'package:uuid/uuid.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../presentation/auth/data/model/users.dart' as model;

class AuthenticateService {
  final _auth = FirebaseAuth.instance;
  final _database = FirebaseFirestore.instance;
  final _storage = FirebaseStorage.instance.ref("users/profilePhoto");

  Future<void> signInWithEmail(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
    } catch (e) {
      rethrow;
    }
  }

  String _generateRandomName() {
    final random = Random();
    final codeUnits = List.generate(10, (index) => random.nextInt(33) + 89);
    return String.fromCharCodes(codeUnits);
  }

  Future<void> singInWithApple() async {
    //   TODO: implement singInWithApple
  }

  Future<void> signInWithGoogle() async {
    try {
      final id = const Uuid().v4();
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      final credential = GoogleAuthProvider.credential(
          accessToken: googleAuth?.accessToken, idToken: googleAuth?.idToken);
      _auth.signInWithCredential(credential);

      if (_auth.isSignInWithEmailLink(googleUser!.email)) {
        return;
      }

      final user = model.Users(
        userId: id,
        name: googleUser.displayName ?? _generateRandomName(),
        email: googleUser.email,
        role: model.UserRole.consumer,
        // I don't this will be public for long
        profilePhotoUrl: googleUser.photoUrl ??
            "https://firebasestorage.googleapis.com/v0/b/realestate-a695d.appspot.com/o/users%2Fa8e2ceb8-3baa-4ce0-ae36-2e1cd4d39716%2FnoprofileImage.jpg?alt=media&token=d172b91f-fed9-48df-b92e-19ceea53c352",
      );
      _database.collection("users").doc(id).set(user.toJson());
    } catch (e) {
      rethrow;
    }
  }

  Future<String> getProfilePhotoUrl(
      String userId, File file, String filename) async {
    try {
      final profileDownloadUrl = await _storage
          .child("$userId/$filename")
          .putFile(file)
          .then((value) => value.ref.getDownloadURL());
      return profileDownloadUrl;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> deleteProfilePhoto(String userId) async {
    try {
      await _storage.child(userId).delete();
    } catch (e) {
      rethrow;
    }
  }

// Think about this again and again
  Future<void> createUserWithEmail(
      String email, String password, String name, File profilePhoto) async {
    try {
      final userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      final user = userCredential.user;
      if (user == null) throw Exception("User creation failed");

      final profilePhotoUrl = await getProfilePhotoUrl(
        user.uid,
        profilePhoto,
        profilePhoto.path.split("/").last,
      );

      final users = model.Users(
        userId: user.uid,
        name: name,
        email: email,
        role: model.UserRole.consumer,
        profilePhotoUrl: profilePhotoUrl,
      );

      await _database.runTransaction((transaction) async {
        final userDocRef =
            _database.collection("users").doc(users.userId.toString());
        transaction.set(userDocRef, users.toJson());
      });
    } catch (e) {
      try {
        final userDocRef =
            _database.collection("users").doc(_auth.currentUser?.uid);
        await userDocRef.delete();
      } catch (_) {}

      try {
        await deleteProfilePhoto(_auth.currentUser!.uid);
      } catch (_) {}

      try {
        await _auth.currentUser?.delete();
      } catch (_) {}

      rethrow;
    }
  }

  Future<void> sendVerficationCodeToEmail(String email) async {
    try {
      // await _auth.code(
      //   email,
      // );
    } catch (e) {
      rethrow;
    }
  }

  Future<void> forgotPassword(String code, String newPassword) async {
    try {
      final password =
          _auth.confirmPasswordReset(code: code, newPassword: newPassword);

      /*

      There is no forgot password like we design the strcture of the app. 
      OTP method does not exit in the firebase application.

      */
    } catch (_) {}
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
