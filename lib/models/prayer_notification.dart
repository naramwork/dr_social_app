class PrayerNotification {
  final int id;
  final String salahName;
  final String salahTime;
  final String day;
  final DateTime date;
  final String channelKey;

  PrayerNotification({
    required this.id,
    required this.salahName,
    required this.salahTime,
    required this.day,
    required this.date,
    required this.channelKey,
  });
}
