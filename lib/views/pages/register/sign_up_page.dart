import 'package:dots_indicator/dots_indicator.dart';
import 'package:dr_social/controllers/color_mode.dart';
import 'package:dr_social/controllers/user_controller.dart';

import 'package:dr_social/views/components/static_page_name_container.dart';
import 'package:dr_social/views/pages/register/sign_up_page_four.dart';
import 'package:dr_social/views/pages/register/sign_up_page_one.dart';
import 'package:dr_social/views/pages/register/sign_up_page_three.dart';
import 'package:dr_social/views/pages/register/sign_up_page_two.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class SignUpPage extends StatelessWidget {
  static const routeName = '/sign_up';

  const SignUpPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Column(
            children: [
              StaticPageNameContainer(
                pageTitle: 'تسجيل حساب',
                maxHeight: 25.0.h,
                bottomBorderRad: const Radius.elliptical(100, 40),
                backgroundImageUrl: 'assets/images/mosque.png',
                boxFit: BoxFit.cover,
                imageAlignment: Alignment.center,
              ),
              const Expanded(
                child: SignUpPageView(),
              ),
            ],
          ),
          Positioned(
              top: 6.h,
              right: 6.w,
              child: IconButton(
                icon: const Icon(
                  Icons.close_outlined,
                  size: 35,
                  color: Colors.white,
                ),
                onPressed: () {
                  context.read<UserController>().deleteInfo();

                  Navigator.pop(context);
                },
              )),
        ],
      ),
    );
  }
}

class SignUpPageView extends StatefulWidget {
  const SignUpPageView({Key? key}) : super(key: key);

  @override
  _SignUpPageViewState createState() => _SignUpPageViewState();
}

class _SignUpPageViewState extends State<SignUpPageView> {
  final PageController controller = PageController(initialPage: 0);
  double currentPage = 0.0;
  Map<String, String> user = {};

  void nextPage() {
    controller.animateToPage(
      (currentPage + 1).toInt(),
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeIn,
    );
    currentPage = currentPage + 1;
    setState(() {});
  }

  void previousPage() {
    controller.animateToPage(
      (currentPage - 1).toInt(),
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeIn,
    );
    currentPage = currentPage - 1;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 3.h,
        ),
        Expanded(
          child: PageView(
            physics: const NeverScrollableScrollPhysics(),
            controller: controller,
            children: [
              SignUpPageOne(
                nextPage: nextPage,
                previousPage: previousPage,
              ),
              SignUpPageTwo(
                nextPage: nextPage,
                previousPage: previousPage,
              ),
              SignUpPageThree(
                nextPage: nextPage,
                previousPage: previousPage,
              ),
              SignUpPageFour(
                previousPage: previousPage,
              ),
            ],
          ),
        ),
        DotsIndicator(
          dotsCount: 4,
          position: currentPage,
          decorator: DotsDecorator(
            size: Size(11.0.w, 10),
            activeSize: Size(11.0.w, 10),
            color: context.watch<ColorMode>().dotColor,
            activeColor: context.watch<ColorMode>().dotActiveColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5.0),
            ),
            activeShape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5.0),
              side: BorderSide(
                  color: context.watch<ColorMode>().dotColor, width: 0.2),
            ),
          ),
        ),
        SizedBox(
          height: 4.h,
        ),
      ],
    );
  }
}
