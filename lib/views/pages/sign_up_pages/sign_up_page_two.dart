import 'package:dr_social/views/components/rounded_button_widget.dart';
import 'package:dr_social/views/components/rounded_text_field.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class SignUpPageTwo extends StatelessWidget {
  final Function nextPage;
  final Function previousPage;
  const SignUpPageTwo(
      {Key? key, required this.nextPage, required this.previousPage})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 5.0.w),
        child: Column(
          children: [
            RoundedTextField(
                hintText: 'اسم المستخدم',
                icon: Icons.person_outline,
                onSave: (save) {
                  print(save);
                }),
            RoundedTextField(
                hintText: 'رقم الجوال',
                icon: Icons.phone_enabled_outlined,
                onSave: (save) {
                  print(save);
                }),
            RoundedTextField(
                hintText: 'كلمة المرور',
                icon: Icons.lock_outlined,
                onSave: (save) {
                  print(save);
                }),
            RoundedTextField(
                hintText: 'تأكيد كلمة المرور',
                icon: Icons.lock_outlined,
                onSave: (save) {
                  print(save);
                }),
            RoundedTextField(
                hintText: 'الموقع',
                icon: Icons.room_outlined,
                onSave: (save) {
                  print(save);
                }),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                RoundedButtonWidget(
                    label: Text('السابق'),
                    width: 10.w,
                    onpressed: previousPage),
                RoundedButtonWidget(
                    label: Text('التالي'), width: 10.w, onpressed: nextPage),
              ],
            ),
            SizedBox(
              height: 2.h,
            )
          ],
        ),
      ),
    );
  }
}
