import 'package:dots_indicator/dots_indicator.dart';
import 'package:dr_social/app/themes/color_const.dart';
import 'package:dr_social/views/page_name_container.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class TestPage extends StatefulWidget {
  static const routeName = '/test_up';

  @override
  State<TestPage> createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  final PageController controller = PageController(initialPage: 0);

  double currentPage = 0.0;

  final List<Widget> pages = [];

  void changPage(double position) {
    controller.animateToPage(
      position.toInt(),
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeIn,
    );
    currentPage = position;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            PageNameContainer(
              pageTitle: '(مواعيد الصلاة)',
              minHeight: 15.0.h,
              maxHeight: 25.0.h,
              bottomBorderRad: const Radius.elliptical(100, 40),
              backgroundImageUrl: 'assets/images/mosque.jpg',
            ),
          ];
        },
        body: Column(
          children: [
            Expanded(
              child: PageView(
                  scrollDirection: Axis.horizontal,
                  controller: controller,
                  children: pages),
            ),
            SizedBox(
              height: 2.h,
            ),
            DotsIndicator(
              dotsCount: pages.length,
              position: currentPage,
              decorator: DotsDecorator(
                size: Size(11.0.w, 10),
                activeSize: Size(11.0.w, 10),
                color: ColorConst.dotColor,
                activeColor: ColorConst.dotActiveColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.0),
                ),
                activeShape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.0),
                  side: BorderSide(color: ColorConst.dotColor, width: 0.2),
                ),
              ),
              onTap: changPage,
            ),
          ],
        ),
      ),
    );
  }
}
