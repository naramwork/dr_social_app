import 'package:dr_social/views/components/layout/custom_bottom_app_bar.dart';
import 'package:dr_social/views/components/layout/fap.dart';

import 'package:dr_social/views/main_layout.dart';

import 'package:flutter/material.dart';

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
