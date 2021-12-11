import 'package:dr_social/views/components/static_page_name_container.dart';
import 'package:dr_social/views/pages/register/sign_up_page.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class TestPage extends StatelessWidget {
  static String routeName = '/test_page';
  const TestPage({Key? key}) : super(key: key);

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
                imageAlignment: Alignment.bottomRight,
                bottomBorderRad: const Radius.elliptical(100, 40),
                backgroundImageUrl: 'assets/images/mosque.png',
              ),
              Expanded(
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
                  Navigator.pop(context);
                },
              )),
        ],
      ),
    );
  }
}
