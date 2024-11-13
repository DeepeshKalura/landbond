// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        return windows;
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyCN5Jmhh01fpiFBFpzMdvmtez3D9RqNq_s',
    appId: '1:106808724897:web:44067a0bf5cced1aa20fe0',
    messagingSenderId: '106808724897',
    projectId: 'realestate-a695d',
    authDomain: 'realestate-a695d.firebaseapp.com',
    storageBucket: 'realestate-a695d.appspot.com',
    measurementId: 'G-SZDF88ZKS3',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDJj6Bt27vVuR9gWWYWLahOxQm0uvc6nfw',
    appId: '1:106808724897:android:822c2177423d864da20fe0',
    messagingSenderId: '106808724897',
    projectId: 'realestate-a695d',
    storageBucket: 'realestate-a695d.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDF7Mefb1eYZHHCkUEqvc1FPqDu71pqlRc',
    appId: '1:106808724897:ios:82ee3356f42ab11fa20fe0',
    messagingSenderId: '106808724897',
    projectId: 'realestate-a695d',
    storageBucket: 'realestate-a695d.appspot.com',
    iosBundleId: 'com.example.agent',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDF7Mefb1eYZHHCkUEqvc1FPqDu71pqlRc',
    appId: '1:106808724897:ios:82ee3356f42ab11fa20fe0',
    messagingSenderId: '106808724897',
    projectId: 'realestate-a695d',
    storageBucket: 'realestate-a695d.appspot.com',
    iosBundleId: 'com.example.agent',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyCN5Jmhh01fpiFBFpzMdvmtez3D9RqNq_s',
    appId: '1:106808724897:web:5c237b930c3bf081a20fe0',
    messagingSenderId: '106808724897',
    projectId: 'realestate-a695d',
    authDomain: 'realestate-a695d.firebaseapp.com',
    storageBucket: 'realestate-a695d.appspot.com',
    measurementId: 'G-DG1ZD5VTB9',
  );

}