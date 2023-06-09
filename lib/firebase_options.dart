// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
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
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
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
    apiKey: 'AIzaSyDNUxD_eciPueDu4E3iiD_8lIwV6z1yzAM',
    appId: '1:1064735434782:web:38b671e7577e59f420e60f',
    messagingSenderId: '1064735434782',
    projectId: 'e-archive-c4546',
    authDomain: 'e-archive-c4546.firebaseapp.com',
    storageBucket: 'e-archive-c4546.appspot.com',
    measurementId: 'G-QB30XHM153',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBjyli8c2BjiFP7KzCs15G4DrmPzupKkTg',
    appId: '1:1064735434782:android:babcd06f801d0dbc20e60f',
    messagingSenderId: '1064735434782',
    projectId: 'e-archive-c4546',
    storageBucket: 'e-archive-c4546.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDo9fsYAltzzQ2xwEy_menn-Lr0_44O6tA',
    appId: '1:1064735434782:ios:804cea19c0aea9f120e60f',
    messagingSenderId: '1064735434782',
    projectId: 'e-archive-c4546',
    storageBucket: 'e-archive-c4546.appspot.com',
    iosClientId: '1064735434782-p9hg6c13lk0f8l53eti88of075rd0gev.apps.googleusercontent.com',
    iosBundleId: 'com.example.eArchive',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDo9fsYAltzzQ2xwEy_menn-Lr0_44O6tA',
    appId: '1:1064735434782:ios:804cea19c0aea9f120e60f',
    messagingSenderId: '1064735434782',
    projectId: 'e-archive-c4546',
    storageBucket: 'e-archive-c4546.appspot.com',
    iosClientId: '1064735434782-p9hg6c13lk0f8l53eti88of075rd0gev.apps.googleusercontent.com',
    iosBundleId: 'com.example.eArchive',
  );
}
