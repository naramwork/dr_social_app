import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class PrayerTimeContainer extends StatelessWidget {
  final String salahName;
  final String dateName;

  const PrayerTimeContainer(
      {Key? key, required this.salahName, required this.dateName})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40.w,
      padding: EdgeInsets.fromLTRB(2.w, 3.h, 2.w, 0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        color: Colors.blue.shade300,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(right: 2.w),
            child: Text(
              salahName,
              style: const TextStyle(
                  fontWeight: FontWeight.w500, color: Colors.white),
            ),
          ),
          SizedBox(
            height: 2.h,
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 2),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              color: const Color.fromRGBO(255, 255, 255, 0.6),
            ),
            child: const Text(
              'موعد الاذان',
              style: TextStyle(
                  color: Colors.black87,
                  fontSize: 12,
                  fontWeight: FontWeight.w300),
            ),
          ),
          SizedBox(
            height: 2.h,
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: SizedBox(
              width: 30.w,
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  dateName,
                  style: const TextStyle(
                      fontWeight: FontWeight.w500, color: Colors.white),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
