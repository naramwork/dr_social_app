import 'dart:convert';
import 'dart:io';

import 'package:dr_social/app/helper_files/app_const.dart';
import 'package:dr_social/models/user.dart';
import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';
import 'package:phone_number/phone_number.dart';
import 'package:country_calling_code_picker/picker.dart';
import 'package:http/http.dart' as http;

class UserController extends ChangeNotifier {
  final Map<String, String> _userInfo = {};
  User? _user;

  Map<String, String> get usetInfo => _userInfo;

  User? get user => _user;

  void setUserGender(String gender) {
    _userInfo.update(
      'gender',
      (value) => gender,
      ifAbsent: () => gender,
    );
  }

  void addToUserInfo(Map<String, String> pageMap) {
    for (var element in pageMap.entries) {
      _userInfo.update(
        element.key,
        (value) => element.value,
        ifAbsent: () => element.value,
      );
    }

    notifyListeners();
  }

  Future<bool> registerUser() async {
    var url = Uri.parse(kGetRegisterUrl);
    final response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'type': 'user',
        'name': _userInfo['name'] ?? '',
        'email': _userInfo['email'] ?? '',
        'phone_number': _userInfo['phoneNumber'] ?? '',
        'password': _userInfo['password'] ?? '',
        'password_confirmation': _userInfo['confirmPassword'] ?? '',
        'job': _userInfo['job'] ?? '',
        'gender': _userInfo['gender'] ?? '',
        'children_number': _userInfo['childrenNumber']!.isNotEmpty
            ? _userInfo['childrenNumber']
            : 0,
        'educational_Status': _userInfo['educationalStatus'] ?? '',
        'social_status': _userInfo['socialStatus']!.isNotEmpty
            ? _userInfo['socialStatus']
            : 'غير محدد',
        'city': _userInfo['city'] ?? '',
        'nationality': _userInfo['nationality'] ?? '',
        'civil_id_no': _userInfo['civilIdNo'] ?? '',
        'civil_id_no_exp': _userInfo['civilIdNoExp'] ?? '',
        'fire_base_token': 'later',
        'birthdate': _userInfo['birthDate'] ?? '',
        'address': _userInfo['address'] ?? '',
        'height': _userInfo['height']!.isNotEmpty
            ? _userInfo['height']!.isNotEmpty
            : 0,
        'weight': _userInfo['weight']!.isNotEmpty
            ? _userInfo['weight']!.isNotEmpty
            : 0,
        'wife_count': (_userInfo['wifeCount'] != null &&
                _userInfo['wifeCount']!.isNotEmpty)
            ? _userInfo['wifeCount']
            : 0,
        'more': jsonEncode({'late': 'later'}),
      }),
    );

    if (response.statusCode == 201) {
      return loginUser(_userInfo['email'] ?? '', _userInfo['password'] ?? '');
    } else {
      return false;
    }
  }

  Future<bool> logoutUser(String email, String token) async {
    var url = Uri.parse(kGetLogoutUrl);
    final logoutResponse = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode(<String, dynamic>{
        'email': email,
      }),
    );
    if (logoutResponse.body == 'done') {
      Box userBox = Hive.box<User>(kUserBoxName);
      userBox.clear();
      _user = null;
      notifyListeners();
      return true;
    } else {
      return false;
    }
  }

  void getLogedinUser() {
    Box userBox = Hive.box<User>(kUserBoxName);
    if (userBox.values.isNotEmpty) {
      _user = userBox.values.first;
      notifyListeners();
    }
  }

  Future<bool> loginUser(String email, String pssword) async {
    var url = Uri.parse(kGetLoginUrl);
    final loginResponse = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'email': email,
        'password': pssword,
        'device_name': 'mobile'
      }),
    );

    final jsonExtractedList = json.decode(loginResponse.body);

    if (jsonExtractedList['errors'] == null) {
      String token = jsonExtractedList['toke'];
      var userJson = jsonExtractedList['user'];
      String email = userJson['email'];
      String name = userJson['name'];
      var profile = userJson['profile'];
      User user = User.fromJson(email, name, profile, token, true);
      Box userBox = Hive.box<User>(kUserBoxName);
      await userBox.add(user);
      _user = user;
      notifyListeners();
      return true;
    } else {
      return false;
    }
  }

  void deleteInfo() {
    _userInfo.clear();
    notifyListeners();
  }

  Future<bool> addAndValidatePhoneNumber(String phone, Country? country) async {
    PhoneNumberUtil plugin = PhoneNumberUtil();
    RegionInfo region = RegionInfo(
        name: country!.name,
        prefix: int.parse(country.callingCode),
        code: country.countryCode);
    bool isValid = await plugin.validate(phone, region.code);
    if (isValid) {
      String phoneNumber = country.callingCode + phone;
      _userInfo.update(
        'phoneNumber',
        (value) => phoneNumber,
        ifAbsent: () => phoneNumber,
      );
      return Future.value(true);
    } else {
      return Future.value(false);
    }
  }
}
