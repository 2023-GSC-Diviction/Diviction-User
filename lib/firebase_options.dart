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
    apiKey: 'AIzaSyCXtoMbpfMT-QHtkU-eT87q20zMxjxNpDE',
    appId: '1:276358087558:web:0d7be920ce5399fb6f6207',
    messagingSenderId: '276358087558',
    projectId: 'sturdy-now-380610',
    authDomain: 'sturdy-now-380610.firebaseapp.com',
    databaseURL: 'https://sturdy-now-380610-default-rtdb.asia-southeast1.firebasedatabase.app',
    storageBucket: 'sturdy-now-380610.appspot.com',
    measurementId: 'G-RNH0L4MTX8',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAwCHIx8ZfRVn-nhc8RhAFd_Dju99salWc',
    appId: '1:276358087558:android:62c36e0ccc07d1776f6207',
    messagingSenderId: '276358087558',
    projectId: 'sturdy-now-380610',
    databaseURL: 'https://sturdy-now-380610-default-rtdb.asia-southeast1.firebasedatabase.app',
    storageBucket: 'sturdy-now-380610.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDz0z-vlFE1rWWC7V6CJDxD-uFzOPvy7dI',
    appId: '1:276358087558:ios:466fe8ccd50104596f6207',
    messagingSenderId: '276358087558',
    projectId: 'sturdy-now-380610',
    databaseURL: 'https://sturdy-now-380610-default-rtdb.asia-southeast1.firebasedatabase.app',
    storageBucket: 'sturdy-now-380610.appspot.com',
    iosClientId: '276358087558-k50ap601s3hbhci2706b1pgi84sd1ui1.apps.googleusercontent.com',
    iosBundleId: 'com.diviction.divictionUser',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDz0z-vlFE1rWWC7V6CJDxD-uFzOPvy7dI',
    appId: '1:276358087558:ios:52f39f4cc091c4426f6207',
    messagingSenderId: '276358087558',
    projectId: 'sturdy-now-380610',
    databaseURL: 'https://sturdy-now-380610-default-rtdb.asia-southeast1.firebasedatabase.app',
    storageBucket: 'sturdy-now-380610.appspot.com',
    iosClientId: '276358087558-ba7jq87134m2rrra7h8pe2rcb8hs5tbe.apps.googleusercontent.com',
    iosBundleId: 'com.example.divictionUser',
  );
}
