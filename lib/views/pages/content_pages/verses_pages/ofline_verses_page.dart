import 'package:dr_social/app/themes/color_const.dart';
import 'package:dr_social/controllers/color_mode.dart';
import 'package:dr_social/controllers/update_content_controler.dart';
import 'package:dr_social/models/verse.dart';
import 'package:dr_social/views/components/content_card_components/card_widget.dart';

import 'package:dr_social/views/components/static_page_name_container.dart';
import 'package:dr_social/views/pages/content_pages/verses_pages/surah_dialog.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class OffLineVersesPage extends StatelessWidget {
  const OffLineVersesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Verse> verses =
        context.watch<UpdateContentController>().verses.take(300).toList();

    return Stack(children: [
      Column(
        children: [
          StaticPageNameContainer(
            pageTitle: '﴿  آيات قرآنية ﴾',
            maxHeight: 27.0.h,
            imageAlignment: Alignment.bottomRight,
            bottomBorderRad: const Radius.elliptical(100, 40),
            backgroundImageUrl: 'assets/images/mosque.png',
          ),
          SizedBox(
            height: 2.h,
          ),
          verses.isEmpty
              ? const Expanded(
                  child: Center(
                    child: CircularProgressIndicator(
                      color: Color(0xFF184B6C),
                    ),
                  ),
                )
              : Expanded(
                  child: ListView.builder(
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: EdgeInsets.only(bottom: 5.h),
                        child: InkWell(
                          onTap: () {
                            showDialog(
                                context: context,
                                builder: (ctx) {
                                  return SurahDialog(
                                    verse: verses[index],
                                  );
                                });
                          },
                          child: CardWidget(
                              hieght: (6.h -
                                  3.h), // container hight - top positione
                              topWidget: Positioned(
                                top: -3.h,
                                right: 10.w,
                                child: Container(
                                  alignment: Alignment.center,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20),
                                  height: 6.h,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(50),
                                    gradient: ColorConst.topCardWidgetGradient,
                                  ),
                                  child: Text(
                                    '${verses[index].surah}: ${verses[index].part.replaceFirst('الجزء', '')}',
                                    style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                              ),
                              botWidget: Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 5.w, vertical: 2.h),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const ContentText(
                                      content:
                                          'بِسْمِ اللَّهِ الرَّحْمَنِ الرَّحِيمِ',
                                      font: 14,
                                    ),
                                    SizedBox(
                                      height: 4.h,
                                    ),
                                    Text(verses[index].content,
                                        style: TextStyle(
                                          height: 1.5,
                                          color: context
                                                  .watch<ColorMode>()
                                                  .isDarkMode
                                              ? Colors.white
                                              : Colors.black,
                                          fontSize: 16,
                                        ),
                                        maxLines: 3,
                                        textAlign: TextAlign.center),
                                    SizedBox(
                                      height: 4.h,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Icon(
                                          Icons.arrow_back,
                                          color: Colors.blue.shade200,
                                        ),
                                        const ContentText(
                                          content:
                                              'صٍدَّقَْ اٌللِهٌ اٌلِعٍَظَِيٌمِ',
                                          font: 14,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              )),
                        ),
                      );
                    },
                  ),
                )
        ],
      ),
      Positioned(
          top: 6.h,
          right: 6.w,
          child: IconButton(
            icon: const Icon(
              Icons.arrow_back,
              size: 35,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          )),
    ]);
  }
}

class ContentText extends StatelessWidget {
  final String content;
  final double font;
  const ContentText({Key? key, required this.content, required this.font})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      content,
      style: TextStyle(
        color:
            context.watch<ColorMode>().isDarkMode ? Colors.white : Colors.black,
        fontWeight: FontWeight.w500,
        fontSize: font,
      ),
      textAlign: TextAlign.center,
    );
  }
}
