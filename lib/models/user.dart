import 'package:hive/hive.dart';

part 'user.g.dart';

@HiveType(typeId: 6)
class User {
  @HiveField(0)
  late final String email;
  @HiveField(1)
  late final String name;
  @HiveField(2)
  late final String phoneNumber;
  // late final String password;
  // late final String confirmPassword;
  @HiveField(3)
  late final String gender;
  @HiveField(4)
  late final String nationality;
  @HiveField(5)
  late final String city;
  @HiveField(6)
  late final String address;
  @HiveField(7)
  late final String job;
  @HiveField(8)
  late final DateTime birthDate;
  @HiveField(9)
  late final String civilIdNo;
  @HiveField(10)
  late final String civilIdNoExp;
  @HiveField(11)
  late final int wifeCount;
  @HiveField(12)
  late final int childrenNumber;
  @HiveField(13)
  late final double height;
  @HiveField(14)
  late final double weight;
  @HiveField(15)
  late final String socialStatus;
  @HiveField(16)
  late final String educationalStatus;
  @HiveField(17)
  late final dynamic more;
  @HiveField(18)
  late final bool isBlock;
  @HiveField(19)
  late final String? fcm;
  @HiveField(20)
  late final String token;

  User({
    required this.email,
    required this.name,
    required this.phoneNumber,
    required this.gender,
    required this.nationality,
    required this.city,
    required this.address,
    required this.job,
    required this.birthDate,
    required this.civilIdNo,
    required this.civilIdNoExp,
    required this.wifeCount,
    required this.childrenNumber,
    required this.height,
    required this.weight,
    required this.socialStatus,
    required this.educationalStatus,
    required this.more,
    required this.isBlock,
    required this.token,
    this.fcm,
  });

  factory User.fromJson(String email, String name, Map<String, dynamic> profile,
          String token, bool isBlocked) =>
      User(
          email: email,
          name: name,
          phoneNumber: profile['phone_number'],
          gender: profile['gender'],
          nationality: profile['nationality'],
          city: profile['city'],
          address: profile['address'],
          job: profile['job'],
          birthDate: DateTime.parse(profile['birthdate']),
          civilIdNo: profile['civil_id_no'],
          civilIdNoExp: profile['civil_id_no_exp'],
          wifeCount: int.parse(profile['wife_count']),
          childrenNumber: int.parse(profile['children_number']),
          height: double.parse(profile['height']),
          weight: double.parse(profile['weight']),
          socialStatus: profile['social_status'],
          educationalStatus: profile['educational_Status'],
          more: profile['more'],
          isBlock: isBlocked,
          token: token);
}
