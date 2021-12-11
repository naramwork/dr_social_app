import 'package:dr_social/controllers/color_mode.dart';
import 'package:dr_social/controllers/update_content_controler.dart';
import 'package:dr_social/models/dua.dart';
import 'package:dr_social/models/hadith.dart';
import 'package:dr_social/views/components/content_card_components/bottom_widget.dart';
import 'package:dr_social/views/components/content_card_components/card_widget.dart';
import 'package:dr_social/views/components/content_card_components/icon_triangle_top_widget.dart';
import 'package:dr_social/views/components/pages_bg_rectangle.dart';
import 'package:dr_social/views/components/static_page_name_container.dart';

import 'package:flutter/material.dart';
import 'package:html/parser.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class HadithPage extends StatelessWidget {
  static const routeName = '/hadith_page';

  const HadithPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Hadith> hadith =
        context.watch<UpdateContentController>().hadith.take(300).toList();
    return Scaffold(
      body: Stack(children: [
        const PagesBgRectangle(),
        Column(
          children: [
            StaticPageNameContainer(
              pageTitle: '﴿ الحديث الشريف ﴾',
              maxHeight: 27.0.h,
              bottomBorderRad: const Radius.elliptical(100, 40),
              backgroundImageUrl: 'assets/images/small_mosque.png',
              boxFit: BoxFit.contain,
              imageAlignment: Alignment.bottomRight,
            ),
            hadith.isEmpty
                ? const Expanded(
                    child: Center(
                      child: CircularProgressIndicator(
                        color: Color(0xFF184B6C),
                      ),
                    ),
                  )
                : Expanded(
                    child: ListView.builder(
                      itemCount: hadith.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: EdgeInsets.only(bottom: 5.h, top: 3.h),
                          child: CardWidget(
                            hieght: (7.h -
                                3.8.h), // container hight - top positione
                            topWidget: const IconTriangleTopWidget(
                              icon: ImageIcon(
                                  AssetImage('assets/images/rosary.png'),
                                  color: Colors.white),
                            ),
                            botWidget: BottomWidget(
                              content: _parseHtmlString(
                                  hadith[index].content.trim()),
                            ),
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
      ]),
    );
  }

  String _parseHtmlString(String htmlString) {
    final document = parse(htmlString);
    final String parsedString =
        parse(document.body?.text).documentElement?.text ?? '';

    return parsedString;
  }
}
