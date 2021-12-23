import 'dart:math';

import 'package:adhan_dart/adhan_dart.dart';
import 'package:dr_social/app/helper_files/app_const.dart';
import 'package:dr_social/controllers/prayer_notification_builder.dart';
import 'package:dr_social/models/arabic_date.dart';
import 'package:dr_social/models/prayer_notification.dart';
import 'package:flutter/foundation.dart';
import 'package:geocoding/geocoding.dart' as geo;
import 'package:hijri/hijri_calendar.dart';
import 'package:hive/hive.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:location/location.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PrayerTimeController with ChangeNotifier {
  late ArabicDate _arabicDate;
  late PrayerTimes _prayerTimes;

  String _locationName = 'غير محدد';

  ArabicDate get arabicDate => _arabicDate;
  PrayerTimes get prayerTimes => _prayerTimes;

  String get locationName => _locationName;

  Future initPrayerTime() async {
    initializeDateFormatting("ar_DZ", null).then((_) {
      HijriCalendar.setLocal("ar");
      HijriCalendar _today = HijriCalendar.now();
      setPrayerVars(_today);

      notifyListeners();
    });

    _prayerTimes = await getPrayerTime();
  }

  String getNearestAzanTime() {
    String timeRemaining = '';

    DateTime now = DateTime.now();

    DateTime? azanTime =
        _prayerTimes.timeForPrayer(skipPrayer(_prayerTimes.nextPrayer()));
    if (azanTime == null) return '';
    var timeDifference = azanTime.difference(now);

    int minutes = timeDifference.inMinutes;
    int hours = timeDifference.inHours;

    if (hours > 0) {
      switch (hours) {
        case 1:
          timeRemaining = 'ساعة';
          break;
        case 2:
          timeRemaining = 'ساعتين';
          break;
        default:
          timeRemaining = '$hours ساعات ';
      }
    } else {
      if (minutes < 10) {
        switch (minutes) {
          case 1:
            timeRemaining = 'دقيقة';
            break;
          case 2:
            timeRemaining = 'دقيقتين';
            break;
          default:
            timeRemaining = '$minutes دقائق ';
        }
      } else {
        timeRemaining = '$minutes دقيقة ';
      }
    }
    String azanName = getArabicAzanName(skipPrayer(_prayerTimes.nextPrayer()));
    if (azanName.isEmpty || timeRemaining.isEmpty) return '';
    return 'تبقى $timeRemaining لآذان $azanName';
  }

  String getArabicAzanName(String prayer) {
    if (prayer == Prayer.Fajr) {
      return 'الفجر';
    } else if (prayer == Prayer.Sunrise) {
      return 'شروق الشمس';
    } else if (prayer == Prayer.Dhuhr) {
      return 'الظهر';
    } else if (prayer == Prayer.Asr) {
      return 'العصر';
    } else if (prayer == Prayer.Maghrib) {
      return 'المغرب';
    } else if (prayer == Prayer.Isha) {
      return 'العشاء';
    } else if (prayer == Prayer.IshaBefore) {
      return 'العشاء';
    } else if (prayer == Prayer.FajrAfter) {
      return 'الفجر';
    } else {
      return '';
    }
  }

  String skipPrayer(String nextPrye) {
    if (nextPrye == Prayer.Sunrise) {
      return Prayer.Dhuhr;
    } else if (nextPrye == Prayer.IshaBefore) {
      return Prayer.Isha;
    }
    return nextPrye;
  }

  String nextAzanTime() {
    String time = '';
    DateTime? azanTime = _prayerTimes.timeForPrayer(_prayerTimes.nextPrayer());
    time = DateFormat.jm('ar_Dz').format(azanTime!.toLocal()).toString();
    return 'موعد الآذان $time';
  }

  void setPrayerVars(HijriCalendar hijriDate) {
    String monthName = hijriDate.getLongMonthName();
    String day = hijriDate.hDay.toString();
    String dayName = hijriDate.getDayName();
    String year = hijriDate.hYear.toString();

    _arabicDate = ArabicDate(
        monthName: monthName,
        dayName: dayName,
        day: day,
        year: year,
        gregorianDate: DateFormat.yMMMd('ar_DZ').format(DateTime.now()));
  }

  getLocation() async {
    Location location = Location();

    bool _serviceEnabled;
    PermissionStatus _permissionGranted;
    LocationData _locationData;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    _locationData = await location.getLocation();
    return _locationData;
  }

  Future<PrayerTimes> getPrayerTime() async {
    final LocationData location = await getLocation();
    try {
      List<geo.Placemark> placemarks = await geo.placemarkFromCoordinates(
          location.latitude!, location.longitude!,
          localeIdentifier: 'ar_SA');
      _locationName =
          '${placemarks.first.locality} - ${placemarks.first.country}';
    } catch (e) {
      print(e);
    }
    DateTime date = DateTime.now();

    Coordinates coordinates =
        Coordinates(location.latitude, location.longitude);
    CalculationParameters params = await getPrayerCalculationParam();

    PrayerTimes prayerTimes = PrayerTimes(coordinates, date, params);
    return Future.value(prayerTimes);
  }

  Future setPrayerCalculationParam(bool isShafi) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(kIsShafiKey, isShafi);
    _prayerTimes = await getPrayerTime();
    setWeeklyPrayerTime();
    notifyListeners();
    return;
  }

  Future<CalculationParameters> getPrayerCalculationParam() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    CalculationParameters params = CalculationMethod.MuslimWorldLeague();
    bool isShafi = prefs.getBool(kIsShafiKey) ?? true;

    params.madhab = isShafi ? Madhab.Shafi : Madhab.Hanafi;

    return params;
  }

  void setWeeklyPrayerTime() async {
    // check if the user cancel all prayer notificaiton from settings page
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isActive = prefs.getBool(isPrayerNotificationActiveKey) ?? true;
    if (!isActive) return;

    Box prayerNotificationBox =
        Hive.box<PrayerNotification>(kNotificationBoxName);

    // if (prayerNotificationBox.isOpen && prayerNotificationBox.isNotEmpty) {
    //   // check to see if the today date is already schadule
    //   PrayerNotification? foundDate = prayerNotificationBox.values.first;
    //   if (foundDate != null &&
    //       foundDate.day == DateFormat.EEEE('ar_Dz').format(DateTime.now())) {
    //     return;
    //   }
    // }

    prayerNotificationBox.clear();

    List<PrayerNotification> weeklyPrayer = [];
    final LocationData location = await getLocation();
    Coordinates coordinates =
        Coordinates(location.latitude, location.longitude);

    for (int i = 0; i <= 1; i++) {
      DateTime day = DateTime.now().add(Duration(days: i));
      CalculationParameters params = await getPrayerCalculationParam();
      PrayerTimes prayerTime = PrayerTimes(coordinates, day, params);

      if (prefs.getBool(isFajerNotificationActiveKey) ?? true) {
        weeklyPrayer.add(buildNotificationModel(
            'صلاة الفجر', prayerTime.fajr!, 'fajer_time'));
      }
      if (prefs.getBool(isDuharNotificationActiveKey) ?? true) {
        weeklyPrayer.add(buildNotificationModel(
            'صلاة الظهر', prayerTime.dhuhr!, 'duhar_time'));
      }
      if (prefs.getBool(isAsrNotificationActiveKey) ?? true) {
        weeklyPrayer.add(
            buildNotificationModel('صلاة العصر', prayerTime.asr!, 'asr_time'));
      }
      if (prefs.getBool(isMagrbNotificationActiveKey) ?? true) {
        weeklyPrayer.add(buildNotificationModel(
            'صلاة المغرب', prayerTime.maghrib!, 'magrb_time'));
      }
      if (prefs.getBool(isIshaNotificationActiveKey) ?? true) {
        weeklyPrayer.add(buildNotificationModel(
            'صلاة العشاء', prayerTime.isha!, 'isha_time'));
      }
    }
    prayerNotificationBox.addAll(weeklyPrayer);
    generateWeekPrayerNotification(weeklyPrayer);
  }

  PrayerNotification buildNotificationModel(
      String name, DateTime prayerTime, String key) {
    var rng = Random();

    return PrayerNotification(
        id: createUniqueId(prayerTime) + rng.nextInt(1000),
        salahName: name,
        salahTime: convertTimeToString(prayerTime),
        day: DateFormat.EEEE('ar_Dz').format(prayerTime),
        date: prayerTime,
        channelKey: key);
  }

  String convertTimeToString(DateTime? dateTime) {
    return DateFormat.jms('ar_Dz').format(dateTime!.toLocal()).toString();
  }
}
