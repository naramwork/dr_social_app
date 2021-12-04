import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:dr_social/app/helper_files/prayer_notification_builder.dart';
import 'package:dr_social/controllers/color_mode.dart';
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
        setNewPrayerChannel(name: 'صلاة الفجر', key: 'fajer_time'),
        setNewPrayerChannel(name: 'صلاة الظهر', key: 'duhar_time'),
        setNewPrayerChannel(name: 'صلاة العصر', key: 'asr_time'),
        setNewPrayerChannel(name: 'صلاة المغرب', key: 'magrb_time'),
        setNewPrayerChannel(name: 'صلاة العشاء', key: 'isha_time'),
      ],
      channelGroups: [
        NotificationChannelGroup(
            channelGroupkey: 'prayer_times_group',
            channelGroupName: 'مواعيد الصلاة')
      ]);

  WidgetsFlutterBinding.ensureInitialized();
  final savedThemeMode = await AdaptiveTheme.getThemeMode();

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
        ChangeNotifierProvider(
          create: (ctx) => ColorMode(savedThemeMode == AdaptiveThemeMode.dark),
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
