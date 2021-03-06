import 'package:dr_social/app/helper_files/functions.dart';
import 'package:dr_social/app/themes/color_const.dart';
import 'package:dr_social/controllers/color_mode.dart';
import 'package:dr_social/controllers/user_controller.dart';
import 'package:dr_social/models/user.dart';
import 'package:dr_social/views/pages/edit_user_page.dart';
import 'package:dr_social/views/pages/register/login_page.dart';

import 'package:dr_social/views/pages/settings_page.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class AppDrawer extends StatelessWidget {
  final int selectedIndex;
  final Function? onTap;
  const AppDrawer({Key? key, this.selectedIndex = 0, this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 65.w,
      child: ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(50),
          bottomLeft: Radius.circular(50),
        ),
        child: Drawer(
          elevation: 6,
          child: Container(
            color: context.watch<ColorMode>().isDarkMode
                ? const Color.fromARGB(255, 0, 10, 22)
                : Colors.white,
            child: ListView(
              // Important: Remove any padding from the ListView.
              padding: EdgeInsets.zero,
              children: [
                SizedBox(
                  height: 7.h,
                ),
                Center(
                  child: Card(
                    child: context.watch<UserController>().user == null
                        ? CircleAvatar(
                            backgroundColor: Colors.grey.shade400,
                            child: const Image(
                                image: AssetImage('assets/images/man.png')),
                            maxRadius: 70,
                          )
                        : CircleAvatar(
                            backgroundColor: Colors.grey.shade400,
                            child: Image(
                              image: NetworkImage(context
                                  .watch<UserController>()
                                  .user!
                                  .imageUrl),
                            ),
                            maxRadius: 70,
                          ),
                    elevation: 6.0,
                    shape: const CircleBorder(),
                    clipBehavior: Clip.antiAlias,
                  ),
                ),
                SizedBox(height: 2.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      context.watch<UserController>().user == null
                          ? '??????'
                          : context.watch<UserController>().user!.name,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: context.watch<ColorMode>().isDarkMode
                              ? Colors.blue.shade300
                              : Colors.black87,
                          fontSize: 18,
                          fontWeight: FontWeight.w500),
                    ),
                    context.watch<UserController>().user != null
                        ? IconButton(
                            onPressed: () {
                              Navigator.pushNamed(
                                  context, EditUserPage.routeName);
                            },
                            icon: Icon(
                              Icons.edit,
                              color: context.watch<ColorMode>().isDarkMode
                                  ? Colors.blue.shade300
                                  : Colors.black87,
                            ),
                          )
                        : Container(),
                  ],
                ),
                SizedBox(
                  height: 2.h,
                ),
                SingleChildScrollView(
                  child: Column(
                    children: [
                      MenuListITem(
                        itemIndex: 0,
                        selectedIndex: selectedIndex,
                        outlineIcon: Icons.home_outlined,
                        fillIcon: Icons.home,
                        label: '????????????????',
                        onTap: () {
                          Navigator.pop(context);
                          onTap!(0, context);
                        },
                      ), // 0

                      MenuListITem(
                        itemIndex: 10,
                        selectedIndex: selectedIndex,
                        outlineIcon: Icons.favorite_outline,
                        fillIcon: Icons.favorite,
                        label: '?????????? ????????',
                        onTap: () {
                          gotToMarriagePage(context);
                        },
                      ), // 1
                      MenuListITem(
                        itemIndex: 1,
                        selectedIndex: selectedIndex,
                        outlineIcon: Icons.play_arrow_outlined,
                        fillIcon: Icons.play_arrow,
                        label: '???????? ????????????',
                        onTap: () {
                          Navigator.pop(context);
                          onTap!(1, context);
                        },
                      ), // 2
                      MenuListITem(
                        itemIndex: 2,
                        selectedIndex: selectedIndex,
                        outlineIcon: Icons.home_outlined,
                        fillIcon: Icons.home,
                        label: '???????????? ????????????',
                        onTap: () {
                          Navigator.pop(context);
                          onTap!(2, context);
                        },
                      ), // 3

                      MenuListITem(
                        itemIndex: 3,
                        selectedIndex: selectedIndex,
                        outlineIcon: Icons.home_outlined,
                        fillIcon: Icons.home,
                        label: '???????????? ????????????',
                        onTap: () {
                          Navigator.pop(context);
                          onTap!(3, context);
                        },
                      ), // 4
                      MenuListITem(
                        itemIndex: 11,
                        selectedIndex: selectedIndex,
                        outlineIcon: Icons.settings_outlined,
                        fillIcon: Icons.settings,
                        label: '????????????????',
                        onTap: () {
                          Navigator.of(context)
                              .pushNamed(SettingsPage.routeName);
                        },
                      ), // 5
                      Divider(
                        color: Colors.grey,
                        thickness: 1.5,
                        indent: 5.w,
                        endIndent: 5.w,
                      ),
                      MenuListITem(
                        itemIndex: 13,
                        selectedIndex: selectedIndex,
                        outlineIcon: Icons.error_outline,
                        fillIcon: Icons.error,
                        label: '?????? ??????????????',
                        onTap: () {},
                      ), // 6
                      MenuListITem(
                        itemIndex: 14,
                        selectedIndex: selectedIndex,
                        outlineIcon: Icons.help_outline,
                        fillIcon: Icons.help,
                        label: '???????? ??????',
                        onTap: () {},
                      ), // 7
                      Consumer<UserController>(
                          builder: (context, userController, child) {
                        User? user = userController.user;
                        return MenuListITem(
                          itemIndex: 8,
                          selectedIndex: selectedIndex,
                          outlineIcon: Icons.logout,
                          fillIcon: Icons.logout,
                          label: user == null ? '?????????? ????????????' : '?????????? ????????',
                          onTap: () async {
                            if (user == null) {
                              Navigator.pushNamed(context, LoginPage.routeName);
                            } else {
                              String token = user.token;
                              bool loggedout = await context
                                  .read<UserController>()
                                  .logoutUser(user.email, token);
                              if (loggedout) {
                                Navigator.pop(context);
                              }
                            }
                          },
                        );
                      }), // 8
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class MenuListITem extends StatelessWidget {
  const MenuListITem({
    Key? key,
    required this.selectedIndex,
    required this.itemIndex,
    required this.onTap,
    required this.label,
    required this.outlineIcon,
    required this.fillIcon,
  }) : super(key: key);

  final int itemIndex;
  final int selectedIndex;
  final Function onTap;
  final String label;
  final IconData outlineIcon;
  final IconData fillIcon;

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return ListTile(
      onTap: () {
        onTap();
      },
      leading: Icon(
        selectedIndex == itemIndex ? fillIcon : outlineIcon,
        color: selectedIndex == itemIndex
            ? ColorConst.lightBlue
            : Colors.grey.shade400,
      ),
      title: Text(
        label,
        style: selectedIndex == itemIndex
            ? theme.textTheme.headline2!.copyWith(color: ColorConst.lightBlue)
            : theme.textTheme.headline2,
      ),
    );
  }
}
