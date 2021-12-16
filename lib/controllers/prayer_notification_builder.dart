import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:dr_social/app/helper_files/app_const.dart';
import 'package:dr_social/models/prayer_notification.dart';
import 'package:flutter/material.dart';

Future<void> createPrayerNotification(
    PrayerNotification prayerNotification) async {
  await AwesomeNotifications()
      .cancelNotificationsByGroupKey(kPrayerChannelGroupKey);

  await AwesomeNotifications().createNotification(
    content: NotificationContent(
        id: prayerNotification.id,
        channelKey: prayerNotification.channelKey,
        title: 'صلاة',
        body: 'حان الأن موعد ${prayerNotification.salahName}',
        backgroundColor: const Color(0xFF184B6C),
        color: Colors.white,
        category: NotificationCategory.Alarm),
    schedule:
        NotificationCalendar.fromDate(date: prayerNotification.date.toLocal()),
  );
}

int createUniqueId(DateTime dateTime) {
  return dateTime.millisecondsSinceEpoch.remainder(100000);
}

void generateWeekPrayerNotification(
    List<PrayerNotification> prayerNotifications) async {
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
        importance: NotificationImportance.Max,
        playSound: true,
        channelGroupKey: 'prayer_times_group',
        soundSource: 'resource://raw/res_azan');
