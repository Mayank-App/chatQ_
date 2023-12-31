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
    apiKey: 'AIzaSyC3IcF3YwguX7WObOIbq7oEaoja3Y0P_lY',
    appId: '1:958731467455:web:b6ce241dc99529d803240a',
    messagingSenderId: '958731467455',
    projectId: 'chatapp-b0a0f',
    authDomain: 'chatapp-b0a0f.firebaseapp.com',
    storageBucket: 'chatapp-b0a0f.appspot.com',
    measurementId: 'G-0GXFJXLFH0',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBfssmHzwEDhMdpHAji6rpmw5uja0IBFFA',
    appId: '1:958731467455:android:86292b01ddb0650c03240a',
    messagingSenderId: '958731467455',
    projectId: 'chatapp-b0a0f',
    storageBucket: 'chatapp-b0a0f.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyA1XhaYBeBU7zXztmZkHUB04nz2IQc7Pw0',
    appId: '1:958731467455:ios:7b3ab7f4e633f91003240a',
    messagingSenderId: '958731467455',
    projectId: 'chatapp-b0a0f',
    storageBucket: 'chatapp-b0a0f.appspot.com',
    iosClientId: '958731467455-5gdcl4rp1hqhv5fovakv3qapkgvem716.apps.googleusercontent.com',
    iosBundleId: 'com.example.chatApplication',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyA1XhaYBeBU7zXztmZkHUB04nz2IQc7Pw0',
    appId: '1:958731467455:ios:ca37aeb7646b636303240a',
    messagingSenderId: '958731467455',
    projectId: 'chatapp-b0a0f',
    storageBucket: 'chatapp-b0a0f.appspot.com',
    iosClientId: '958731467455-ra95e427j2g2eq9mauiq567772ita7jf.apps.googleusercontent.com',
    iosBundleId: 'com.example.chatApplication.RunnerTests',
  );
}
