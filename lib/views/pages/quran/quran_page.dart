import 'package:dr_social/app/helper_files/translate.dart';
import 'package:dr_social/controllers/color_mode.dart';
import 'package:dr_social/models/surah.dart';
import 'package:dr_social/views/components/quran_search_dialog.dart';
import 'package:dr_social/views/pages/quran/surah_container.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:provider/provider.dart';
import 'package:quran/quran.dart' as quran;
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class QuranPage extends StatefulWidget {
  static String routeName = '/quran_page';
  const QuranPage({Key? key}) : super(key: key);

  @override
  State<QuranPage> createState() => _QuranPageState();
}

class _QuranPageState extends State<QuranPage> {
  List<Surah> surahs = [];
  final PagingController<int, Surah> _pagingController =
      PagingController(firstPageKey: 1);
  double fontSize = 16;
  List<Surah> searchSuran = [];

  @override
  void initState() {
    _pagingController.addPageRequestListener((pageKey) {
      getQuran(pageKey);
    });
    super.initState();
  }

  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: context.watch<ColorMode>().isDarkMode
          ? const Color(0xFF184B6C)
          : Colors.white,
      transform: Matrix4.translationValues(0.0, -5.h, 0.0),
      padding: EdgeInsets.fromLTRB(2.w, 5.h, 2.w, 0.h),
      child: Card(
        elevation: 6,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        color: context.watch<ColorMode>().isDarkMode
            ? const Color.fromARGB(255, 0, 10, 22)
            : Colors.grey.shade100,
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 5.w),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () {
                      showDialog(
                          context: context,
                          builder: (ctx) {
                            return QuranSearhDialog(
                              onSearch: onSearch,
                            );
                          });
                    },
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 2.h),
                      child: Row(
                        children: [
                          Icon(
                            Icons.search,
                            color: context.watch<ColorMode>().isDarkMode
                                ? Colors.white
                                : Colors.black,
                          ),
                          SizedBox(
                            width: 2.w,
                          ),
                          Text(
                            'البحث',
                            style: TextStyle(
                              color: context.watch<ColorMode>().isDarkMode
                                  ? Colors.white
                                  : Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const Spacer(),
                  Row(
                    children: [
                      Text(
                        'حجم الخط',
                        style: TextStyle(
                          color: context.watch<ColorMode>().isDarkMode
                              ? Colors.white
                              : Colors.black,
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          setState(() {
                            if (fontSize <= 20) {
                              fontSize++;
                            }
                          });
                        },
                        icon: Icon(
                          Icons.add_circle_outline,
                          color: context.watch<ColorMode>().isDarkMode
                              ? Colors.white
                              : Colors.black,
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          setState(() {
                            if (fontSize >= 10) {
                              fontSize = fontSize - 1;
                            }
                          });
                        },
                        icon: Icon(
                          Icons.remove_circle_outline,
                          color: context.watch<ColorMode>().isDarkMode
                              ? Colors.white
                              : Colors.black,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
            Expanded(
              child: searchSuran.isEmpty
                  ? PagedListView(
                      pagingController: _pagingController,
                      builderDelegate: PagedChildBuilderDelegate<Surah>(
                        itemBuilder: (context, surah, index) {
                          return SurahContainer(
                            surah: surah,
                            fontSize: fontSize,
                          );
                        },
                      ),
                    )
                  : ListView.builder(
                      itemBuilder: (context, i) {
                        return SurahContainer(
                          surah: searchSuran[i],
                          fontSize: fontSize,
                        );
                      },
                      itemCount: searchSuran.length,
                    ),
            ),
          ],
        ),
      ),
    );
  }

  void onSearch(int number) {
    searchSuran.clear();
    _pagingController.refresh();
    for (int juz = 1; juz <= quran.getTotalJuzCount(); juz++) {
      Map<int, List<int>> suarhMap = quran.getSurahAndVersesFromJuz(juz);
      if (suarhMap.containsKey(number)) {
        for (var element in suarhMap.entries) {
          String content = '';
          if (element.key == number) {
            List<int> versesNumbers = element.value;

            for (int i = versesNumbers.first; i <= versesNumbers.last; i++) {
              if (quran.getVerse(element.key, i) != quran.getBasmala()) {
                content +=
                    ' ' + quran.getVerse(element.key, i, verseEndSymbol: true);
              }
            }
            searchSuran.add(Surah(
                number: element.key,
                content: content,
                juzNumber: juz,
                name: getSuranArabicName(element.key)));
          }
        }
      }

      setState(() {});
    }
  }

  Future<List<Surah>> getQuran(int juz) async {
    List<Surah> surahs = [];
    if (juz <= quran.getTotalJuzCount()) {
      Map<int, List<int>> suarhMap = quran.getSurahAndVersesFromJuz(juz);

      for (var element in suarhMap.entries) {
        String content = '';
        List<int> versesNumbers = element.value;
        for (int i = versesNumbers.first; i <= versesNumbers.last; i++) {
          if (quran.getVerse(element.key, i) != quran.getBasmala()) {
            content +=
                ' ' + quran.getVerse(element.key, i, verseEndSymbol: true);
          }
        }

        surahs.add(Surah(
            number: element.key,
            content: content,
            juzNumber: juz,
            name: getSuranArabicName(element.key)));
      }
      if (juz == quran.getTotalJuzCount()) {
        _pagingController.appendLastPage(surahs);
      } else {
        _pagingController.appendPage(surahs, juz + 1);
      }
    }
    return surahs;
  }
}
