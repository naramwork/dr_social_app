import 'package:dr_social/controllers/color_mode.dart';
import 'package:dr_social/models/surah.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:quran/quran.dart' as quran;

class SurahContainer extends StatelessWidget {
  final Surah surah;
  const SurahContainer({Key? key, required this.surah}) : super(key: key);

  TextStyle textStyle(BuildContext context) {
    return TextStyle(
      color:
          context.watch<ColorMode>().isDarkMode ? Colors.white : Colors.black,
      fontWeight: FontWeight.w500,
      fontSize: 16,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 4.h),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '﴿ سورة ${surah.name} ﴾',
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                    color: context.watch<ColorMode>().isDarkMode
                        ? Colors.white
                        : Colors.black,
                    fontFamily: 'Almarai',
                  ),
                ),
                Text(
                  '﴿ الجزء ${surah.juzNumber}﴾',
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                    color: context.watch<ColorMode>().isDarkMode
                        ? Colors.white
                        : Colors.black,
                    fontFamily: 'Almarai',
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 5.h,
            ),
            Container(
              padding: EdgeInsets.fromLTRB(25.w, 1.h, 25.w, 0.4.h),
              child: Text(
                'سورة ${surah.name}',
                style: textStyle(context),
                textAlign: TextAlign.center,
              ),
              decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/images/surah_decoration.png'),
                    fit: BoxFit.fill),
              ),
            ),
            SizedBox(
              height: 2.h,
            ),
            Column(
              children: [
                Divider(
                  indent: 4.w,
                  endIndent: 4.w,
                  color: Colors.blue.shade200,
                  height: 4,
                  thickness: 0.8,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Image.asset(
                      'assets/images/quran_side_icon.png',
                      height: 26,
                      width: 26,
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
                      child: Text(
                        quran.getBasmala(),
                        style: textStyle(context),
                      ),
                    ),
                    Image.asset(
                      'assets/images/quran_side_icon.png',
                      height: 26,
                      width: 26,
                    ),
                  ],
                ),
                IntrinsicHeight(
                  child: Row(
                    children: [
                      VerticalDivider(
                        thickness: 0.8,
                        color: Colors.blue.shade200,
                        endIndent: 4,
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 5),
                          child: Text(surah.content,
                              textAlign: TextAlign.right,
                              style: textStyle(context)),
                        ),
                      ),
                      VerticalDivider(
                        thickness: 0.8,
                        color: Colors.blue.shade200,
                        endIndent: 4,
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Image.asset(
                      'assets/images/quran_side_icon.png',
                      height: 26,
                      width: 26,
                    ),
                    Image.asset(
                      'assets/images/quran_side_icon.png',
                      height: 26,
                      width: 26,
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 4),
                  child: Divider(
                    indent: 4.w,
                    endIndent: 4.w,
                    color: Colors.blue.shade200,
                    thickness: 0.8,
                  ),
                ),
              ],
            ),
          ],
        ));
  }
}
