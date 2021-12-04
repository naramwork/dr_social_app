import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:dr_social/controllers/color_mode.dart';
import 'package:dr_social/views/components/layout/app_drawer.dart';
import 'package:dr_social/views/components/layout/custom_bottom_app_bar.dart';
import 'package:dr_social/views/components/layout/fap.dart';
import 'package:dr_social/views/pages/home_page.dart';
import 'package:dr_social/views/pages/prayer_times_page.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:provider/provider.dart';

class MainLayout extends StatefulWidget {
  static const routeName = '/main';

  final int? index;
  const MainLayout({Key? key, this.index}) : super(key: key);

  @override
  _MainLayoutState createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {
  int _selectedIndex = 0;
  final List<Widget> _pages = [
    HomePage(),
    // PageOne(),
    HomePage(),
    HomePage(),
    PrayerTimesPage(),
  ];

  void changeTheme(BuildContext context) async {
    AdaptiveTheme.of(context).toggleThemeMode();
    final savedThemeMode = await AdaptiveTheme.getThemeMode();

    context
        .read<ColorMode>()
        .changeColorMode(savedThemeMode == AdaptiveThemeMode.dark);
  }

  void selectPage(int index, BuildContext context) {
    setState(() {
      _selectedIndex = index;
      // ColorConst.isDarkMode = !ColorConst.isDarkMode;
      // AdaptiveTheme.of(context).toggleThemeMode();
      // Navigator.of(context).pushNamed(SignUpPage.routeName);
    });
  }

  @override
  Widget build(BuildContext context) {
    final route = ModalRoute.of(context);
    if (route != null) {
      final args = route.settings.arguments;
      if (args != null) {
        _selectedIndex = args as int;
      }
    }
    return Scaffold(
      extendBody: true,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        leading: Builder(
          builder: (BuildContext context) {
            return Container(
              padding: EdgeInsets.only(right: 3.w),
              width: 40.w,
              child: IconButton(
                icon: ImageIcon(
                  const AssetImage('assets/images/menu.png'),
                  color: Theme.of(context).bottomAppBarColor,
                  size: 30,
                ),
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
                tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
              ),
            );
          },
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(left: 3.w),
            child: Icon(
              Icons.notifications_none,
              color: Theme.of(context).bottomAppBarColor,
              size: 8.w,
            ),
          ),
        ],
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(30),
          ),
        ),
      ),
      drawer: AppDrawer(
        selectedIndex: _selectedIndex,
      ),
      body: _pages[widget.index ?? _selectedIndex],
      floatingActionButton: FAP(
        onPressed: () {
          changeTheme(context);
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: CustomBottomAppBar(
        selectedIndex: _selectedIndex,
        selectPage: selectPage,
      ),
    );
  }
}
