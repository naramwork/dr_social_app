import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dr_social/controllers/prayer_time_controller.dart';
import 'package:dr_social/controllers/update_content_controler.dart';

import 'package:dr_social/views/pages/no_internet_page.dart';
import 'package:flutter/cupertino.dart';
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
    //context.read<MarriageController>().getMessages();

    ridirectBaseOnInternetConnection();
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
            Navigator.pushReplacementNamed(context, NoInternetPage.routeName);
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
    return Scaffold(
        body: Center(
      child: Image.asset(
        'assets/images/logo.png',
        width: 60.w,
        height: 60.w,
      ),
    ));
  }
}
