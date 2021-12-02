import 'package:adhan_dart/adhan_dart.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:cron/cron.dart';
import 'package:dr_social/controllers/prayer_time_controller.dart';
import 'package:dr_social/models/paryer_hour.dart';
import 'package:dr_social/views/components/prayer_time_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../page_name_container.dart';

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
    final cron = Cron();
    cron.schedule(Schedule.parse('*/1 * * * *'), () async {
      createWaterReminderNotification();
    });
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
      ),
      PrayerHour(
        salahName: 'صلاة الظهر',
        time: convertTimeToString(prayerTimes.dhuhr),
      ),
      PrayerHour(
        salahName: 'صلاة العصر',
        time: convertTimeToString(prayerTimes.asr),
      ),
      PrayerHour(
        salahName: 'صلاة المغرب',
        time: convertTimeToString(prayerTimes.maghrib),
      ),
      PrayerHour(
        salahName: 'صلاة العشاء',
        time: convertTimeToString(prayerTimes.isha),
      ),
    ];
  }

  Future<void> createWaterReminderNotification() async {
    await AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: 2,
        channelKey: 'basic_channel',
        title: '${Emojis.wheater_droplet} Add some water to your plant!',
        body: 'Water your plant regularly to keep it healthy.',
        notificationLayout: NotificationLayout.Default,
      ),
      actionButtons: [
        NotificationActionButton(
          key: 'MARK_DONE',
          label: 'Mark Done',
        )
      ],
      schedule: NotificationCalendar(
        weekday: DateTime.now().weekday,
        hour: DateTime.now().hour,
        minute: DateTime.now().minute,
        second: DateTime.now().add(Duration(seconds: 5)).second,
        millisecond: 0,
      ),
    );
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
              width: 75.w,
              height: double.infinity,
              color: Colors.white,
            ),
          ),
        ),
        Container(
          transform: Matrix4.translationValues(0.0, -5.h, 0.0),
          child: CustomScrollView(
            slivers: [
              PageNameContainer(
                pageTitle: 'مواعيد الصلاة',
                minHeight: 15.0.h,
                maxHeight: 25.0.h,
                bottomBorderRad: const Radius.elliptical(100, 40),
                backgroundImageUrl: 'assets/images/mosque.jpg',
              ),
              SliverPadding(
                padding: EdgeInsets.fromLTRB(3.w, 5.h, 3.w, 10.h),
                sliver: SliverStaggeredGrid.countBuilder(
                  crossAxisCount: 2,
                  itemCount: 5,
                  itemBuilder: (BuildContext context, int index) =>
                      PrayerTimeContainer(
                          salahName: prayerHour[index].salahName,
                          dateName: prayerHour[index].time),
                  staggeredTileBuilder: (int index) {
                    return StaggeredTile.count(index == 5 - 1 ? 2 : 1, 1);
                  },
                  crossAxisSpacing: 2.w,
                  mainAxisSpacing: 2.h,
                ),
              ),
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
