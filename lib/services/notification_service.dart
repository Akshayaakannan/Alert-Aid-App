import 'package:firebase_messaging/firebase_messaging.dart';

class NotificationService {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  Future<void> initNotifications() async {
    // Request permission (iOS only)
    await _firebaseMessaging.requestPermission();

    // Get FCM token
    String? token = await _firebaseMessaging.getToken();
    print('FCM Token: $token');

    // Handle foreground messages
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('📲 Foreground Message Received: ${message.notification?.title}');
      // Optional: show local notification
    });

    // Handle background tap
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('🚀 App Opened from Notification: ${message.notification?.title}');
    });
  }

  // ✅ Move this outside
  Future<String?> getFcmToken() async {
    return await _firebaseMessaging.getToken();
  }
}
