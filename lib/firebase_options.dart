import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart' show defaultTargetPlatform, kIsWeb;

class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    throw UnsupportedError(
      'DefaultFirebaseOptions are not supported for this platform.',
    );
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: "AIzaSyCOsqQPKvecu--RZJZhySQzlmt-_LfWwo4",
    authDomain: "fairguard-ai-8095a.firebaseapp.com",
    projectId: "fairguard-ai-8095a",
    storageBucket: "fairguard-ai-8095a.firebasestorage.app",
    messagingSenderId: "1055804637872",
    appId: "1:1055804637872:web:d792555bfab716c71f3175",
    measurementId: "G-7TYLSCY5T0",
  );
}