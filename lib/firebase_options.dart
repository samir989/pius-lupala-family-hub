import 'package:firebase_core/firebase_core.dart';

class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform => const FirebaseOptions(
        apiKey: 'REPLACE_WITH_FIREBASE_API_KEY',
        appId: 'REPLACE_WITH_FIREBASE_APP_ID',
        messagingSenderId: 'REPLACE_WITH_FIREBASE_MESSAGING_SENDER_ID',
        projectId: 'REPLACE_WITH_FIREBASE_PROJECT_ID',
        storageBucket: 'REPLACE_WITH_FIREBASE_STORAGE_BUCKET',
      );
}
