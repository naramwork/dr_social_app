import 'package:dots_indicator/dots_indicator.dart';
import 'package:dr_social/controllers/color_mode.dart';
import 'package:dr_social/views/components/page_name_container.dart';
import 'package:dr_social/views/pages/sign_up_pages/sign_up_page_one.dart';
import 'package:dr_social/views/pages/sign_up_pages/sign_up_page_two.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class SignUpPage extends StatelessWidget {
  static const routeName = '/sign_up';

  const SignUpPage({Key? key}) : super(key: key);

  void selectPage(int index, BuildContext context) {
    Navigator.of(context).pushNamed('/', arguments: index);
  }

  @override
  Widget build(BuildContext context) {
    ScrollController _scrollController = ScrollController(
      initialScrollOffset: 0.0,
      keepScrollOffset: true,
    );
    return Scaffold(
      body: NestedScrollView(
        controller: _scrollController,
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            PageNameContainer(
              pageTitle: 'تسجيل حساب',
              minHeight: 15.0.h,
              maxHeight: 25.0.h,
              bottomBorderRad: const Radius.elliptical(100, 40),
              backgroundImageUrl: 'assets/images/mosque.jpg',
            ),
          ];
        },
        body: SignUpPageView(
          scrollController: _scrollController,
          resetScroll: () {
            _scrollController.animateTo(0.0,
                duration: const Duration(milliseconds: 500),
                curve: Curves.easeIn);
          },
        ),
      ),
    );
  }
}

class SignUpPageView extends StatefulWidget {
  final Function resetScroll;
  final ScrollController scrollController;

  const SignUpPageView(
      {Key? key, required this.resetScroll, required this.scrollController})
      : super(key: key);

  @override
  _SignUpPageViewState createState() => _SignUpPageViewState();
}

class _SignUpPageViewState extends State<SignUpPageView> {
  final PageController controller = PageController(initialPage: 0);
  double currentPage = 0.0;
  Map<String, String> user = {};

  void nextPage(Map<String, String> userInfo, int index) {
    if (userInfo.isNotEmpty) {
      user.addAll(userInfo);
    }

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
            onPageChanged: (index) {
              widget.resetScroll();
            },
            children: [
              SignUpPageOne(
                nextPage: nextPage,
                previousPage: previousPage,
                scrollController: widget.scrollController,
              ),
              SignUpPageTwo(
                nextPage: nextPage,
                previousPage: previousPage,
              ),
            ],
          ),
        ),
        DotsIndicator(
          dotsCount: 2,
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
