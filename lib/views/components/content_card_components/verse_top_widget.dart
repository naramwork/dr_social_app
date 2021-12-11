import 'package:dr_social/app/themes/color_const.dart';

import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class VerseTopWidget extends StatelessWidget {
  final String surah;
  final String part;

  const VerseTopWidget({Key? key, required this.surah, required this.part})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      height: 6.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        gradient: ColorConst.topCardWidgetGradient,
      ),
      child: Text(
        '${surah}: ${part.replaceFirst('الجزء', '')}',
        style: const TextStyle(
            color: Colors.white, fontSize: 12, fontWeight: FontWeight.w500),
      ),
    );
  }
}
