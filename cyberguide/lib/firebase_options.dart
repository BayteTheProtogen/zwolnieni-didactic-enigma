import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart' show defaultTargetPlatform, kIsWeb, TargetPlatform;

class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      throw UnsupportedError(
        'DefaultFirebaseOptions have not been configured for web - '
        'you can reconfigure this by running the FlutterFire CLI again.',
      );
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCU_4dz34uZlzr1b7-8MKj1oOmaQhtKTrU',
    appId: '1:602122649762:android:243f2063d98fca700c97fb',
    messagingSenderId: '602122649762',
    projectId: 'zwolnieni-5ac99',
    storageBucket: 'zwolnieni-5ac99.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDaeiws3Cp5cuPZhslo8DFJY5cuxVl1w5A',
    appId: '1:602122649762:ios:3c2f1ff8fc79bd190c97fb',
    messagingSenderId: '602122649762',
    projectId: 'zwolnieni-5ac99',
    storageBucket: 'zwolnieni-5ac99.firebasestorage.app',
    iosBundleId: 'cherry.ta3.guide',
  );
}
