import 'package:dr_social/app/helper_files/translate.dart';
import 'package:dr_social/app/themes/color_const.dart';
import 'package:dr_social/controllers/color_mode.dart';
import 'package:dr_social/views/components/rounded_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class QuranSearhDialog extends StatefulWidget {
  final Function onSearch;
  const QuranSearhDialog({Key? key, required this.onSearch}) : super(key: key);

  @override
  State<QuranSearhDialog> createState() => _QuranSearhDialogState();
}

class _QuranSearhDialogState extends State<QuranSearhDialog> {
  List<String> surahsNames = [];
  String? _selectedItem;
  final myController = TextEditingController();
  @override
  void initState() {
    surahsNames = getSurrahsNames();
    _selectedItem = surahsNames.first;
    super.initState();
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the
    // widget tree.
    myController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 5.h),
      elevation: 12,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 5.h),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: context.watch<ColorMode>().isDarkMode
              ? ColorConst.darkCardColor
              : Colors.white,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              height: 2.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'اختر من القائمة',
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    color: context.watch<ColorMode>().isDarkMode
                        ? Colors.white
                        : Colors.black,
                  ),
                ),
                SizedBox(
                  width: 40.w,
                  child: DropdownButton<String>(
                    isExpanded: true,
                    value: _selectedItem,
                    dropdownColor: context.watch<ColorMode>().isDarkMode
                        ? ColorConst.darkCardColor
                        : Colors.white,
                    iconEnabledColor: context.watch<ColorMode>().isDarkMode
                        ? Colors.white
                        : Colors.black,
                    items: surahsNames
                        .map(
                          (e) => DropdownMenuItem<String>(
                            value: e,
                            child: Text(
                              'سورة $e',
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                color: context.watch<ColorMode>().isDarkMode
                                    ? Colors.white
                                    : Colors.black,
                              ),
                            ),
                          ),
                        )
                        .toList(),
                    onChanged: (value) {
                      if (value == null) return;
                      int surahNumber = surahsNames.indexOf(value) + 1;
                      widget.onSearch(surahNumber);
                      Navigator.pop(context);
                    },
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 2.h,
            ),
            Align(
              alignment: Alignment.centerRight,
              child: Text(
                'البحث',
                style: TextStyle(
                  color: context.watch<ColorMode>().isDarkMode
                      ? Colors.white
                      : Colors.black,
                ),
              ),
            ),
            SizedBox(
              height: 2.h,
            ),
            Container(
              height: 8.h,
              padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 1.h),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.grey.shade50),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.search,
                    size: 30,
                    color: Color(0xff538CB2),
                  ),
                  SizedBox(
                    width: 3.w,
                  ),
                  Expanded(
                    child: TextField(
                      controller: myController,
                      autocorrect: false,
                      showCursor: false,
                      onSubmitted: (value) {
                        if (value.contains('سورة')) {
                          value = value.replaceAll('سورة', '');
                        }
                        if (surahsNames.contains(value.trim())) {
                          int surahNumber =
                              surahsNames.indexOf(value.trim()) + 1;

                          widget.onSearch(surahNumber);
                          Navigator.pop(context);
                        }
                      },
                      style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                      ),
                      textAlignVertical: TextAlignVertical.center,
                      textInputAction: TextInputAction.done,
                      decoration: const InputDecoration(
                        hintText: 'السورة',
                        hintMaxLines: 2,
                        hintStyle: TextStyle(color: Colors.grey, fontSize: 14),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 3.h,
            ),
            RoundedButtonWidget(
                label: const Text('موافق'),
                width: 40.w,
                onpressed: () {
                  String value = myController.text;
                  if (value.contains('سورة')) {
                    value = value.replaceAll('سورة', '');
                  }
                  if (surahsNames.contains(value.trim())) {
                    int surahNumber = surahsNames.indexOf(value.trim()) + 1;
                    widget.onSearch(surahNumber);
                    Navigator.pop(context);
                  }
                })
          ],
        ),
      ),
    );
  }

  List<String> getSurrahsNames() {
    List<String> surahsNams = [];
    for (int i = 1; i <= 114; i++) {
      surahsNams.add(getSuranArabicName(i));
    }

    return surahsNams;
  }
}
