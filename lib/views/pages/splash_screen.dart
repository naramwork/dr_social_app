import 'package:dr_social/controllers/prayer_time_controller.dart';
import 'package:dr_social/views/main_layout.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class SplashScreen extends StatefulWidget {
  static const routeName = '/';

  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  String text = '';
  @override
  void initState() {
    super.initState();
    context.read<PrayerTimeController>().initPrayerTime().then(
          (value) =>
              Navigator.pushReplacementNamed(context, MainLayout.routeName),
        );

    //.then(
    //           (value) => Navigator.pushNamed(context, MainLayout.routeName),
    //     )
  }

  @override
  Widget build(BuildContext context) {
    // context.read<PrayerTimeController>().initPrayerTime().then((value) =>
    //     print(context.read<PrayerTimeController>().getNearestAzanTime()));
    return Scaffold(
      body: Container(
        child: Text(
          ' ' + text,
          textAlign: TextAlign.start,
          style: TextStyle(
              //textStyle of the heading in the homeScreen
              color: Colors.white,
              fontWeight: FontWeight.w500,
              fontSize: 16.0.sp),
        ),
      ),
    );
  }
}
