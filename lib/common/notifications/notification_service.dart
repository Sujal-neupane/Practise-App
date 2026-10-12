import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';

@pragma('vm:entry-point')
Future<void> handleBackgroundMessage(RemoteMessage message) async {
  await Firebase.initializeApp();
  debugPrint('Received background notification: ${message.messageId}');
}

class NotificationService {
  NotificationService({FirebaseMessaging? messaging})
    : _messaging = messaging ?? FirebaseMessaging.instance;

  final FirebaseMessaging _messaging;

  Future<void> initialize() async {
    final supportedPlatform =
        kIsWeb ||
        const {
          TargetPlatform.android,
          TargetPlatform.iOS,
          TargetPlatform.macOS,
        }.contains(defaultTargetPlatform);
    if (!supportedPlatform) return;

    try {
      FirebaseMessaging.onBackgroundMessage(handleBackgroundMessage);
      await _messaging.requestPermission(alert: true, badge: true, sound: true);
      await _messaging.setForegroundNotificationPresentationOptions(
        alert: true,
        badge: true,
        sound: true,
      );

      final isApplePlatform =
          !kIsWeb &&
          const {
            TargetPlatform.iOS,
            TargetPlatform.macOS,
          }.contains(defaultTargetPlatform);
      if (isApplePlatform && await _messaging.getAPNSToken() == null) {
        debugPrint(
          'APNs token is not available yet; skipping FCM token setup.',
        );
        return;
      }

      final token = await _messaging.getToken();
      debugPrint('FCM token available: ${token != null}');
      FirebaseMessaging.onMessage.listen(_onForegroundMessage);
    } on FirebaseException catch (error) {
      debugPrint('Notification setup unavailable: ${error.code}');
    }
  }

  void _onForegroundMessage(RemoteMessage message) {
    debugPrint('Received foreground notification: ${message.messageId}');
  }
}
