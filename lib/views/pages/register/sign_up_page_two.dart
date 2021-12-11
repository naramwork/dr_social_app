import 'package:country_calling_code_picker/country.dart';
import 'package:dr_social/controllers/user_controller.dart';
import 'package:dr_social/views/components/register/next_button.dart';
import 'package:dr_social/views/components/register/phone_text_field.dart';
import 'package:dr_social/views/components/register/previouse_button.dart';
import 'package:dr_social/views/components/rounded_button_widget.dart';
import 'package:dr_social/views/components/register/rounded_text_field.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class SignUpPageTwo extends StatelessWidget {
  final Function nextPage;
  final Function previousPage;
  SignUpPageTwo({Key? key, required this.nextPage, required this.previousPage})
      : super(key: key);

  final _formKey = GlobalKey<FormState>();
  final ScrollController scrollController = ScrollController(
    initialScrollOffset: 0.0,
    keepScrollOffset: true,
  );
  final Map<String, String> pageTowUserInfo = {};
  final Map phoneMap = {};

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
        previousPage();
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
                PhoneTextField(
                  hintText: 'رقم الجوال',
                  icon: Icons.phone_enabled_outlined,
                  isRequired: true,
                  initValue: pageTowUserInfo['phoneNumber'] != null
                      ? pageTowUserInfo['phoneNumber']!.substring(4)
                      : '',
                  onSave: (value) {
                    phoneMap.addAll(value);
                  },
                ),
                RoundedTextField(
                  hintText: 'الجنسية',
                  icon: Icons.map_outlined,
                  isRequired: true,
                  initValue: pageTowUserInfo['nationality'],
                  onSave: (value) {
                    pageTowUserInfo['nationality'] = value;
                  },
                  suffixIcon: Icons.fiber_manual_record,
                ),
                RoundedTextField(
                  hintText: 'المدينة',
                  icon: Icons.home_work_outlined,
                  isRequired: true,
                  initValue: pageTowUserInfo['city'],
                  onSave: (value) {
                    pageTowUserInfo['city'] = value;
                  },
                  suffixIcon: Icons.fiber_manual_record,
                ),
                RoundedTextField(
                  hintText: 'مكان الإقامة',
                  imageIcon: 'assets/images/signpost.png',
                  isRequired: true,
                  initValue: pageTowUserInfo['address'],
                  onSave: (value) {
                    pageTowUserInfo['address'] = value;
                  },
                  suffixIcon: Icons.fiber_manual_record,
                ),
                RoundedTextField(
                  hintText: 'العمل',
                  icon: Icons.work_outline,
                  isRequired: true,
                  isLastInfoucs: true,
                  initValue: pageTowUserInfo['job'],
                  onSave: (value) {
                    pageTowUserInfo['job'] = value;
                  },
                  suffixIcon: Icons.fiber_manual_record,
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
    //print('phone: $phone');

    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      if (phoneMap.isEmpty) {
        showSnackBar('تأكد من ادخال رقم هاتف صحيح', context);
      } else {
        bool phoneSaved = await context
            .read<UserController>()
            .addAndValidatePhoneNumber(phoneMap['value'], phoneMap['country']);
        if (!phoneSaved || phoneMap.isEmpty) {
          showSnackBar('تأكد من ادخال رقم هاتف صحيح', context);
        } else {
          nextPage(); // index of the page
          context.read<UserController>().addToUserInfo(pageTowUserInfo);
        }
      }
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
