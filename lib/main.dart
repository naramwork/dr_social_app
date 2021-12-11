import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:dr_social/app/helper_files/app_const.dart';
import 'package:dr_social/app/helper_files/prayer_notification_builder.dart';
import 'package:dr_social/controllers/color_mode.dart';
import 'package:dr_social/controllers/prayer_time_controller.dart';
import 'package:dr_social/controllers/update_content_controler.dart';
import 'package:dr_social/controllers/user_controller.dart';
import 'package:dr_social/controllers/verses_controller.dart';
import 'package:dr_social/models/dua.dart';
import 'package:dr_social/models/hadith.dart';
import 'package:dr_social/models/prayer_notification.dart';
import 'package:dr_social/models/update_content.dart';
import 'package:dr_social/models/user.dart';
import 'package:dr_social/models/verse.dart';
import 'package:dr_social/theme_widget.dart';
import 'package:dr_social/views/main_layout.dart';
import 'package:dr_social/views/pages/content_pages/duas_page.dart';
import 'package:dr_social/views/pages/content_pages/hadith_page.dart';
import 'package:dr_social/views/pages/content_pages/verses_pages/verses_page.dart';
import 'package:dr_social/views/pages/register/login_page.dart';
import 'package:dr_social/views/pages/register/sign_up_page.dart';
import 'package:dr_social/views/pages/settings_page.dart';
import 'package:dr_social/views/pages/splash_screen.dart';
import 'package:dr_social/views/test_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'views/pages/marriage_page.dart';

void main() async {
  await initHive();
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

Future<void> initHive() async {
  await Hive.initFlutter();
  Hive.registerAdapter(PrayerNotificationAdapter());
  Hive.registerAdapter(UpdateContentAdapter());
  Hive.registerAdapter(VerseAdapter());
  Hive.registerAdapter(DuaAdapter());
  Hive.registerAdapter(HadithAdapter());
  Hive.registerAdapter(UserAdapter());
  await Hive.openBox<UpdateContent>(kUpdateContentBoxName);
  await Hive.openBox<Verse>(kVerseBoxName);
  await Hive.openBox<Dua>(kDuaBoxName);
  await Hive.openBox<Hadith>(kHadithBoxName);
  await Hive.openBox<User>(kUserBoxName);
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
          create: (ctx) => VersesControler(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => UpdateContentController(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => UserController(),
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
              MainLayout.routeName: (context) => const MainLayout(),
              SignUpPage.routeName: (context) => const SignUpPage(),
              LoginPage.routeName: (context) => LoginPage(),
              VersesPage.routeName: (context) => const VersesPage(),
              DuasPage.routeName: (context) => const DuasPage(),
              HadithPage.routeName: (context) => const HadithPage(),
              SettingsPage.routeName: (context) => const SettingsPage(),
              MarriagePage.routeName: (context) => const MarriagePage(),
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
