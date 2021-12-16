import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class NameHeaderCard extends StatelessWidget {
  final String title;
  const NameHeaderCard({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.w),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            gradient: const LinearGradient(
              begin: Alignment.centerRight,
              end: Alignment.centerLeft,
              colors: [
                Color(0xff538CB2),
                Color(0xff538CB2),
                Color(0xff538CB2),
              ],
            )),
        child: Stack(
          children: [
            Container(
              height: 7.h,
              alignment: Alignment.center,
              width: double.infinity,
              child: Text(
                title,
                style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                    fontSize: 18),
                textAlign: TextAlign.center,
              ),
            ),
            Positioned(
              left: 0,
              child: SvgPicture.asset(
                'assets/images/lift.svg',
                fit: BoxFit.fill,
                width: 14.w,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
