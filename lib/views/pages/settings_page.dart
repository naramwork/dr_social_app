import 'package:dr_social/app/helper_files/functions.dart';
import 'package:dr_social/app/helper_files/snack_bar.dart';
import 'package:dr_social/controllers/color_mode.dart';
import 'package:dr_social/controllers/user_controller.dart';
import 'package:dr_social/views/components/layout/custom_bottom_app_bar.dart';
import 'package:dr_social/views/components/layout/fap.dart';
import 'package:dr_social/views/components/register/rounded_text_field.dart';
import 'package:dr_social/views/components/rounded_button_widget.dart';
import 'package:dr_social/views/components/static_page_name_container.dart';
import 'package:dr_social/views/main_layout.dart';
import 'package:dr_social/views/pages/register/register_dialog.dart';
import 'package:dr_social/views/pages/register/sign_up_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class SettingsPage extends StatelessWidget {
  static String routeName = 'login_page';
  const SettingsPage({Key? key}) : super(key: key);

  void selectPage(int index, BuildContext context) {
    Navigator.of(context).pushNamed(MainLayout.routeName, arguments: index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 10.h),
        child: Column(children: [
          Padding(
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
                      'الإعدادت   ',
                      style: TextStyle(
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
          ),
          Container(
            padding: EdgeInsets.only(left: 5.w),
          ),
        ]),
      ),
      floatingActionButton: FAP(
        onPressed: () {
          gotToMarriagePage(context);
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: CustomBottomAppBar(
        selectedIndex: 0,
        selectPage: selectPage,
      ),
    );
  }
}
