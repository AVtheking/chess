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
    apiKey: 'AIzaSyDrXVBrL6FyCFOUnCcxJEwXoWpCpI1OmAo',
    appId: '1:411410540967:web:44c5f2ac5fd9fec9432e82',
    messagingSenderId: '411410540967',
    projectId: 'chess-b775c',
    authDomain: 'chess-b775c.firebaseapp.com',
    storageBucket: 'chess-b775c.appspot.com',
    measurementId: 'G-FKCQ1C2K9M',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBsfJYUND1dURW9lKZSQ6eTJ6pZe0hnOWA',
    appId: '1:411410540967:android:223076ab16a7c420432e82',
    messagingSenderId: '411410540967',
    projectId: 'chess-b775c',
    storageBucket: 'chess-b775c.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDfclhzYaXatvw0-TrQgRN9zMQOEcGxgAY',
    appId: '1:411410540967:ios:6b8e18a520b66806432e82',
    messagingSenderId: '411410540967',
    projectId: 'chess-b775c',
    storageBucket: 'chess-b775c.appspot.com',
    iosBundleId: 'com.example.multiplayerChess',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDfclhzYaXatvw0-TrQgRN9zMQOEcGxgAY',
    appId: '1:411410540967:ios:6b8e18a520b66806432e82',
    messagingSenderId: '411410540967',
    projectId: 'chess-b775c',
    storageBucket: 'chess-b775c.appspot.com',
    iosBundleId: 'com.example.multiplayerChess',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyDrXVBrL6FyCFOUnCcxJEwXoWpCpI1OmAo',
    appId: '1:411410540967:web:eb7f5a9c99004a6c432e82',
    messagingSenderId: '411410540967',
    projectId: 'chess-b775c',
    authDomain: 'chess-b775c.firebaseapp.com',
    storageBucket: 'chess-b775c.appspot.com',
    measurementId: 'G-RRHSHM6EWD',
  );
}
