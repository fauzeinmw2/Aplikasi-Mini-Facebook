import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

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
        throw UnsupportedError(
          'Blm Support IOS',
        );
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

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyC8GExm1a8mhvQGMON7_X9XTDwybbD6d3U',
    appId: '1:203049055648:android:7973928087b714521fe0c5',
    messagingSenderId: '203049055648',
    projectId: 'aplikasi-mini-facebook',
    storageBucket: 'aplikasi-mini-facebook.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCuAS0zWBc75eb-AxvaTjwLoO3k7usy2cY',
    appId: '1:203049055648:ios:d00d972d3e7e90491fe0c5',
    messagingSenderId: '203049055648',
    projectId: 'aplikasi-mini-facebook',
    storageBucket: 'aplikasi-mini-facebook.appspot.com',
    iosClientId: '203049055648-n0af40stdisih0363tldog2pslog174o.apps.googleusercontent.com',
    iosBundleId: 'com.famuwa.aplikasiMiniFacebook',
  );
}
