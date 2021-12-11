import 'package:dr_social/app/helper_files/snack_bar.dart';
import 'package:dr_social/controllers/user_controller.dart';
import 'package:dr_social/views/components/register/next_button.dart';

import 'package:dr_social/views/components/register/previouse_button.dart';

import 'package:dr_social/views/components/register/rounded_text_field.dart';
import 'package:dr_social/views/pages/register/register_dialog.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class SignUpPageFour extends StatefulWidget {
  final Function previousPage;
  SignUpPageFour({Key? key, required this.previousPage}) : super(key: key);

  @override
  State<SignUpPageFour> createState() => _SignUpPageFourState();
}

class _SignUpPageFourState extends State<SignUpPageFour> {
  final _formKey = GlobalKey<FormState>();

  final ScrollController scrollController = ScrollController(
    initialScrollOffset: 0.0,
    keepScrollOffset: true,
  );

  final Map<String, String> pageTowUserInfo = {};

  void setUserInfoMap(BuildContext context) {
    var userInfo = context.watch<UserController>().usetInfo;
    if (userInfo.isNotEmpty) {
      pageTowUserInfo.addAll(userInfo);
    }
  }

  @override
  Widget build(BuildContext context) {
    setUserInfoMap(context);

    return WillPopScope(
      onWillPop: () {
        widget.previousPage();
        return Future.value(false);
      },
      child: SingleChildScrollView(
        controller: scrollController,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 5.0.w),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                RoundedTextField(
                  hintText: 'الطول',
                  icon: Icons.height_outlined,
                  inputType: TextInputType.number,
                  initValue: pageTowUserInfo['height'],
                  onSave: (value) {
                    pageTowUserInfo['height'] = value;
                  },
                ),
                RoundedTextField(
                  hintText: 'الوزن',
                  icon: Icons.monitor_weight_outlined,
                  inputType: TextInputType.number,
                  initValue: pageTowUserInfo['weight'],
                  onSave: (value) {
                    pageTowUserInfo['weight'] = value;
                  },
                ),
                RoundedTextField(
                  hintText: 'الحالة الاجتماعية',
                  icon: Icons.person_outline_outlined,
                  initValue: pageTowUserInfo['socialStatus'],
                  onSave: (value) {
                    pageTowUserInfo['socialStatus'] = value;
                  },
                ),
                RoundedTextField(
                  hintText: 'الحالة التعليمية',
                  icon: Icons.create_outlined,
                  isRequired: true,
                  initValue: pageTowUserInfo['educationalStatus'],
                  onSave: (value) {
                    pageTowUserInfo['educationalStatus'] = value;
                  },
                  isLastInfoucs: true,
                  suffixIcon: Icons.fiber_manual_record,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    PreviousButton(width: 10.w, onpressed: widget.previousPage),
                    NextButton(
                        title: 'تسجيل',
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
    //print('phone: $phone');

    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      context.read<UserController>().addToUserInfo(pageTowUserInfo);

      showDialog(
          context: context,
          builder: (ctx) {
            return RegisterDialog();
          });
      // index of the page
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
