import 'package:dr_social/app/helper_files/functions.dart';

import 'package:dr_social/views/components/layout/custom_bottom_app_bar.dart';
import 'package:dr_social/views/components/layout/fap.dart';

import 'package:dr_social/views/main_layout.dart';

import 'package:flutter/material.dart';

import 'package:responsive_sizer/responsive_sizer.dart';

class NoInternetPage extends StatelessWidget {
  static String routeName = 'login_page';
  const NoInternetPage({Key? key}) : super(key: key);

  void selectPage(int index, BuildContext context) {
    Navigator.of(context).pushNamed(MainLayout.routeName, arguments: index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: EdgeInsets.all(10.h),
        child: Card(
          elevation: 12,
        ),
      ),
      floatingActionButton: FAP(
        onPressed: () {
          gotToMarriagePage(context);
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: CustomBottomAppBar(
        selectedIndex: 0,
        selectPage: selectPage,
      ),
    );
  }
}
