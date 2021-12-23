import 'package:dr_social/app/helper_files/functions.dart';
import 'package:dr_social/controllers/update_content_controler.dart';
import 'package:dr_social/models/verse.dart';
import 'package:dr_social/views/components/content_card_components/card_widget.dart';
import 'package:dr_social/views/components/content_card_components/spinner_bottom_widget.dart';
import 'package:dr_social/views/components/content_card_components/triangle_top_widget.dart';
import 'package:dr_social/views/components/content_card_components/verse_top_widget.dart';
import 'package:dr_social/views/components/home_page/azan_time_home_card.dart';
import 'package:dr_social/views/components/home_page/main_home_card.dart';
import 'package:dr_social/views/components/rounded_button_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../components/pages_bg_rectangle.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const PagesBgRectangle(),
        SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 2.5.w, vertical: 5.0.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const MainHomeCard(),
                SizedBox(
                  height: 6.h,
                ),
                const AzanTimeHomeCard(),
                SizedBox(
                  height: 6.h,
                ),
                Consumer<UpdateContentController>(
                  builder: (BuildContext context, value, Widget? child) {
                    Verse? verse = value.verseOfTheDay;
                    return CardWidget(
                      hieght: (6.h - 3.h),
                      topWidget: Positioned(
                        top: -3.h,
                        left: 20.w,
                        right: 20.w,
                        child: VerseTopWidget(
                          surah: verse?.surah ?? '',
                          part: verse?.part ?? '',
                        ),
                      ),
                      botWidget: SpinnerBottomWidget(
                        content: verse?.content ?? '',
                      ),
                    );
                  },
                ),
                SizedBox(
                  height: 1.0.h,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: RoundedButtonWidget(
                    label: const Text(
                      'ايجاد شريك',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w500),
                    ),
                    width: 45.w,
                    onpressed: () {
                      gotToMarriagePage(context);
                    },
                  ),
                ),
                SizedBox(
                  height: 1.h,
                ),
                CardWidget(
                  hieght: (90 - 50),
                  topWidget: const CardTriangleTopWidget(
                    title: 'حديث \nاليوم',
                  ),
                  botWidget: SpinnerBottomWidget(
                    content: context
                            .watch<UpdateContentController>()
                            .hadithOfTheDay
                            ?.content ??
                        '',
                  ),
                ),
                SizedBox(
                  height: 10.h,
                ),
                CardWidget(
                  hieght: (90 - 50),
                  topWidget: const CardTriangleTopWidget(
                    title: 'دعاء \nاليوم',
                  ),
                  botWidget: SpinnerBottomWidget(
                    content: context
                            .watch<UpdateContentController>()
                            .duaOfTheDay
                            ?.content ??
                        '',
                  ),
                ),
                SizedBox(
                  height: 15.0.h,
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
