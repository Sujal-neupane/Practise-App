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
    apiKey: 'AIzaSyCS_gBf25yGh9EWmywB8ZTPTH9aDfFfnmI',
    appId: '1:96019757654:web:425f50310d295778a299f7',
    messagingSenderId: '96019757654',
    projectId: 'practise-app-d3cdd',
    authDomain: 'practise-app-d3cdd.firebaseapp.com',
    storageBucket: 'practise-app-d3cdd.firebasestorage.app',
    measurementId: 'G-BNHE19E8JX',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBgMFttMCi89x6qL6v6puUecBMKswOGAbw',
    appId: '1:96019757654:android:0b2e05a8654c9971a299f7',
    messagingSenderId: '96019757654',
    projectId: 'practise-app-d3cdd',
    storageBucket: 'practise-app-d3cdd.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCDbNGRbpSakDmFmRqImgFSlBRCIn0uQ7s',
    appId: '1:96019757654:ios:82f6ead5b8a21a7fa299f7',
    messagingSenderId: '96019757654',
    projectId: 'practise-app-d3cdd',
    storageBucket: 'practise-app-d3cdd.firebasestorage.app',
    iosBundleId: 'com.example.practiseApp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCDbNGRbpSakDmFmRqImgFSlBRCIn0uQ7s',
    appId: '1:96019757654:ios:82f6ead5b8a21a7fa299f7',
    messagingSenderId: '96019757654',
    projectId: 'practise-app-d3cdd',
    storageBucket: 'practise-app-d3cdd.firebasestorage.app',
    iosBundleId: 'com.example.practiseApp',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyCS_gBf25yGh9EWmywB8ZTPTH9aDfFfnmI',
    appId: '1:96019757654:web:94eefd0641f0631fa299f7',
    messagingSenderId: '96019757654',
    projectId: 'practise-app-d3cdd',
    authDomain: 'practise-app-d3cdd.firebaseapp.com',
    storageBucket: 'practise-app-d3cdd.firebasestorage.app',
    measurementId: 'G-B7JQ1VSZ0C',
  );
}
