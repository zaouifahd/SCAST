import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constants.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeMode themeMode = ThemeMode.system;

  bool get isDarkMode {
    if (themeMode == ThemeMode.system) {
      return themeMode == Brightness.dark;
    } else {
      return themeMode == ThemeMode.dark;
    }
  }

  ThemeProvider(bool darkThemeOn) {
    themeMode = darkThemeOn ? ThemeMode.dark : ThemeMode.light;
  }

  void toggleTheme(bool isOn) async {
    SharedPreferences pref = await SharedPreferences.getInstance();

    if (isOn) {
      themeMode = ThemeMode.dark;
      pref.setBool('isDarkTheme', true);
    } else {
      themeMode = ThemeMode.light;
      pref.setBool('isDarkTheme', false);
    }

    notifyListeners();
  }

  ThemeMode getTheme() => themeMode;
}

class AppThemes {
  static final darkTheme = ThemeData.dark().copyWith(
    colorScheme: const ColorScheme.dark(
      primary: AppColors.primaryDark,
      secondary: AppColors.accentDark,
      background: AppColors.backgroundDark,
      brightness: Brightness.dark,
    ),
    progressIndicatorTheme: const ProgressIndicatorThemeData(
      linearTrackColor: AppColors.primary,
      color: AppColors.primary,
      refreshBackgroundColor: AppColors.primary,
    ),
    primaryColor: AppColors.primaryDark,
    primaryColorLight: AppColors.primaryDark.withAlpha(150),
    splashColor: AppColors.backgroundDark,
    highlightColor: AppColors.backgroundDark,
    scaffoldBackgroundColor: const Color(0xFF303030),
    backgroundColor: AppColors.backgroundDark,
    toggleableActiveColor: AppColors.accentDark,
    sliderTheme: SliderThemeData(
      thumbColor: AppColors.accentDark,
      activeTrackColor: AppColors.accentDark.withAlpha(180),
      activeTickMarkColor: AppColors.primaryDark,
      inactiveTrackColor: AppColors.accentDark.withAlpha(100),
      inactiveTickMarkColor: AppColors.primaryDark,
    ),
    appBarTheme: const AppBarTheme(
      systemOverlayStyle: SystemUiOverlayStyle.light,
      color: Color(0xFF303030),
      elevation: 0,
      titleTextStyle: TextStyle(
        fontSize: 20,
        color: Colors.white,
        fontWeight: FontWeight.w600,
      ),
      iconTheme: IconThemeData(
        color: Colors.white,
      ),
    ),
    iconTheme: const IconThemeData(
      color: Colors.white,
    ),
    indicatorColor: Colors.white,
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.accentDark,
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 10,
        ),
        shape: const RoundedRectangleBorder(
          borderRadius: ThemeGuide.borderRadius,
        ),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: AppColors.accentDark,
        backgroundColor: AppColors.accentDark.withAlpha(20),
        side: const BorderSide(width: 0, color: Colors.transparent),
      ),
    ),
    inputDecorationTheme: const InputDecorationTheme(
      filled: true,
      contentPadding: EdgeInsets.symmetric(
        vertical: 12,
        horizontal: 16,
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: ThemeGuide.borderRadius,
        borderSide: BorderSide(width: 2, color: AppColors.accentDark),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: ThemeGuide.borderRadius,
        borderSide: BorderSide(width: 2, color: AppColors.accentDark),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: ThemeGuide.borderRadius,
        borderSide: BorderSide(width: 2, color: Colors.red),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: ThemeGuide.borderRadius,
        borderSide: BorderSide(width: 2, color: Colors.transparent),
      ),
      disabledBorder: OutlineInputBorder(
        borderRadius: ThemeGuide.borderRadius,
        borderSide: BorderSide(width: 2, color: Colors.transparent),
      ),
      errorMaxLines: 3,
      hintStyle: TextStyle(
        fontWeight: FontWeight.w600,
      ),
      errorStyle: TextStyle(
        fontWeight: FontWeight.w600,
      ),
    ),
    buttonTheme: const ButtonThemeData(
      highlightColor: AppColors.buttonHighlightColorDark,
      splashColor: AppColors.buttonSplashColorDark,
      disabledColor: AppColors.mDisabledColor,
      padding: EdgeInsets.all(12),
      shape: RoundedRectangleBorder(
        borderRadius: ThemeGuide.borderRadius,
        side: BorderSide(
          width: 2,
          color: AppColors.accentDark,
        ),
      ),
    ),
    textTheme: ThemeData.dark().textTheme.copyWith(
          button: const TextStyle(color: AppColors.accentDark),
        ),
  );

  static final lightTheme = ThemeData.light().copyWith(
    colorScheme: const ColorScheme.light(
      primary: AppColors.primary,
      secondary: AppColors.secondary,
      surface: AppColors.mWhite,
      background: Colors.white,
      brightness: Brightness.light,
    ),
    progressIndicatorTheme: const ProgressIndicatorThemeData(
      linearTrackColor: AppColors.primary,
      color: AppColors.primary,
      refreshBackgroundColor: AppColors.primary,
    ),
    primaryColor: AppColors.primary,
    primaryColorLight: AppColors.primary.withAlpha(150),
    splashColor: AppColors.backgroundLight,
    highlightColor: AppColors.backgroundLight,
    backgroundColor: Colors.white,
    scaffoldBackgroundColor: AppColors.backgroundLight,
    toggleableActiveColor: AppColors.secondary,
    dividerColor: const Color.fromARGB(255, 230, 230, 230),
    sliderTheme: SliderThemeData(
      thumbColor: AppColors.secondary,
      activeTrackColor: AppColors.secondary.withAlpha(180),
      activeTickMarkColor: AppColors.primary,
      inactiveTrackColor: AppColors.secondary.withAlpha(100),
      inactiveTickMarkColor: AppColors.primary,
    ),
    appBarTheme: const AppBarTheme(
      systemOverlayStyle: SystemUiOverlayStyle.dark,
      color: AppColors.backgroundLight,
      elevation: 0,
      titleTextStyle: TextStyle(
        fontSize: 20,
        color: Colors.black,
        fontWeight: FontWeight.w600,
      ),
      iconTheme: IconThemeData(color: Colors.black),
    ),
    iconTheme: const IconThemeData(color: Colors.black87),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.buttonColor,
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 10,
        ),
        shape: const RoundedRectangleBorder(
          borderRadius: ThemeGuide.borderRadius,
        ),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: AppColors.secondary,
        backgroundColor: AppColors.secondary.withAlpha(20),
        side: const BorderSide(width: 0, color: Colors.transparent),
      ),
    ),
    inputDecorationTheme: const InputDecorationTheme(
      filled: true,
      fillColor: Color(0xFFEEEEEE),
      contentPadding: EdgeInsets.symmetric(
        vertical: 12,
        horizontal: 16,
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: ThemeGuide.borderRadius,
        borderSide: BorderSide(width: 2, color: AppColors.secondary),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: ThemeGuide.borderRadius,
        borderSide: BorderSide(width: 2, color: AppColors.secondary),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: ThemeGuide.borderRadius,
        borderSide: BorderSide(width: 2, color: Colors.red),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: ThemeGuide.borderRadius,
        borderSide: BorderSide(width: 2, color: Colors.transparent),
      ),
      disabledBorder: OutlineInputBorder(
        borderRadius: ThemeGuide.borderRadius,
        borderSide: BorderSide(width: 2, color: Colors.transparent),
      ),
      errorMaxLines: 3,
      hintStyle: TextStyle(
        fontWeight: FontWeight.w600,
      ),
      errorStyle: TextStyle(
        fontWeight: FontWeight.w600,
      ),
    ),
    buttonTheme: const ButtonThemeData(
      buttonColor: AppColors.mWhite,
      highlightColor: AppColors.buttonHighlightColor,
      splashColor: AppColors.buttonSplashColor,
      disabledColor: AppColors.mDisabledColor,
      padding: EdgeInsets.all(12),
      shape: RoundedRectangleBorder(
        borderRadius: ThemeGuide.borderRadius,
        side: BorderSide(
          width: 2,
          color: AppColors.secondary,
        ),
      ),
    ),
    textTheme: ThemeData.light().textTheme.copyWith(
          button: const TextStyle(color: AppColors.secondary),
        ),
  );
}

abstract class ThemeGuide {
  /// The aspect ration for the product item card
  static const double productItemCardAspectRatio = 1 / 2;
  static const double horizontalProductListContainerAspectRatio = 1 / 1;

  static const EdgeInsets padding5 = EdgeInsets.all(5);
  static const EdgeInsets padding = EdgeInsets.all(8);
  static const EdgeInsets padding10 = EdgeInsets.all(10);
  static const EdgeInsets padding12 = EdgeInsets.all(12);
  static const EdgeInsets padding16 = EdgeInsets.all(16);
  static const EdgeInsets padding20 = EdgeInsets.all(20);

  // Margins
  static const EdgeInsets margin5 = EdgeInsets.all(5);
  static const EdgeInsets margin10 = EdgeInsets.all(10);
  static const EdgeInsets marginV5 = EdgeInsets.symmetric(vertical: 5);
  static const EdgeInsets marginV10 = EdgeInsets.symmetric(vertical: 10);
  static const EdgeInsets marginH5 = EdgeInsets.symmetric(horizontal: 5);
  static const EdgeInsets marginH10 = EdgeInsets.symmetric(horizontal: 10);
  static const EdgeInsets margin20 = EdgeInsets.all(20);

  /// List padding is equal on `LTR` and extra on `Bottom`
  static const EdgeInsets listPadding = EdgeInsets.fromLTRB(10, 10, 10, 120);

  static const BorderRadius borderRadius5 =
      BorderRadius.all(Radius.circular(5));
  static const BorderRadius borderRadius = BorderRadius.all(Radius.circular(8));
  static const BorderRadius borderRadius10 = BorderRadius.all(
    Radius.circular(10),
  );
  static const BorderRadius borderRadius16 = BorderRadius.all(
    Radius.circular(16),
  );
  static const BorderRadius borderRadius20 = BorderRadius.all(
    Radius.circular(20),
  );

  static const BorderRadius borderRadiusBottomSheet = BorderRadius.only(
    topRight: Radius.circular(20),
    topLeft: Radius.circular(20),
  );

  /// Primary box shadow - Light Black Shadow
  static const BoxShadow primaryShadow = BoxShadow(
    color: Color.fromARGB(255, 230, 230, 230),
    blurRadius: 15,
    spreadRadius: 3,
    offset: Offset(0.0, 3.0),
  );

  /// Primary box shadow - dark Black Shadow
  static const BoxShadow primaryShadowDark = BoxShadow(
    color: Colors.black38,
    blurRadius: 15,
    spreadRadius: 3,
    offset: Offset(0.0, 3.0),
  );

  static const BoxShadow productItemCardShadow = BoxShadow(
    color: Color.fromARGB(255, 230, 230, 230),
    blurRadius: 5,
    spreadRadius: 2,
    offset: Offset(0.0, 3.0),
  );

  static const BoxShadow productItemCardShadowDark = BoxShadow(
    color: Colors.black38,
    blurRadius: 5,
    spreadRadius: 2,
    offset: Offset(0.0, 3.0),
  );

  static const BoxShadow textFieldShadow = BoxShadow(
    color: Color.fromARGB(255, 230, 230, 230),
    blurRadius: 20,
    spreadRadius: 2,
    offset: Offset(0.0, 3.0),
  );

  static const BoxShadow textFieldShadowDark = BoxShadow(
    color: Colors.black38,
    blurRadius: 20,
    spreadRadius: 2,
    offset: Offset(0.0, 3.0),
  );

  static const BoxShadow darkShadow = BoxShadow(
    color: Color.fromARGB(100, 150, 150, 150),
    spreadRadius: 1,
    blurRadius: 20,
    offset: Offset(0.0, 2.0),
  );

  /// Checks if the theme is in dark mode
  static bool isDarkMode(BuildContext context) {
    return Theme.of(context).brightness == ThemeData.dark().brightness;
  }
}
