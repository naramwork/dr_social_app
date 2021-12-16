import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:dr_social/app/helper_files/app_const.dart';
import 'package:dr_social/app/themes/color_const.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:expandable/expandable.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PrayerTimeContainer extends StatelessWidget {
  final String salahName;
  final String dateName;
  final String imageUrl;
  final Color filterColer;
  final Color color;

  const PrayerTimeContainer(
      {Key? key,
      required this.salahName,
      required this.dateName,
      required this.imageUrl,
      required this.filterColer,
      required this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ExpandableNotifier(
      child: ScrollOnExpand(
        scrollOnExpand: true,
        scrollOnCollapse: false,
        child: Expandable(
          collapsed: ExpandableButton(
            child: Card(
              elevation: 6,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(40),
              ),
              child: PrayerTimeCard(
                  salahName: salahName,
                  dateName: dateName,
                  imageUrl: imageUrl,
                  filterColer: filterColer,
                  color: color),
            ),
          ),
          expanded: ExpandableButton(
            child: Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(40),
              ),
              child: SizedBox(
                height: 65.w,
                child: Stack(
                  children: [
                    Positioned(
                      bottom: 0,
                      right: 0,
                      left: 0,
                      child: Container(
                        padding: EdgeInsets.fromLTRB(2.w, 20.w, 2.w, 0),
                        height: 40.w,
                        width: 40.w,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(40),
                          color: const Color.fromRGBO(4, 40, 82, 1),
                        ),
                        child: NotificationToggleButton(
                          salahName: salahName,
                        ),
                      ),
                    ),
                    PrayerTimeCard(
                        salahName: salahName,
                        dateName: dateName,
                        imageUrl: imageUrl,
                        filterColer: filterColer,
                        color: color),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class PrayerTimeCard extends StatelessWidget {
  final String salahName;
  final String dateName;
  final String imageUrl;
  final Color filterColer;
  final Color color;
  const PrayerTimeCard(
      {Key? key,
      required this.salahName,
      required this.dateName,
      required this.imageUrl,
      required this.filterColer,
      required this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 42.w,
      height: 45.w,
      padding: EdgeInsets.fromLTRB(2.w, 3.h, 2.w, 0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(40),
        color: color,
        image: DecorationImage(
          fit: BoxFit.cover,
          colorFilter: ColorFilter.mode(filterColer, BlendMode.dstIn),
          image: AssetImage(imageUrl),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(right: 2.w),
            child: Text(
              salahName,
              style: const TextStyle(
                  fontWeight: FontWeight.w500, color: Colors.white),
            ),
          ),
          SizedBox(
            height: 2.h,
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 2),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              color: const Color.fromRGBO(255, 255, 255, 0.6),
            ),
            child: const Text(
              'موعد الاذان',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 12,
                  fontWeight: FontWeight.w300),
            ),
          ),
          SizedBox(
            height: 4.h,
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: SizedBox(
              width: 30.w,
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  dateName,
                  style: const TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w500,
                      color: Colors.white),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class NotificationToggleButton extends StatefulWidget {
  final String salahName;
  const NotificationToggleButton({Key? key, required this.salahName})
      : super(key: key);

  @override
  _NotificationToggleButtonState createState() =>
      _NotificationToggleButtonState();
}

class _NotificationToggleButtonState extends State<NotificationToggleButton> {
  bool isActive = true;

  @override
  void initState() {
    getNotificationStatus(widget.salahName).then((value) => setState(() {
          isActive = value;
        }));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        cancelPrayer(widget.salahName);
        setState(() {
          isActive = !isActive;
        });
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            isActive ? Icons.notifications_off : Icons.notifications_active,
            color: ColorConst.lightBlue,
          ),
          SizedBox(
            height: 1.h,
          ),
          FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              isActive ? 'إلغاء التنبيه' : 'تفعيل التنبيه',
              style: TextStyle(
                  color: ColorConst.lightBlue,
                  fontWeight: FontWeight.w400,
                  fontSize: 8),
            ),
          )
        ],
      ),
    );
  }

  Future<void> cancelPrayer(salahName) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    switch (salahName) {
      case 'صلاة الفجر':
        AwesomeNotifications()
            .cancelNotificationsByChannelKey(kFajerChannleKey);
        bool value = await getNotificationStatus(salahName);
        prefs.setBool(isFajerNotificationActiveKey, !value);
        break;
      case 'صلاة الظهر':
        AwesomeNotifications()
            .cancelNotificationsByChannelKey(kduharChannleKey);

        bool value = await getNotificationStatus(salahName);
        prefs.setBool(isDuharNotificationActiveKey, !value);

        break;
      case 'صلاة العصر':
        AwesomeNotifications().cancelNotificationsByChannelKey(kAsrChannleKey);

        bool value = await getNotificationStatus(salahName);
        prefs.setBool(isAsrNotificationActiveKey, !value);
        break;
      case 'صلاة المغرب':
        AwesomeNotifications()
            .cancelNotificationsByChannelKey(kMaghrbChannleKey);

        bool value = await getNotificationStatus(salahName);
        prefs.setBool(isMagrbNotificationActiveKey, !value);
        break;
      case 'صلاة العشاء':
        AwesomeNotifications().cancelNotificationsByChannelKey(kishaChannleKey);
        bool value = await getNotificationStatus(salahName);
        prefs.setBool(isIshaNotificationActiveKey, !value);
        break;
    }
  }

  Future<bool> getNotificationStatus(salahName) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    switch (salahName) {
      case 'صلاة الفجر':
        return prefs.getBool(isFajerNotificationActiveKey) ?? true;

      case 'صلاة الظهر':
        return prefs.getBool(isDuharNotificationActiveKey) ?? true;

      case 'صلاة العصر':
        return prefs.getBool(isAsrNotificationActiveKey) ?? true;

      case 'صلاة المغرب':
        return prefs.getBool(isMagrbNotificationActiveKey) ?? true;

      case 'صلاة العشاء':
        return prefs.getBool(isIshaNotificationActiveKey) ?? true;
    }
    return true;
  }
}
