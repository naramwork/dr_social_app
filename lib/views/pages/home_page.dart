import 'dart:math';

import 'package:dr_social/app/themes/color_const.dart';
import 'package:dr_social/views/components/home_page/card_widget.dart';
import 'package:dr_social/views/components/home_page/main_home_card.dart';
import 'package:dr_social/views/components/rounded_button_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: TestWidget(),
    );
  }
}

class TestWidget extends StatelessWidget {
  const TestWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Center(
          child: Card(
            elevation: 4,
            margin: const EdgeInsets.all(0),
            child: Container(
              width: 85.w,
              height: double.infinity,
              color: isDarkMode ? Color(0xff111C2E) : Colors.white,
            ),
          ),
        ),
        SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 2.5.w, vertical: 5.0.w),
            child: Column(
              children: [
                const MainHomeCard(),
                SizedBox(
                  height: 6.h,
                ),
                Card(
                  elevation: 6,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(40.0),
                  ),
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(40.0),
                    ),
                    child: Stack(
                      children: [
                        Positioned.fill(
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(40.0),
                                color: ColorConst.darkTransparent),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                            vertical: 2.h,
                            horizontal: 10.w,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              FittedBox(
                                fit: BoxFit.scaleDown,
                                child: Text(
                                  'تبقى 5 دقائق لآذان المغرب ',
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline1!
                                      .copyWith(fontSize: 16),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              FittedBox(
                                fit: BoxFit.scaleDown,
                                child: Text(
                                  'موعد الآذان 15:02 م',
                                  style: Theme.of(context).textTheme.subtitle2,
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: RoundedButtonWidget(
                    label: Text(
                      'عرض التفاصيل',
                      style: Theme.of(context).textTheme.button,
                    ),
                    width: 45.w,
                    onpressed: () {},
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                CardWidget(
                  topWidget: Positioned(
                    top: -50,
                    right: 10.w,
                    child: Transform.rotate(
                      angle: pi / 4,
                      child: Container(
                        width: 90,
                        height: 90,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.blue.shade300,
                        ),
                        child: Transform.rotate(
                          angle: -pi / 4,
                          child: Center(
                            child: Text(
                              'حديث \nاليوم',
                              textAlign: TextAlign.center,
                              style: Theme.of(context)
                                  .textTheme
                                  .headline1!
                                  .copyWith(fontSize: 14),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  botWidget: Center(
                    child: Text(
                      'وَقُلِ الْحَمْدُ لِلَّهِ الَّذِي لَمْ يَتَّخِذْ وَلَدًا وَلَمْ يَكُنْ لَهُ شَرِيكٌ فِي الْمُلْكِ وَلَمْ يَكُنْ لَهُ وَلِيٌّ مِنَ الذُّلِّ وَكَبِّرْهُ تَكْبِيرًا',
                      style: Theme.of(context).textTheme.headline1,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                SizedBox(
                  height: 10.0.h,
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}
