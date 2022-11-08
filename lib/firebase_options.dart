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
    apiKey: 'AIzaSyCuRrSDv_P1Dezs56jFQb6XiqkQVM7qIgc',
    appId: '1:1085723822312:web:813591c4a0a70e9901e15d',
    messagingSenderId: '1085723822312',
    projectId: 'receitas-caseiras-73457',
    authDomain: 'receitas-caseiras-73457.firebaseapp.com',
    storageBucket: 'receitas-caseiras-73457.appspot.com',
    measurementId: 'G-DBV71ESHB9',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyD4e-w27HSyWQ4Y266qgZtTJjWqyhwdolQ',
    appId: '1:1085723822312:android:0721a5f8b8cac31601e15d',
    messagingSenderId: '1085723822312',
    projectId: 'receitas-caseiras-73457',
    storageBucket: 'receitas-caseiras-73457.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCU1qiJg88fh-P0XOGE1lFTTLVFXvIhWJE',
    appId: '1:1085723822312:ios:22ac1ed654d7119801e15d',
    messagingSenderId: '1085723822312',
    projectId: 'receitas-caseiras-73457',
    storageBucket: 'receitas-caseiras-73457.appspot.com',
    iosClientId: '1085723822312-33taqs3154qp137tak5qotmfq400dhh4.apps.googleusercontent.com',
    iosBundleId: 'com.example.projetoFlutterMobile',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCU1qiJg88fh-P0XOGE1lFTTLVFXvIhWJE',
    appId: '1:1085723822312:ios:22ac1ed654d7119801e15d',
    messagingSenderId: '1085723822312',
    projectId: 'receitas-caseiras-73457',
    storageBucket: 'receitas-caseiras-73457.appspot.com',
    iosClientId: '1085723822312-33taqs3154qp137tak5qotmfq400dhh4.apps.googleusercontent.com',
    iosBundleId: 'com.example.projetoFlutterMobile',
  );
}
