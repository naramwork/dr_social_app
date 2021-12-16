import 'package:dr_social/controllers/color_mode.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class BottomWidget extends StatelessWidget {
  final String content;
  const BottomWidget({
    Key? key,
    required this.content,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 2.h),
      child: SelectableText(content,
          style: TextStyle(
            height: 1.5,
            color: context.watch<ColorMode>().isDarkMode
                ? Colors.white
                : Colors.black,
            fontSize: 16,
          ),
          textAlign: TextAlign.center),
    );
  }
}
