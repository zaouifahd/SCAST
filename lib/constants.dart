import 'package:flutter/material.dart';

const appName = 'Pro Web';
const String kAppIconPath = 'assets/images/app-icon.jpg';

List<Map<String, dynamic>> kTabs = [
  {
    'tabName': 'Jio Saavn',
    'icon': Icons.circle_outlined,
    'url': 'https://www.jiosaavn.com/',
  },
  {
    'tabName': 'Wiki',
    'icon': Icons.square_outlined,
    'url': 'https://en.wikipedia.org/wiki/Audio_(song)',
  },
  {
    'tabName': 'Blogger',
    'icon': Icons.group_work_outlined,
    'url': 'https://www.blogger.com/',
  },
];

const String appBarTitle = 'Pro Web';
const String androidBundleId = 'com.aniketmalik.pro_web';

//change this url to set your URL in app
const String websiteInitialUrl = 'https://www.codecanyon.net';

//keep local content of pages of setting screen
const String aboutPageURL = '';
const String privacyPageURL = '';
const String termsPageURL = '';

//Change App id of android and IOS app
const String androidAppId = androidBundleId;

const String iOSAppId = '';

const String shareAppTitle = appName;
const String shareiOSAppMessage = '';
const String shareAndroidAppMessage =
    'Download $appName App from the link : http://play.google.com/store/apps/details?id=$androidAppId';

//To turn on/off ads
const bool showInterstitialAds = true;
const bool showBannerAds = true;

//To turn on/off display of bottom navigation bar
const bool showBottomNavigationBar = true;

//To show/remove splash screen
const bool showSplashScreen = true;

//To remove/display header/footer of website
const bool hideHeader = false;
const bool hideFooter = false;

//Ids for interstitial Ad
const androidInterstitialAdId = 'ca-app-pub-3940256099942544/1033173712';
const iosInterstitialAdId = 'ca-app-pub-3940256099942544/4411468910';

//Ids for banner Ad
const androidBannerAdId = 'ca-app-pub-3940256099942544/6300978111';
const iosBannerAdId = 'ca-app-pub-3940256099942544/2934735716';

//icon to set when get firebase messages
const String notificationIcon = '@mipmap/ic_launcher_squircle';

//path to icons   *** don't change these values**
const String iconPath = 'assets/icons/';

/// All the colors used in the application are defined here
///
/// Update the colors as desired with their dark mode variations below them.
abstract class AppColors {
  static const Color primary = Color(0xFF497FF3);
  static const Color primaryDark = Colors.green;

  static const Color secondary = Color(0xFF0CA8B0);
  static const Color secondaryDark = Color(0xFF0CA8B0);

  static const Color tabbar = Color(0xFF24AAF0);
  static const Color tabbarDark = Color(0xFF66BB6A);

  static const Color accent = Color(0xFF24AAF0);
  static const Color accentDark = Color(0xFF66BB6A);

  static const Color buttonColor = Color(0xFF24AAF0);
  static const Color buttonColorDark = Color(0xFF24AAF0);

  static const Color buttonHighlightColor = Color(0xFF7EA5FF);
  static const Color buttonHighlightColorDark = Color(0xFF7EA5FF);

  static const Color buttonSplashColor = Color(0xFF7EA5FF);
  static const Color buttonSplashColorDark = Color(0xFF7EA5FF);

  // Disabled Color
  static const Color mDisabledColor = Color(0xFFD2D2D2);

  static const Color mWhite = Color(0xFFF4F5FA);
  static const Color errorText = Color(0xFFEF5350);
  static const Color lightGrey = Color(0xFFA8A8A8);
  static const Color backgroundDark = Color.fromRGBO(42, 42, 42, 1);
  static const Color backgroundLight = Color.fromRGBO(248, 248, 248, 1);
}
