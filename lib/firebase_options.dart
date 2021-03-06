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
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyCBle4Ca9q570GX7dKdbyYCOpYpdGnqzJE',
    appId: '1:235905230876:web:09d4c9b64cc28aee25d7d9',
    messagingSenderId: '235905230876',
    projectId: 'mynote-rbrishabh76',
    authDomain: 'mynote-rbrishabh76.firebaseapp.com',
    storageBucket: 'mynote-rbrishabh76.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBXkbyY_bH7vFboenkIqLrRhDv5EKJ-7fQ',
    appId: '1:235905230876:android:5657164898b1f5f725d7d9',
    messagingSenderId: '235905230876',
    projectId: 'mynote-rbrishabh76',
    storageBucket: 'mynote-rbrishabh76.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCK0QjAyDCPcJAnf7Bn2mRGb3-jw0D2DiU',
    appId: '1:235905230876:ios:d1b7b95c4f50dac625d7d9',
    messagingSenderId: '235905230876',
    projectId: 'mynote-rbrishabh76',
    storageBucket: 'mynote-rbrishabh76.appspot.com',
    iosClientId: '235905230876-his1b0aub1ceg0vk0dnqvu9b5kpqimps.apps.googleusercontent.com',
    iosBundleId: 'com.example.notes',
  );
}
