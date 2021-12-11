import 'package:dr_social/controllers/user_controller.dart';
import 'package:dr_social/views/components/register/date_text_field.dart';
import 'package:dr_social/views/components/register/next_button.dart';

import 'package:dr_social/views/components/register/previouse_button.dart';

import 'package:dr_social/views/components/register/rounded_text_field.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class SignUpPageThree extends StatelessWidget {
  final Function nextPage;
  final Function previousPage;
  SignUpPageThree(
      {Key? key, required this.nextPage, required this.previousPage})
      : super(key: key);

  final _formKey = GlobalKey<FormState>();
  final ScrollController scrollController = ScrollController(
    initialScrollOffset: 0.0,
    keepScrollOffset: true,
  );
  final Map<String, String> pageThreeUserInfo = {
    'gender': 'm',
  };

  void setUserInfoMap(BuildContext context) {
    var userInfo = context.watch<UserController>().usetInfo;
    if (userInfo.isNotEmpty) {
      pageThreeUserInfo.addAll(userInfo);
    }
  }

  @override
  Widget build(BuildContext context) {
    setUserInfoMap(context);
    return WillPopScope(
      onWillPop: () {
        previousPage();
        return Future.value(false);
      },
      child: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 5.0.w),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                DateTextField(
                  hintText: 'تاريخ الميلاد',
                  icon: Icons.calendar_today_outlined,
                  isRequired: true,
                  initValue: pageThreeUserInfo['birthDate'],
                  onSave: (value) {
                    pageThreeUserInfo['birthDate'] = value;
                  },
                  suffixIcon: Icons.fiber_manual_record,
                ),
                RoundedTextField(
                  hintText: pageThreeUserInfo['gender'] == 'm'
                      ? 'رقم البطاقة المدنية'
                      : 'البطاقة المدنية لولي الزوجة',
                  icon: Icons.badge_outlined,
                  isRequired: true,
                  inputType: TextInputType.number,
                  initValue: pageThreeUserInfo['civilIdNo'],
                  onSave: (value) {
                    pageThreeUserInfo['civilIdNo'] = value;
                  },
                  suffixIcon: Icons.fiber_manual_record,
                ),
                DateTextField(
                  hintText: 'تاريخ انتهاء البطاقة المدنية',
                  icon: Icons.badge_outlined,
                  isRequired: true,
                  initValue: pageThreeUserInfo['civilIdNoExp'],
                  onSave: (value) {
                    pageThreeUserInfo['civilIdNoExp'] = value;
                  },
                  suffixIcon: Icons.fiber_manual_record,
                ),
                pageThreeUserInfo['gender'] == 'm'
                    ? RoundedTextField(
                        hintText: 'عدد الزوجات',
                        inputType: TextInputType.number,
                        imageIcon: 'assets/images/couple.png',
                        initValue: pageThreeUserInfo['wifeCount'],
                        onSave: (value) {
                          pageThreeUserInfo['wifeCount'] = value;
                        },
                      )
                    : Container(),
                RoundedTextField(
                  hintText: 'عدد الأولاد',
                  inputType: TextInputType.number,
                  imageIcon: 'assets/images/children.png',
                  initValue: pageThreeUserInfo['childrenNumber'],
                  onSave: (value) {
                    pageThreeUserInfo['childrenNumber'] = value;
                  },
                  isLastInfoucs: true,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    PreviousButton(width: 10.w, onpressed: previousPage),
                    NextButton(
                        width: 10.w,
                        onpressed: () async {
                          saveForm(context);
                        }),
                  ],
                ),
                SizedBox(
                  height: 2.h,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void saveForm(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      nextPage(); // index of the page
      context.read<UserController>().addToUserInfo(pageThreeUserInfo);
    } else {
      scrollController.animateTo(0.0,
          duration: const Duration(milliseconds: 500), curve: Curves.easeIn);
    }
  }

  void showSnackBar(String text, BuildContext context) {
    SnackBar snackBar = SnackBar(
      content: Text(
        text,
        style: const TextStyle(
          fontFamily: 'Tajawl',
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
      ),
      behavior: SnackBarBehavior.floating,
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
