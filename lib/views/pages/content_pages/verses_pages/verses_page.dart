import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dr_social/app/helper_files/check_for_contection.dart';
import 'package:dr_social/app/helper_files/connection_status_singleton.dart';
import 'package:dr_social/controllers/color_mode.dart';

import 'package:dr_social/views/pages/content_pages/verses_pages/online_verses_page.dart';

import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import 'ofline_verses_page.dart';

class VersesPage extends StatefulWidget {
  static const routeName = '/verses_page';

  const VersesPage({Key? key}) : super(key: key);

  @override
  State<VersesPage> createState() => _VersesPageState();
}

class _VersesPageState extends State<VersesPage> {
  Map _source = {ConnectivityResult.wifi: true};
  final MyConnectivity _connectivity = MyConnectivity.instance;

  Widget visiablePage = Container();

  @override
  void initState() {
    super.initState();
    switchPage();
  }

  void switchPage() async {
    bool isOnline = await checkForIntern();
    if (isOnline) {
      setState(() {
        visiablePage = const OnlineVersesPage();
      });
    } else {
      setState(() {
        visiablePage = const OffLineVersesPage();
      });
    }
  }

// return true when there is no connection
  bool checkForInternetConnection() {
    _connectivity.initialise();
    _connectivity.myStream.listen((source) {
      setState(() => _source = source);
    });
    return _source.keys.toList()[0] == ConnectivityResult.none;
  }

  @override
  void dispose() {
    _connectivity.disposeStream();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        Center(
          child: Card(
            elevation: 4,
            margin: const EdgeInsets.all(0),
            child: Container(
              width: 85.w,
              height: double.infinity,
              color: context.watch<ColorMode>().isDarkMode
                  ? const Color(0xff111C2E)
                  : Colors.white,
            ),
          ),
        ),
        visiablePage,
      ]),
    );
  }
}
