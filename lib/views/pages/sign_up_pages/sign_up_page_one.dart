import 'package:dr_social/app/themes/color_const.dart';
import 'package:dr_social/controllers/color_mode.dart';
import 'package:dr_social/views/components/next_button.dart';
import 'package:dr_social/views/components/phone_text_field.dart';
import 'package:dr_social/views/components/rounded_text_field.dart';
import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class SignUpPageOne extends StatelessWidget {
  final Function nextPage;
  final Function previousPage;
  final ScrollController scrollController;

  SignUpPageOne(
      {Key? key,
      required this.nextPage,
      required this.previousPage,
      required this.scrollController})
      : super(key: key);

  final _formKey = GlobalKey<FormState>();

  void changeGender(String gender) {
    partOne[gender] = gender;
  }

  final Map<String, String> partOne = {
    'gender': 'male',
  };

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 5.0.w),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              RoundedTextField(
                hintText: 'اسم المستخدم',
                icon: Icons.person_outline,
                isRequired: true,
                onSave: (value) {
                  partOne['name'] = value;
                },
              ),
              PhoneTextField(
                hintText: 'رقم الجوال',
                icon: Icons.phone_enabled_outlined,
                isRequired: true,
                onSave: (value) {
                  partOne['phoneNumber'] = value;
                },
              ),
              RoundedTextField(
                hintText: 'كلمة المرور',
                icon: Icons.lock_outlined,
                onSave: (value) {
                  partOne['password'] = value;
                },
                isPassword: true,
                suffixIcon: IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.visibility_off_outlined,
                  ),
                ),
              ),
              RoundedTextField(
                hintText: 'تأكيد كلمة المرور',
                icon: Icons.lock_outlined,
                onSave: (value) {
                  partOne['confirmPassword'] = value;
                },
                isPassword: true,
              ),
              // RoundedTextField(
              //     hintText: 'الموقع',
              //     icon: Icons.room_outlined,
              //     onSave: (save) {
              //       print(save);
              //     }),

              Align(
                alignment: Alignment.centerLeft,
                child: NextButton(
                    width: 10.w,
                    onpressed: () {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();
                        nextPage(partOne, 0);
                      } else {
                        scrollController.animateTo(0.0,
                            duration: const Duration(milliseconds: 500),
                            curve: Curves.easeIn);
                      }
                    }),
              ),
              SizedBox(
                height: 2.h,
              )
            ],
          ),
        ),
      ),
    );
  }
}

class GenderCard extends StatefulWidget {
  final Function changeGender;

  const GenderCard({Key? key, required this.changeGender}) : super(key: key);

  @override
  State<GenderCard> createState() => _GenderCardState();
}

class _GenderCardState extends State<GenderCard> {
  String gender = 'male';
  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.hardEdge,
      elevation: 4,
      color: Theme.of(context).primaryColor,
      margin: const EdgeInsets.symmetric(vertical: 15),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(
              width: 8.w,
            ),
            Center(
              child: Text(
                'الجنس',
                style: TextStyle(
                    color: context.watch<ColorMode>().textInputHintColor,
                    fontSize: 16),
              ),
            ),
            Expanded(
              child: Row(
                children: [
                  Flexible(
                    fit: FlexFit.loose,
                    child: RadioListTile(
                      value: 'male',
                      groupValue: gender,
                      onChanged: (value) {
                        widget.changeGender(value);

                        setState(() {
                          gender = value as String;
                        });
                      },
                      contentPadding: EdgeInsets.symmetric(horizontal: 3.w),
                      title: const FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Text(
                          'ذكر',
                          style: TextStyle(
                              fontWeight: FontWeight.w500, fontSize: 18),
                        ),
                      ),
                    ),
                  ),
                  Flexible(
                    fit: FlexFit.loose,
                    child: RadioListTile(
                      value: 'female',
                      groupValue: gender,
                      onChanged: (value) {
                        setState(() {
                          widget.changeGender(value);
                          gender = value as String;
                        });
                      },
                      contentPadding: EdgeInsets.symmetric(horizontal: 3.w),
                      title: const FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Text(
                          'انثى',
                          style: TextStyle(
                              fontWeight: FontWeight.w500, fontSize: 18),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Image.asset(
              'assets/images/input_icon.png',
              fit: BoxFit.cover,
              width: 13.w,
            ),
          ],
        ),
      ),
    );
  }
}
