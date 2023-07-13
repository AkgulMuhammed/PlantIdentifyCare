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

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBirTaZ_SUz0Lx8Ehr2N2vyCwzj9DBad0Y',
    appId: '1:706343572374:android:2086f36cfd8e77107ac3b7',
    messagingSenderId: '706343572374',
    projectId: 'plant-identify-care',
    storageBucket: 'plant-identify-care.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBYC5J4PdvTYjRywivv4hODmU0IhCmfNgQ',
    appId: '1:706343572374:ios:693c06b49c01cea57ac3b7',
    messagingSenderId: '706343572374',
    projectId: 'plant-identify-care',
    storageBucket: 'plant-identify-care.appspot.com',
    iosClientId:
        '706343572374-pk88kbt9eojc4fnb55pmkgvkj3pnj5vi.apps.googleusercontent.com',
    iosBundleId: 'com.example.plantIdentifyCare',
  );
}
