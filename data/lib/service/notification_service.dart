import 'package:domain/util/logger.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class FirebaseNotificationService {
  static final FirebaseNotificationService _instance = FirebaseNotificationService._internal();
  final _localNotifications = FlutterLocalNotificationsPlugin();

  factory FirebaseNotificationService() {
    return _instance;
  }

  FirebaseNotificationService._internal() {
    _setupForegroundNotifications();
  }

  static Future<void> initialize() async {
    try {
      await Firebase.initializeApp();
    } catch (e) {
      Logger.info('Firebase initialization error: $e');
    }
  }

  Future<void> _setupForegroundNotifications() async {
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: false,
      badge: false,
      sound: false,
    );

    await _initializeNotifications();
    _setupMessageListener();
    await _requestPermissions();
  }

  Future<void> _initializeNotifications() async {
    const androidInit = AndroidInitializationSettings('@mipmap/ic_launcher');
    const iosInit = DarwinInitializationSettings();
    const initSettings =
        InitializationSettings(android: androidInit, iOS: iosInit);

    await _localNotifications.initialize(initSettings);
  }

  Future<void> _requestPermissions() async {
    await FirebaseMessaging.instance.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );
  }

  void _setupMessageListener() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      Logger.debug("Received foreground message: ${message.messageId}");
      await _handleForegroundMessage(message);
    });
  }

  Future<void> _handleForegroundMessage(RemoteMessage message) async {
    if (message.notification == null) return;

    const androidChannel = AndroidNotificationDetails(
      'high_importance_channel',
      'High Importance Notifications',
      importance: Importance.max,
      priority: Priority.high,
      showWhen: true,
      enableVibration: true,
      playSound: true,
    );

    const notificationDetails = NotificationDetails(
      android: androidChannel,
      iOS: DarwinNotificationDetails(
        presentAlert: true,
        presentBadge: true,
        presentSound: true,
      ),
    );

    await _localNotifications.show(
      message.hashCode,
      message.notification?.title ?? '',
      message.notification?.body ?? '',
      notificationDetails,
    );
  }

  Future<void> setupFCMToken({
    required Function(String) onTokenRefresh,
  }) async {
    try {
      String? token = await FirebaseMessaging.instance.getToken();
      if (token != null) {
        onTokenRefresh(token);
      }

      FirebaseMessaging.instance.onTokenRefresh.listen((newToken) async {
        onTokenRefresh(newToken);
      }).onError((error) {
        Logger.debug("Token refresh error: $error");
      });
    } catch (e) {
      Logger.debug("FCM token error: $e");
    }
  }
}
