import 'package:flutter/material.dart';
import 'package:noti/core/style/app_colors.dart';

final ThemeData appTheme = ThemeData(
  scaffoldBackgroundColor: AppTheme.scaffoldColor,
  appBarTheme: const AppBarTheme(
    backgroundColor: AppTheme.appBarColor,
    elevation: AppTheme.appBarElevation,
    centerTitle: AppTheme.centerTitle,
    titleTextStyle: AppTheme.appBarTitleTextStyle,
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom().copyWith(
      elevation: const MaterialStatePropertyAll<double>(AppTheme.buttonElevation),
      splashFactory: NoSplash.splashFactory,
      overlayColor: const MaterialStatePropertyAll<Color>(Colors.transparent),
      backgroundColor: MaterialStateProperty.resolveWith<Color?>(
        (states) {
          if (states.contains(MaterialState.hovered)) {
            return AppTheme.buttonHover;
          } else if (states.contains(MaterialState.pressed)) {
            return AppTheme.buttonPressed;
          } else if (states.contains(MaterialState.disabled)) {
            return AppTheme.buttonInactive;
          }
          return AppTheme.buttonActive;
        },
      ),
      foregroundColor: const MaterialStatePropertyAll<Color>(AppTheme.buttonForeground),
      textStyle: const MaterialStatePropertyAll<TextStyle>(AppTheme.buttonTextStyle),
    ),
  ),
  textButtonTheme: TextButtonThemeData(
    style: TextButton.styleFrom().copyWith(
      elevation: const MaterialStatePropertyAll<double>(AppTheme.buttonElevation),
      splashFactory: NoSplash.splashFactory,
      overlayColor: const MaterialStatePropertyAll<Color>(Colors.transparent),
      backgroundColor: const MaterialStatePropertyAll<Color>(AppTheme.textButtonBackground),
      foregroundColor: MaterialStateProperty.resolveWith<Color?>(
        (states) {
          if (states.contains(MaterialState.hovered)) {
            return AppTheme.buttonHover;
          } else if (states.contains(MaterialState.pressed)) {
            return AppTheme.buttonPressed;
          } else if (states.contains(MaterialState.disabled)) {
            return AppTheme.buttonInactive;
          }
          return AppTheme.buttonActive;
        },
      ),
      shape: MaterialStateProperty.resolveWith<RoundedRectangleBorder?>(
        (states) {
          if (states.contains(MaterialState.disabled)) {
            return RoundedRectangleBorder(
              side: const BorderSide(
                color: AppTheme.textButtonInactive,
              ),
              borderRadius: BorderRadius.circular(AppTheme.elevatedButtonRadius),
            );
          } else if (states.contains(MaterialState.hovered)) {
            return RoundedRectangleBorder(
              side: const BorderSide(
                color: AppTheme.textButtonHover,
              ),
              borderRadius: BorderRadius.circular(AppTheme.elevatedButtonRadius),
            );
          } else if (states.contains(MaterialState.pressed)) {
            return RoundedRectangleBorder(
              side: const BorderSide(
                color: AppTheme.textButtonPressed,
              ),
              borderRadius: BorderRadius.circular(AppTheme.elevatedButtonRadius),
            );
          }
          return RoundedRectangleBorder(
            side: const BorderSide(
              color: AppTheme.buttonActive,
            ),
            borderRadius: BorderRadius.circular(AppTheme.elevatedButtonRadius),
          );
        },
      ),
      textStyle: const MaterialStatePropertyAll<TextStyle>(AppTheme.textButtonTextStyle),
    ),
  ),
  textTheme: const TextTheme(
    headlineSmall: TextStyle(
      fontWeight: FontWeight.w700,
      color: AppTheme.textColor,
    ),
    headlineLarge: TextStyle(
      fontWeight: FontWeight.w700,
      color: AppTheme.textColor,
    ),
    titleLarge: TextStyle(
      fontSize: AppTheme.titleLargeSize,
      fontWeight: FontWeight.w700,
      color: AppTheme.textColor,
    ),
  ),
);

abstract class AppTheme {
  static const Color scaffoldColor = AppColors.white;
  static const Color indicatorColor = AppColors.white;
  static const Color appBarColor = AppColors.black;
  static const Color textColor = AppColors.black;
  static const Color whiteTextColor = AppColors.white;
  static const Color errorColor = AppColors.red;
  static const Color buttonActive = AppColors.purple;
  static const Color buttonPressed = AppColors.darkPurple;
  static const Color buttonHover = AppColors.lightPurple;
  static const Color buttonInactive = AppColors.darkGrey;
  static const Color buttonForeground = AppColors.white;
  static const Color textButtonBackground = AppColors.white;
  static const Color textButtonActive = AppColors.purple;
  static const Color textButtonPressed = AppColors.darkPurple;
  static const Color textButtonHover = AppColors.lightPurple;
  static const Color textButtonInactive = AppColors.paleGrey;
  static const Color barBackground = AppColors.greyBlue;
  static const Color cardBackground = AppColors.lightGrey;
  static const Color cursorColor = AppColors.black;
  static const Color iconBackground = AppColors.darkGrey;
  static const Color pinputBorder = AppColors.grey;
  static const Color pinputBorderFocused = AppColors.darkPurple;
  static const Color pinputSeparator = AppColors.paleGrey;
  static const Color iconColor = AppColors.paleGrey;
  static const Color iconBorder = AppColors.grey;
  static const double pinputSeparatorSize = 32.0;
  static const double pinputTextSize = 16.0;
  static const double buttonElevation = 0.0;
  static const double appBarElevation = 0.0;
  static const double appBarTitleSize = 16.0;
  static const double textButtonTitleSize = 14.0;
  static const double titleLargeSize = 20.0;
  static const double elevatedButtonTitleSize = 16.0;
  static const double elevatedButtonPadding = 20.0;
  static const double elevatedButtonRadius = 10.0;
  static const double errorBarPadding = 120.0;
  static const double barHeight = 48.0;

  static const bool centerTitle = true;

  static const TextStyle appBarTitleTextStyle = TextStyle(
    fontSize: appBarTitleSize,
    fontWeight: FontWeight.w700,
    color: AppColors.white,
  );

  static const TextStyle errorTextStyle = TextStyle(
    fontWeight: FontWeight.w500,
    color: errorColor,
  );

  static const TextStyle buttonTextStyle = TextStyle(
    fontSize: elevatedButtonTitleSize,
    fontWeight: FontWeight.w700,
  );

  static const TextStyle textButtonTextStyle = TextStyle(
    fontSize: textButtonTitleSize,
    fontWeight: FontWeight.w700,
  );

  static const TextStyle greyTextStyle = TextStyle(
    color: AppColors.darkGrey,
  );

  static const TextStyle greyMediumTextStyle = TextStyle(
    fontSize: appBarTitleSize,
    fontWeight: FontWeight.w500,
    color: AppColors.darkGrey,

  );

  static const TextStyle pinputTextStyle = TextStyle(
    fontSize: pinputTextSize,
    fontWeight: FontWeight.w700,
    color: AppTheme.textColor,
  );

  static const TextStyle pinputSeparatorStyle = TextStyle(
    fontSize: pinputSeparatorSize,
    fontWeight: FontWeight.w700,
    color: AppTheme.pinputSeparator,
  );
}
