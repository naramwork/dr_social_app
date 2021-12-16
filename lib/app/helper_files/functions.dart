import 'package:dr_social/controllers/user_controller.dart';
import 'package:dr_social/views/pages/marriage_page.dart';
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
