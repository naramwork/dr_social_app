import 'dart:math';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:dr_social/app/helper_files/app_const.dart';
import 'package:dr_social/app/helper_files/functions.dart';
import 'package:dr_social/models/dua.dart';
import 'package:dr_social/models/hadith.dart';
import 'package:dr_social/models/verse.dart';
import 'package:flutter/material.dart';

NotificationChannel setNewContentChannel(
        {required String name, required String key, required String sound}) =>
    NotificationChannel(
        channelKey: key,
        channelName: name,
        channelDescription: 'المحتوى اليومي',
        ledColor: Colors.white,
        defaultColor: Colors.blue,
        importance: NotificationImportance.Max,
        playSound: true,
        channelGroupKey: kContentChannelGroupKey,
        soundSource: sound);

void generateWeekVersesNotification(List<Verse> verses) async {
  generateWeekContentNotification(
      contents: verses,
      title: 'الآية اليومية',
      channelKey: kVersesChannleKey,
      hour: 8,
      minute: 30);
  // var rng = Random();
  // int date = 0;

  // for (var verse in verses) {
  //   int id =
  //       createUniqueId(DateTime.parse(verse.createdAt)) + rng.nextInt(1000);
  //   await AwesomeNotifications().createNotification(
  //     content: NotificationContent(
  //         id: id,
  //         channelKey: kVersesChannleKey,
  //         title: 'الآية اليومية',
  //         body: verse.content,
  //         backgroundColor: const Color(0xFF184B6C),
  //         color: Colors.white,
  //         category: NotificationCategory.Alarm),
  //     schedule: NotificationCalendar(
  //         month: DateTime.now().add(Duration(days: date)).month,
  //         day: DateTime.now().add(Duration(days: date)).day,
  //         hour: 8,
  //         minute: 0),
  //   );
  //   date++;
  // }
}

void generateWeekDuaNotification(List<Dua> duas) async {
  generateWeekContentNotification(
      contents: duas,
      title: 'الدعاء اليومي',
      channelKey: kDuasChannleKey,
      hour: 6,
      minute: 30);
  // var rng = Random();
  // int date = 0;
  // for (var dua in duas) {
  //   int id = createUniqueId(DateTime.parse(dua.updatedAt)) + rng.nextInt(1000);
  //   await AwesomeNotifications().createNotification(
  //     content: NotificationContent(
  //         id: id,
  //         channelKey: kDuasChannleKey,
  //         title: 'الدعاء اليومي',
  //         body: dua.content,
  //         backgroundColor: const Color(0xFF184B6C),
  //         color: Colors.white,
  //         category: NotificationCategory.Alarm),
  //     schedule: NotificationCalendar(
  //         month: DateTime.now().add(Duration(days: date)).month,
  //         day: DateTime.now().add(Duration(days: date)).day,
  //         hour: 6,
  //         minute: 33),
  //   );
  //   date++;
  // }
}

void generateWeekHadithNotification(List<Hadith> hadiths) async {
  generateWeekContentNotification(
      contents: hadiths,
      title: 'الحديث الشريف',
      channelKey: kHadithChannleKey,
      hour: 11,
      minute: 30);
  // var rng = Random();
  // int date = 0;
  // for (var hadith in hadiths) {
  //   int id =
  //       createUniqueId(DateTime.parse(hadith.updatedAt)) + rng.nextInt(1000);
  //   await AwesomeNotifications().createNotification(
  //     content: NotificationContent(
  //         id: id,
  //         channelKey: kHadithChannleKey,
  //         title: 'الحديث الشريف',
  //         body: hadith.content,
  //         backgroundColor: const Color(0xFF184B6C),
  //         color: Colors.white,
  //         category: NotificationCategory.Alarm),
  //     schedule: NotificationCalendar(
  //         month: DateTime.now().add(Duration(days: date)).month,
  //         day: DateTime.now().add(Duration(days: date)).day,
  //         hour: 20,
  //         minute: 30),
  //   );
  //   date++;
  // }
}

void generateWeekContentNotification(
    {required List contents,
    required String title,
    required String channelKey,
    required int hour,
    required int minute}) async {
  // bool isExists = await checkIfOlreadyExists(channelKey);
  // if (isExists) return;
  var rng = Random();
  int date = 0;
  AwesomeNotifications().cancelNotificationsByChannelKey(channelKey);
  for (var content in contents) {
    int id =
        createUniqueId(DateTime.parse(content.updatedAt)) + rng.nextInt(1000);
    await AwesomeNotifications().createNotification(
      content: NotificationContent(
          id: id,
          channelKey: channelKey,
          title: title,
          body: content.content,
          backgroundColor: const Color(0xFF184B6C),
          color: Colors.white,
          category: NotificationCategory.Alarm),
      schedule: NotificationCalendar(
          month: DateTime.now().add(Duration(days: date)).month,
          day: DateTime.now().add(Duration(days: date)).day,
          hour: hour,
          minute: minute),
    );
    date++;
  }
}

Future<bool> checkIfOlreadyExists(String notificationChannel) async {
  List<NotificationModel> scheduleNotification =
      await AwesomeNotifications().listScheduledNotifications();
  if (scheduleNotification.isNotEmpty) {
    var list = scheduleNotification.where((element) {
      if (element.content?.channelKey == notificationChannel) {
        return true;
      } else {
        return false;
      }
    });
    List newList = list.toList();
    newList.sort((a, b) =>
        a.schedule!.toMap()['day'].compareTo(b.schedule!.toMap()['day']));

    if (newList.isNotEmpty) {
      NotificationModel versesNotifications = newList.first;
      if (versesNotifications.schedule!.toMap()['day'] == DateTime.now().day) {
        return true;
      } else {
        return false;
      }
    }
  }

  return false;
}
