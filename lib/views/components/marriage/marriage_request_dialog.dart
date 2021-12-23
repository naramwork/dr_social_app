import 'package:dr_social/app/themes/color_const.dart';
import 'package:dr_social/controllers/color_mode.dart';
import 'package:dr_social/models/message.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../rounded_button_widget.dart';

class MarriageRequestDialog extends StatelessWidget {
  final Message message;
  final Function onTap;
  const MarriageRequestDialog(
      {Key? key, required this.message, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 5.h),
      elevation: 12,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 5.h),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: context.watch<ColorMode>().isDarkMode
              ? ColorConst.darkCardColor
              : Colors.white,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                CircleAvatar(
                  backgroundColor: Colors.grey.shade50,
                  backgroundImage: NetworkImage(message.sender.imageUrl),
                  maxRadius: 15.w,
                ),
                SizedBox(
                  width: 4.w,
                ),
                Expanded(
                  child: Column(
                    children: [
                      Text(
                        message.sender.name,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: context.watch<ColorMode>().isDarkMode
                              ? Colors.white
                              : Colors.black,
                        ),
                      ),
                      SizedBox(
                        height: 1.h,
                      ),
                      TextButton(
                        onPressed: () {},
                        child: Text(
                          'عرض التفاصيل',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: context.watch<ColorMode>().isDarkMode
                                ? Colors.white
                                : Colors.black,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 2.h,
            ),
            Divider(
              color: context.watch<ColorMode>().isDarkMode
                  ? Colors.white
                  : Colors.black,
            ),
            SizedBox(
              height: 2.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                RoundedButtonWidget(
                    label: const Text('قبول'),
                    width: 30.w,
                    onpressed: () {
                      onTap(message, 'قبول');
                    }),
                RoundedButtonWidget(
                    label: const Text('رفض'),
                    width: 30.w,
                    onpressed: () {
                      onTap(message, 'رفض');
                    })
              ],
            )
          ],
        ),
      ),
    );
  }
}
