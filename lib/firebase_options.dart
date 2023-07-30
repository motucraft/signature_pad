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
    apiKey: 'AIzaSyAMrkViEcS7vCzCrV7Mv8pY70-1yXYPSkI',
    appId: '1:563069818621:web:c7ab3e90b3da129e1f5094',
    messagingSenderId: '563069818621',
    projectId: 'signature-pad-dbccd',
    authDomain: 'signature-pad-dbccd.firebaseapp.com',
    storageBucket: 'signature-pad-dbccd.appspot.com',
    measurementId: 'G-G8FVCDVNM9',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDPSAz5VQs4oAopibsgQbYIByGArT4ji94',
    appId: '1:563069818621:android:c4e03523f5bc6e1d1f5094',
    messagingSenderId: '563069818621',
    projectId: 'signature-pad-dbccd',
    storageBucket: 'signature-pad-dbccd.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAYJn0j7A1ss8UK67FBrf-dabVCwd1TMOI',
    appId: '1:563069818621:ios:e9796fd2d1110b871f5094',
    messagingSenderId: '563069818621',
    projectId: 'signature-pad-dbccd',
    storageBucket: 'signature-pad-dbccd.appspot.com',
    iosClientId: '563069818621-cj99t9ubbj0btjtdmavvibd0nvfv36g6.apps.googleusercontent.com',
    iosBundleId: 'jp.motucraft.signaturePad',
  );
}
