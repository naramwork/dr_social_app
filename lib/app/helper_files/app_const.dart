// SharedPrefrence Const
const String isPrayerNotificationActiveKey = 'prayer_shared_key';
const String isFajerNotificationActiveKey = 'fajer_shared_key';
const String isDuharNotificationActiveKey = 'duhar_shared_key';
const String isMagrbNotificationActiveKey = 'magrb_shared_key';
const String isIshaNotificationActiveKey = 'ish_shared_key';
const String isAsrNotificationActiveKey = 'asr_shared_key';
const String kStorTokenKey = 'token_shared_key';

//Notification Channel
const String kContentChannelGroupKey = 'content_group_channel';
const String kPrayerChannelGroupKey = 'prayer_times_group';
const String kVersesChannleKey = 'verse_channel';
const String kFcmChannleKey = 'fcm_channel';
const String kDuasChannleKey = 'dua_channel';
const String kHadithChannleKey = 'hadith_channel';
const String kFajerChannleKey = 'fajer_time';
const String kduharChannleKey = 'duhar_time';
const String kAsrChannleKey = 'asr_time';
const String kMaghrbChannleKey = 'magrb_time';
const String kishaChannleKey = 'isha_time';

// Hive Const (local Database)
const String kNotificationBoxName = 'prayer_notification';
const String kVerseBoxName = 'verse';
const String kDuaBoxName = 'dua';
const String kHadithBoxName = 'hadith';
const String kUpdateContentBoxName = 'update_content';
const String kUserBoxName = 'user';

// App Urls

const String baseUrl = 'https://naramapps.ga/api/';

const String kGetVersesUrl = '${baseUrl}verses?page=';
const String kGetUpdateUrl = '${baseUrl}updated';
const String kGetRegisterUrl = '${baseUrl}sign_up';
const String kGetLoginUrl = '${baseUrl}login_app_user';
const String kGetLogoutUrl = '${baseUrl}logout_app_user';
const String kUpdateUserFcmUrl = '${baseUrl}update_fcm';
