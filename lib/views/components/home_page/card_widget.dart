import 'package:dr_social/app/themes/color_const.dart';
import 'package:dr_social/controllers/color_mode.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CardWidget extends StatelessWidget {
  final Widget topWidget;
  final Widget botWidget;

  const CardWidget({Key? key, required this.topWidget, required this.botWidget})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Card(
              elevation: 12,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              child: Container(
                width: double.infinity,
                height: 300,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: context.watch<ColorMode>().isDarkMode
                      ? Theme.of(context).primaryColor
                      : Colors.white38,
                ),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(10, 15, 10, 10),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Icon(
                              Icons.more_vert,
                              color: ColorConst.extraLightBlue,
                            ),
                            Icon(
                              Icons.bookmark,
                              color: ColorConst.extraLightBlue,
                            ),
                            Icon(
                              Icons.favorite,
                              color: ColorConst.extraLightBlue,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: context.watch<ColorMode>().isDarkMode
                                ? Theme.of(context).primaryColorDark
                                : Theme.of(context).primaryColor,
                          ),
                          child: botWidget,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            topWidget,
          ],
        ),
      ),
    );
  }
}
