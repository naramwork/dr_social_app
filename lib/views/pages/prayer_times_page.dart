import 'package:adhan_dart/adhan_dart.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:dr_social/app/helper_files/app_const.dart';
import 'package:dr_social/controllers/color_mode.dart';
import 'package:dr_social/controllers/prayer_time_controller.dart';
import 'package:dr_social/models/prayer_hour.dart';
import 'package:dr_social/models/prayer_notification.dart';

import 'package:dr_social/views/components/prayer_time_container.dart';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../components/page_name_container.dart';

class PrayerTimesPage extends StatefulWidget {
  const PrayerTimesPage({Key? key}) : super(key: key);

  @override
  State<PrayerTimesPage> createState() => _PrayerTimesPageState();
}

class _PrayerTimesPageState extends State<PrayerTimesPage> {
  List<PrayerHour> prayerHour = [];
  final double runSpacing = 4;
  final double spacing = 4;
  final int listSize = 15;
  final columns = 4;

  @override
  void initState() {
    super.initState();

    AwesomeNotifications().isNotificationAllowed().then((isAllowed) {
      if (!isAllowed) {
        // Insert here your friendly dialog box before call the request method
        // This is very important to not harm the user experience
        AwesomeNotifications().requestPermissionToSendNotifications();
      }
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    PrayerTimes prayerTimes = context.watch<PrayerTimeController>().prayerTimes;
    prayerHour = [
      PrayerHour(
        salahName: 'صلاة الفجر',
        time: convertTimeToString(prayerTimes.fajr),
        imageUrl: 'assets/images/fajer.png',
      ),
      PrayerHour(
        salahName: 'صلاة الظهر',
        time: convertTimeToString(prayerTimes.dhuhr),
        imageUrl: 'assets/images/zoher.png',
      ),
      PrayerHour(
        salahName: 'صلاة العصر',
        time: convertTimeToString(prayerTimes.asr),
        imageUrl: 'assets/images/asr.png',
      ),
      PrayerHour(
        salahName: 'صلاة المغرب',
        time: convertTimeToString(prayerTimes.maghrib),
        imageUrl: 'assets/images/magrb.png',
      ),
      PrayerHour(
        salahName: 'صلاة العشاء',
        time: convertTimeToString(prayerTimes.isha),
        imageUrl: 'assets/images/isha.png',
      ),
    ];

    checkAndAddNotifications(context);
  }

  void checkAndAddNotifications(BuildContext context) async {
    await Hive.openBox<PrayerNotification>(kNotificationBoxName);
    context.read<PrayerTimeController>().setWeeklyPrayerTime();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Center(
          child: Card(
            elevation: 4,
            margin: const EdgeInsets.all(0),
            child: Container(
              width: 85.w,
              height: double.infinity,
              color: context.watch<ColorMode>().isDarkMode
                  ? const Color(0xff111C2E)
                  : Colors.white,
            ),
          ),
        ),
        Container(
          transform: Matrix4.translationValues(0.0, -5.h, 0.0),
          child: CustomScrollView(
            slivers: [
              PageNameContainer(
                pageTitle: '﴿ مواعيد الصلاة ﴾',
                minHeight: 15.0.h,
                maxHeight: 25.0.h,
                bottomBorderRad: const Radius.elliptical(100, 40),
                backgroundImageUrl: 'assets/images/duas_bg.png',
              ),
              SliverPadding(
                  padding: EdgeInsets.fromLTRB(3.w, 5.h, 3.w, 10.h),
                  sliver: SliverToBoxAdapter(
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            PrayerTimeContainer(
                              salahName: prayerHour[0].salahName,
                              dateName: prayerHour[0].time,
                              imageUrl: prayerHour[0].imageUrl,
                              filterColer: Colors.blue.withOpacity(0.2),
                              color: Colors.blue.shade300,
                            ),
                            SizedBox(
                              width: 2.w,
                            ),
                            PrayerTimeContainer(
                              salahName: prayerHour[1].salahName,
                              dateName: prayerHour[1].time,
                              imageUrl: prayerHour[1].imageUrl,
                              filterColer: Colors.blue.withOpacity(0.3),
                              color: Colors.blue.shade200,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 2.h,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            PrayerTimeContainer(
                              salahName: prayerHour[2].salahName,
                              dateName: prayerHour[2].time,
                              imageUrl: prayerHour[2].imageUrl,
                              filterColer: Colors.blue.withOpacity(0.3),
                              color: const Color(0xff8AC0FF),
                            ),
                            SizedBox(
                              width: 2.w,
                            ),
                            PrayerTimeContainer(
                              salahName: prayerHour[3].salahName,
                              dateName: prayerHour[3].time,
                              imageUrl: prayerHour[3].imageUrl,
                              filterColer: Colors.blue.withOpacity(0.3),
                              color: const Color(0xff8B95DD),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 2.h,
                        ),
                        PrayerTimeContainer(
                          salahName: prayerHour[4].salahName,
                          dateName: prayerHour[4].time,
                          imageUrl: prayerHour[4].imageUrl,
                          filterColer: Colors.blue.withOpacity(0.3),
                          color: const Color(0xff7382EE),
                        ),
                      ],
                      //6077E5
                    ),
                  )),
            ],
          ),
        )
      ],
    );
  }

  String convertTimeToString(DateTime? dateTime) {
    return DateFormat.jms('ar_Dz').format(dateTime!.toLocal()).toString();
  }
}
