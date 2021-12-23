import 'package:dr_social/app/helper_files/functions.dart';
import 'package:dr_social/controllers/color_mode.dart';
import 'package:dr_social/controllers/marriage_controller.dart';
import 'package:dr_social/models/user.dart';
import 'package:dr_social/views/components/layout/custom_bottom_app_bar.dart';
import 'package:dr_social/views/components/layout/fap.dart';
import 'package:dr_social/views/components/marriage/marriage_name_header.dart';
import 'package:dr_social/views/components/marriage/search_container.dart';

import 'package:dr_social/views/components/marriage/marriage_user_small.dart';
import 'package:dr_social/views/pages/marriage/message_page.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class MarriagePage extends StatefulWidget {
  static String routeName = '/marriage_page';
  const MarriagePage({Key? key}) : super(key: key);

  @override
  State<MarriagePage> createState() => _MarriagePageState();
}

class _MarriagePageState extends State<MarriagePage> {
  bool isLoading = true;

  void switchIsloading() {
    setState(() {
      isLoading = !isLoading;
    });
  }

  @override
  void initState() {
    context.read<MarriageController>().getRandomUsers().then((value) {
      setState(() {
        isLoading = false;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(4.w, 8.h, 4.w, 5.h),
            child: Column(
              children: [
                Row(
                  children: [
                    const Expanded(
                      child: MarriageHeadCard(
                        title: 'البحث عن زواج',
                        isActive: true,
                      ),
                    ),
                    SizedBox(
                      width: 4.w,
                    ),
                    Expanded(
                      child: MarriageHeadCard(
                        title: 'الرسائل',
                        onTap: () {
                          Navigator.of(context)
                              .pushNamed(MessagePage.routeName);
                        },
                        isActive: false,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 3.h,
                ),
                SearchContainer(
                  switchLoading: switchIsloading,
                ),
                SizedBox(
                  height: 3.h,
                ),
                Container(
                  padding: EdgeInsets.only(right: 4.w),
                  alignment: Alignment.centerRight,
                  child: Text(
                    'نتائج البحث',
                    style: TextStyle(
                      color: context.watch<ColorMode>().isDarkMode
                          ? Colors.white
                          : Colors.black,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                SizedBox(
                  height: 3.h,
                ),
                Expanded(
                  child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisSpacing: 1.w,
                      mainAxisSpacing: 4.h,
                      childAspectRatio: (40.w / 30.h),
                      crossAxisCount: 2,
                    ),
                    itemCount: context.watch<MarriageController>().user.length,
                    itemBuilder: (BuildContext context, int index) {
                      List<User> users =
                          context.watch<MarriageController>().user;
                      return MarriageUserSmall(
                        user: users[index],
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          isLoading
              ? const Center(child: CircularProgressIndicator())
              : Container(),
        ],
      ),
      floatingActionButton: FAP(
        onPressed: () {},
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: const CustomBottomAppBar(
        selectedIndex: 0,
        selectPage: selectPage,
      ),
    );
  }
}
