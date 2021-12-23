import 'package:dr_social/controllers/user_controller.dart';
import 'package:dr_social/views/main_layout.dart';
import 'package:dr_social/views/pages/marriage/marriage_page.dart';
import 'package:dr_social/views/pages/register/login_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

int daysBetween(DateTime from, DateTime to) {
  from = DateTime(from.year, from.month, from.day);
  to = DateTime(to.year, to.month, to.day);
  return (to.difference(from).inHours / 24).round();
}

void gotToMarriagePage(BuildContext context) {
  if (context.read<UserController>().user == null) {
    Navigator.of(context).pushNamed(LoginPage.routeName);
  } else {
    Navigator.of(context).pushNamed(MarriagePage.routeName);
  }
}

int createUniqueId(DateTime dateTime) {
  return dateTime.millisecondsSinceEpoch.remainder(100000);
}

calculateAge(DateTime birthDate) {
  DateTime currentDate = DateTime.now();
  int age = currentDate.year - birthDate.year;
  int month1 = currentDate.month;
  int month2 = birthDate.month;
  if (month2 > month1) {
    age--;
  } else if (month1 == month2) {
    int day1 = currentDate.day;
    int day2 = birthDate.day;
    if (day2 > day1) {
      age--;
    }
  }
  return age;
}

void selectPage(int index, BuildContext context) {
  Navigator.of(context).pushNamed(MainLayout.routeName, arguments: index);
}
