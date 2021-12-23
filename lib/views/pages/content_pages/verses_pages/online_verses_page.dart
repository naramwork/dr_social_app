import 'package:dr_social/controllers/color_mode.dart';
import 'package:dr_social/controllers/verses_controller.dart';
import 'package:dr_social/models/verse.dart';
import 'package:dr_social/views/components/content_card_components/card_widget.dart';
import 'package:dr_social/views/components/content_card_components/verse_top_widget.dart';

import 'package:dr_social/views/components/static_page_name_container.dart';

import 'package:dr_social/views/pages/content_pages/verses_pages/surah_dialog.dart';

import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:provider/provider.dart';

import 'package:responsive_sizer/responsive_sizer.dart';

class OnlineVersesPage extends StatefulWidget {
  const OnlineVersesPage({Key? key}) : super(key: key);

  @override
  _OnlineVersesPageState createState() => _OnlineVersesPageState();
}

class _OnlineVersesPageState extends State<OnlineVersesPage> {
  final PagingController<int, Verse> _pagingController =
      PagingController(firstPageKey: 1);

  @override
  void initState() {
    super.initState();
    _pagingController.addPageRequestListener((pageKey) {
      context.read<VersesControler>().fetchVerses(pageKey, _pagingController);
    });
  }

  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
        onRefresh: () => Future.sync(
              // 2
              () => _pagingController.refresh(),
            ),
        child: Stack(
          children: [
            Column(children: [
              StaticPageNameContainer(
                pageTitle: '﴿  آيات قرآنية ﴾',
                maxHeight: 27.0.h,
                bottomBorderRad: const Radius.elliptical(100, 40),
                boxFit: BoxFit.contain,
                backgroundImageUrl: 'assets/images/quran.png',
                imageAlignment: Alignment.bottomRight,
              ),
              Expanded(
                child: PagedListView.separated(
                  pagingController: _pagingController,
                  separatorBuilder: (context, index) => const SizedBox(
                    height: 16,
                  ),
                  builderDelegate: PagedChildBuilderDelegate<Verse>(
                    itemBuilder: (context, verse, index) => Padding(
                      padding: EdgeInsets.only(bottom: 4.h, top: 3.h),
                      child: InkWell(
                        onTap: () {
                          showDialog(
                              context: context,
                              builder: (ctx) {
                                return SurahDialog(
                                  verse: verse,
                                );
                              });
                        },
                        child: CardWidget(
                            hieght:
                                (6.h - 3.h), // container hight - top positione
                            topWidget: Positioned(
                              top: -3.h,
                              right: 10.w,
                              child: VerseTopWidget(
                                surah: verse.surah,
                                part: verse.part,
                              ),
                            ),
                            botWidget: Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 5.w, vertical: 2.h),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  buildTextWidget(
                                      'بِسْمِ اللَّهِ الرَّحْمَنِ الرَّحِيمِ',
                                      14),
                                  SizedBox(
                                    height: 4.h,
                                  ),
                                  Text(verse.content.trim(),
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
                                      buildTextWidget(
                                          'صٍدَّقَْ اٌللِهٌ اٌلِعٍَظَِيٌمِ',
                                          14),
                                    ],
                                  ),
                                ],
                              ),
                            )),
                      ),
                    ),
                  ),
                ),
              )
            ]
                // 3
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
              ),
            ),
          ],
        ));
  }

  Widget buildTextWidget(String content, double font) => Text(
        content,
        style: TextStyle(
          color: context.watch<ColorMode>().isDarkMode
              ? Colors.white
              : Colors.black,
          fontWeight: FontWeight.w500,
          fontSize: font,
        ),
        textAlign: TextAlign.center,
      );
}
