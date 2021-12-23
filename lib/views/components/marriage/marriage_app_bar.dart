import 'package:dr_social/controllers/color_mode.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MarriageAppBar extends StatelessWidget implements PreferredSizeWidget {
  final AppBar appBar;
  const MarriageAppBar({Key? key, required this.appBar}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      iconTheme: IconThemeData(
        color:
            context.watch<ColorMode>().isDarkMode ? Colors.white : Colors.black,
        //change your color here
      ),
      backgroundColor: Theme.of(context).primaryColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(30),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(appBar.preferredSize.height);
}
