import 'dart:math';

import 'package:adhan_dart/adhan_dart.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:dr_social/models/prayer_notification.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

Future<void> createPrayerNotification(
    PrayerNotification prayerNotification) async {
  await AwesomeNotifications().cancelAll();

  await AwesomeNotifications().createNotification(
    content: NotificationContent(
        id: prayerNotification.id,
        channelKey: prayerNotification.channelKey,
        title: 'تذكير',
        body:
            'موعد ${prayerNotification.salahName} ليوم ${prayerNotification.day}الساعة ${prayerNotification.salahTime}',
        backgroundColor: const Color(0xFF184B6C),
        color: Colors.white,
        category: NotificationCategory.Reminder),
    schedule:
        NotificationCalendar.fromDate(date: prayerNotification.date.toLocal()),
  );
}

int createUniqueId(DateTime dateTime) {
  return dateTime.millisecondsSinceEpoch.remainder(100000);
}

void generateWeekPrayerNotification(
    List<PrayerNotification> prayerNotifications) {
  for (var notification in prayerNotifications) {
    createPrayerNotification(notification);
  }
}

NotificationChannel setNewPrayerChannel(
        {required String name, required String key}) =>
    NotificationChannel(
        channelKey: key,
        channelName: name,
        channelDescription: 'التذكير بمواعيد الصلاة',
        ledColor: Colors.white,
        defaultColor: Colors.blue,
        importance: NotificationImportance.High,
        playSound: true,
        channelGroupKey: 'prayer_times_group');
