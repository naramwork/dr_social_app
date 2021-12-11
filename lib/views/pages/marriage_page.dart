import 'package:dr_social/app/helper_files/snack_bar.dart';
import 'package:dr_social/controllers/color_mode.dart';
import 'package:dr_social/controllers/user_controller.dart';
import 'package:dr_social/views/components/layout/custom_bottom_app_bar.dart';
import 'package:dr_social/views/components/layout/fap.dart';
import 'package:dr_social/views/components/register/rounded_text_field.dart';
import 'package:dr_social/views/components/rounded_button_widget.dart';
import 'package:dr_social/views/components/static_page_name_container.dart';
import 'package:dr_social/views/main_layout.dart';

import 'package:dr_social/views/pages/register/sign_up_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class MarriagePage extends StatelessWidget {
  static String routeName = '/marriage_page';
  const MarriagePage({Key? key}) : super(key: key);

  void selectPage(int index, BuildContext context) {
    Navigator.of(context).pushNamed(MainLayout.routeName, arguments: index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: const Center(child: Text(' قيد التحضير ')),
      floatingActionButton: FAP(
        onPressed: () {},
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: CustomBottomAppBar(
        selectedIndex: 0,
        selectPage: selectPage,
      ),
    );
  }
}
