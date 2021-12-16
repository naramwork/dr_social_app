import 'dart:math';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:dr_social/app/helper_files/app_const.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../firebase_options.dart';

var rng = Random();

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  print('message:$message');
  //createNotification(message);
}

void createNotification(RemoteMessage message) async {
  int id = rng.nextInt(1000);
  await AwesomeNotifications().createNotification(
      content: NotificationContent(
          id: id,
          channelKey: kFcmChannleKey,
          title: message.notification!.title,
          body: message.notification!.body,
          backgroundColor: const Color(0xFF184B6C),
          color: Colors.white,
          category: NotificationCategory.Alarm));
}

class NotificationController {
  static final NotificationController _notification =
      NotificationController._internal();
  late FirebaseMessaging messaging;

  factory NotificationController() => _notification;
  NotificationController._internal() {
    initializFcm();
  }

  void initializFcm() async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    messaging = FirebaseMessaging.instance;
    String? token = await messaging.getToken();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (token != null) {
      prefs.setString(kStorTokenKey, token);
    }

    FirebaseMessaging.instance.onTokenRefresh.listen((data) {});

    /// heads up notifications.
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
    subscibeAndListen();
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  }

  void subscibeAndListen() {
    messaging.subscribeToTopic("messaging");
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      createNotification(message);
    });
  }
}
