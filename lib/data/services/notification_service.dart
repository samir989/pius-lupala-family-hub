import 'package:firebase_messaging/firebase_messaging.dart';
import '../../core/utils/firebase_error.dart';

class NotificationService {
  Future<void> initialize() => guardFirebase(() async {
        await FirebaseMessaging.instance.requestPermission();
        FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
      });
  Future<String?> token() => guardFirebase(() => FirebaseMessaging.instance.getToken());
}

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {}
