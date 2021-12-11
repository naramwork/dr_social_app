import 'dart:io';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dr_social/controllers/prayer_time_controller.dart';
import 'package:dr_social/controllers/update_content_controler.dart';
import 'package:intl/intl.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import 'package:dr_social/views/main_layout.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  static const routeName = '/';

  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    // Box updateContentBox = Hive.box<Dua>(kDuaBoxName);
    // var list = updateContentBox.values;
    // //list.lastUpdate = 'naram';
    // //list.save();
    // print(list);

    // }

    //ridirectBaseOnInternetConnection();
    // int returnOrder(String){

    // }
  }

  void ridirectBaseOnInternetConnection() async {
    var connectivityResult = await (Connectivity().checkConnectivity());

    bool isOnline = await checkConnection();

    context.read<PrayerTimeController>().initPrayerTime().then((value) {
      if (connectivityResult == ConnectivityResult.none || !isOnline) {
        context
            .read<UpdateContentController>()
            .getOfTheDayOffline()
            .then((value) {
          if (value) {
            Navigator.pushReplacementNamed(context, MainLayout.routeName);
          } else {
            Navigator.pushReplacementNamed(context, MainLayout.routeName,
                arguments: -1);
          }
        });
      } else {
        context.read<UpdateContentController>().checkForUpdates();
        Navigator.pushReplacementNamed(context, MainLayout.routeName);
      }
    });
  }

  Future<bool> checkConnection() async {
    bool isOnline = false;
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        isOnline = true;
      } else {
        isOnline = false;
      }
    } on SocketException catch (_) {
      isOnline = false;
    }

    return Future.value(isOnline);
  }

// return true when there is no connection
  Future<bool> checkForIntern() async {
    var connectivityResult = await (Connectivity().checkConnectivity());

    bool isOnline = await checkConnection();
    if (connectivityResult == ConnectivityResult.none || !isOnline) {
      return Future.value(false);
    } else {
      return Future.value(true);
    }
  }

  @override
  Widget build(BuildContext context) {
    // context.read<PrayerTimeController>().initPrayerTime().then((value) =>
    //     print(context.read<PrayerTimeController>().getNearestAzanTime()));

    return Scaffold(
        body: Center(
      child: Image.asset(
        'assets/images/logo.png',
        width: 60.w,
        height: 60.w,
      ),
      // child: ElevatedButton(
      //   child: Text('naram'),
      //   onPressed: () {
      //     String prayerNotification = 'اذان العصر';
      //     AwesomeNotifications().createNotification(
      //       content: NotificationContent(
      //           id: 4124,
      //           channelKey: 'fajer_time',
      //           title: 'صلاة',
      //           body: 'حان الأن موعد ${prayerNotification}',
      //           backgroundColor: const Color(0xFF184B6C),
      //           color: Colors.white,
      //           category: NotificationCategory.Alarm),
      //     );
      //   },
      // ),
    ));
  }
}
