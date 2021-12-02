import 'package:dr_social/app/helper_files/sliver_app_bar_delegate.dart';
import 'package:dr_social/app/themes/color_const.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class PageNameContainer extends StatelessWidget {
  final double minHeight;
  final double maxHeight;
  final Radius bottomBorderRad;
  final String pageTitle;
  final String backgroundImageUrl;

  const PageNameContainer({
    Key? key,
    required this.minHeight,
    required this.maxHeight,
    required this.bottomBorderRad,
    required this.pageTitle,
    required this.backgroundImageUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverPersistentHeader(
        pinned: true,
        delegate: SliverAppBarDelegate(
          minHeight: 15.0.h,
          maxHeight: 25.0.h,
          child: Container(
            height: maxHeight,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.vertical(
                bottom: bottomBorderRad,
              ),
              image: DecorationImage(
                image: AssetImage(backgroundImageUrl),
                fit: BoxFit.cover,
              ),
            ),
            child: Container(
              padding: EdgeInsets.only(bottom: 3.h),
              height: maxHeight,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.vertical(
                    bottom: bottomBorderRad,
                  ),
                  color: ColorConst.darkTransparent),
              alignment: Alignment.bottomCenter,
              child: Text(
                pageTitle,
                style: TextStyle(
                    fontFamily: 'Amiri',
                    color: Colors.white,
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w400),
              ),
            ),
          ),
        ));
  }
}
