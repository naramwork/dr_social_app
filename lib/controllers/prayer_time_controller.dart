import 'package:adhan_dart/adhan_dart.dart';
import 'package:dr_social/models/arabic_date.dart';
import 'package:flutter/foundation.dart';
import 'package:geocoding/geocoding.dart' as geo;
import 'package:hijri/hijri_calendar.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:location/location.dart';

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
    DateTime? azanTime = _prayerTimes.timeForPrayer(_prayerTimes.nextPrayer());
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

    return timeRemaining;
  }

  String getArabicAzanName(String prayer) {
    if (prayer == Prayer.Fajr) {
      return 'فجر';
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
      return 'قبل العشاء';
    } else if (prayer == Prayer.FajrAfter) {
      return 'بعد الفجر';
    } else {
      return '';
    }
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
    } catch (e) {}
    DateTime date = DateTime.now();

    Coordinates coordinates =
        Coordinates(location.latitude, location.longitude);
    CalculationParameters params = CalculationMethod.MuslimWorldLeague();
    params.madhab = Madhab.Shafi;
    PrayerTimes prayerTimes = PrayerTimes(coordinates, date, params);

    return Future.value(prayerTimes);
  }
}
