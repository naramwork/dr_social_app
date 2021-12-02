import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class ThemeWidget extends StatelessWidget {
  final AdaptiveThemeBuilder builder;
  final AdaptiveThemeMode? savedThemeMode;
  ThemeWidget({
    Key? key,
    required this.builder,
    this.savedThemeMode,
  }) : super(key: key);

  /*
  * primaryColor : bottomNavbar - appBar
  * primaryColorDark : menuItem(not_active)
  * primaryColorLight : menuItem(active)
  * bodyText1 : color: black87 , menuTitle
  * headline2 : color: grey , menuItem(not_active)
  * subtitle2 : color: blue.shade100 menuItem(active) - HomeScreen(smallText)
  * */

  final ThemeData lightTheme = ThemeData(
    primaryColor: Colors.white,
    bottomAppBarColor: Colors.black54,
    canvasColor: Colors.white,
    fontFamily: 'Tajawal',
    textTheme: TextTheme(
      headline2: TextStyle(
          //menu Item text style
          color: Colors.grey,
          fontSize: 15.sp),
    ),
  );

  final ThemeData darkTheme = ThemeData(
    primaryColor: const Color(0xFF184B6C),
    primaryColorDark: Color(0xFF043453),
    bottomAppBarColor: Colors.white,
    canvasColor: Color.fromARGB(255, 0, 10, 22),
    fontFamily: 'Tajawal',
    textTheme: TextTheme(
      headline2: TextStyle(
          //menu Item text style
          color: Colors.grey,
          fontSize: 15.sp),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return AdaptiveTheme(
      light: lightTheme,
      dark: darkTheme,
      initial: savedThemeMode ?? AdaptiveThemeMode.light,
      builder: builder,
    );
  }
}
