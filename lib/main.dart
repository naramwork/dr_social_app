import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:dr_social/app/themes/color_const.dart';
import 'package:dr_social/controllers/prayer_time_controller.dart';
import 'package:dr_social/theme_widget.dart';
import 'package:dr_social/views/main_layout.dart';
import 'package:dr_social/views/pages/sign_up_page.dart';
import 'package:dr_social/views/pages/splash_screen.dart';
import 'package:dr_social/views/test_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

void main() async {
  AwesomeNotifications().initialize(
      // set the icon to null if you want to use the default app icon
      null,
      [
        NotificationChannel(
            channelKey: 'basic_channel',
            channelName: 'Basic notifications',
            channelDescription: 'Notification channel for basic tests',
            defaultColor: Color(0xFF9D50DD),
            ledColor: Colors.white)
      ]);

  WidgetsFlutterBinding.ensureInitialized();
  final savedThemeMode = await AdaptiveTheme.getThemeMode();
  isDarkMode = savedThemeMode == AdaptiveThemeMode.dark;
  runApp(MyApp(
    savedThemeMode: savedThemeMode,
  ));
}

class MyApp extends StatelessWidget {
  final AdaptiveThemeMode? savedThemeMode;
  const MyApp({Key? key, this.savedThemeMode}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (ctx) => PrayerTimeController(),
        ),
      ],
      child: ResponsiveSizer(builder: (context, orientation, screenType) {
        return ThemeWidget(
          savedThemeMode: savedThemeMode,
          builder: (theme, darkTheme) => MaterialApp(
            theme: theme,
            darkTheme: darkTheme,
            routes: {
              SplashScreen.routeName: (context) => const SplashScreen(),
              MainLayout.routeName: (context) => MainLayout(),
              SignUpPage.routeName: (context) => SignUpPage(),
              TestPage.routeName: (context) => TestPage(),
            },
            builder: (context, child) {
              return Directionality(
                textDirection: TextDirection.rtl,
                child: child ?? Container(),
              );
            },
          ),
        );
      }),
    );
  }
}
