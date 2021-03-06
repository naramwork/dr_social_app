import 'package:dr_social/controllers/color_mode.dart';
import 'package:dr_social/controllers/prayer_time_controller.dart';
import 'package:dr_social/models/arabic_date.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:location/location.dart';
import 'package:map_launcher/map_launcher.dart';
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
              color: context.watch<ColorMode>().isDarkMode
                  ? const Color(0xff366c85)
                  : const Color(0xff72A0BF),
            ),
            child: Container(
              padding: EdgeInsets.only(top: 1.5.h),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(rad),
                color: context.watch<ColorMode>().isDarkMode
                    ? const Color(0xff467f9e)
                    : const Color(0xff538CB2),
              ),
              child: Container(
                height: 26.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(rad),
                  image: const DecorationImage(
                    image: AssetImage('assets/images/mosque.png'),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Stack(
                  children: [
                    Container(
                      height: 26.h,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(rad),
                          color: const Color(0xff538CB2).withOpacity(0.7)),
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
                                '???????????? ????????????',
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
          child: InkWell(
            onTap: () {
              showMapsBottomSheet(context);
              // [AvailableMap { mapName: Google Maps, mapType: google }, ...]
            },
            child: ClipRRect(
              borderRadius: BorderRadius.circular(50.0),
              child: Image.asset(
                context.watch<ColorMode>().isDarkMode
                    ? 'assets/images/map.png'
                    : 'assets/images/map.png',
                fit: BoxFit.cover,
                width: 33.w,
                height: 16.h,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

showMapsBottomSheet(BuildContext context) async {
  final LocationData location =
      await context.read<PrayerTimeController>().getLocation();
  final availableMaps = await MapLauncher.installedMaps;
  showModalBottomSheet(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
      ),
      context: context,
      builder: (context) {
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 4.h),
          child: Wrap(
            children: availableMaps
                .map(
                  (map) => InkWell(
                    onTap: () async {
                      map.showMarker(
                          coords:
                              Coords(location.latitude!, location.longitude!),
                          title: '');
                    },
                    child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            map.icon,
                            width: 15.w,
                            height: 15.w,
                          ),
                          Text(
                            map.mapName,
                            style: const TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w500),
                          ),
                        ]),
                  ),
                )
                .toList(),
          ),
        );
      });
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
        '${arabicDate.dayName} ${arabicDate.day} ${arabicDate.monthName} - ${arabicDate.year} ?? ';
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
              arabicDate.gregorianDate + ' ??',
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
