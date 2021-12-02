import 'package:flutter/material.dart';

bool isDarkMode = false;

class ColorConst {
  // static Color secondaryColor = Color.fromRGBO(4, 40, 82, 0.8);
  // static Color lightBlue = Colors.blue.shade300;
  static Color extraLightBlue = Colors.blue.shade200;
  static Color darkTransparent = Color.fromRGBO(44, 102, 147, 0.6);
  //
  static Color dotColor = isDarkMode
      ? Color.fromRGBO(200, 230, 241, 1)
      : Color.fromRGBO(200, 230, 241, 1);
  //
  static Color dotActiveColor = isDarkMode
      ? Color.fromRGBO(4, 50, 82, 0.8)
      : Color.fromRGBO(4, 50, 82, 0.8);
  //
  static Color textInputIconColor = isDarkMode
      ? Color.fromRGBO(200, 230, 241, 0.6)
      : Color.fromARGB(255, 0, 100, 150);
  static Color textInputHintColor =
      isDarkMode ? Color.fromRGBO(200, 230, 241, 0.6) : Colors.grey.shade300;

  static Color lightBlue = Colors.blue.shade300;
  static List<Color> gradientColors = [
    Colors.blue.shade600,
    Colors.blue.shade500,
    Colors.blue.shade300,
    Colors.blue.shade100,
  ];
  //
  // static List<Color> buttonGradientColors = [
  //   Colors.blue.shade500,
  //   Colors.blue.shade400,
  //   Colors.blue.shade300,
  //   Colors.blue.shade300,
  //   Colors.blue.shade400,
  //   Colors.blue.shade500,
  // ];
}
