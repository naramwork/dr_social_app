import 'package:dr_social/app/themes/color_const.dart';
import 'package:dr_social/controllers/prayer_time_controller.dart';
import 'package:dr_social/models/arabic_date.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class MainHomeCard extends StatelessWidget {
  final double rad = 60.0;
  const MainHomeCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Card(
          elevation: 6,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(rad),
          ),
          child: Container(
            padding: EdgeInsets.only(top: 1.5.h),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(rad),
              color: isDarkMode ? Color(0xff366c85) : Color(0xff72A0BF),
            ),
            child: Container(
              padding: EdgeInsets.only(top: 1.5.h),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(rad),
                color: isDarkMode ? Color(0xff467f9e) : Color(0xff538CB2),
              ),
              child: Container(
                height: 26.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(rad),
                  image: const DecorationImage(
                    image: AssetImage('assets/images/mosque.jpg'),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Stack(
                  children: [
                    Container(
                      height: 26.h,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(rad),
                          color: ColorConst.darkTransparent),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(5.w, 3.h, 5.w, 3.h),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              ImageIcon(
                                const AssetImage('assets/images/calendar.png'),
                                color: Colors.white,
                                size: 7.w,
                              ),
                              SizedBox(
                                width: 5.w,
                              ),
                              DateContainer(
                                arabicDate: context
                                    .watch<PrayerTimeController>()
                                    .arabicDate,
                              ),
                            ],
                          ),
                          const Spacer(),
                          Align(
                            alignment: Alignment.bottomRight,
                            child: FittedBox(
                              fit: BoxFit.scaleDown,
                              child: Text(
                                'الموقع الحالي',
                                style: TextStyle(
                                    //textStyle of the subtitle in the homeScreen
                                    color: Colors.blue.shade100,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 15.0.sp),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 0.5.h,
                          ),
                          Align(
                            alignment: Alignment.bottomRight,
                            child: SizedBox(
                              width: 40.w,
                              child: FittedBox(
                                fit: BoxFit.scaleDown,
                                alignment: Alignment.centerRight,
                                child: Text(
                                  ' ' +
                                      context
                                          .watch<PrayerTimeController>()
                                          .locationName,
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                      //textStyle of the heading in the homeScreen
                                      color: Colors.white,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 16.0.sp),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        Positioned(
          bottom: -5.h,
          left: 7.w,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(50.0),
            child: Image.asset(
              'assets/images/location.jpg',
              fit: BoxFit.cover,
              width: 33.w,
              height: 16.h,
            ),
          ),
        ),
      ],
    );
  }
}

class DateContainer extends StatelessWidget {
  final ArabicDate arabicDate;
  const DateContainer({
    Key? key,
    required this.arabicDate,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String date =
        '${arabicDate.dayName} ${arabicDate.day} ${arabicDate.monthName} - ${arabicDate.year} ه ';
    return Flexible(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              date,
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                  fontSize: 16.0.sp),
            ),
          ),
          SizedBox(
            height: 0.5.h,
          ),
          FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              arabicDate.gregorianDate + ' م',
              style: TextStyle(
                  //textStyle of the subtitle in the homeScreen
                  color: Colors.blue.shade100,
                  fontWeight: FontWeight.w500,
                  fontSize: 15.0.sp),
            ),
          ),
        ],
      ),
    );
  }
}
