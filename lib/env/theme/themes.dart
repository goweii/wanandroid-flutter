import 'package:flutter/material.dart';
import 'package:wanandroid/env/color/app_colors.dart';
import 'package:wanandroid/env/dimen/app_dimens.dart';

class Themes {
  static ThemeData _common({
    required ColorScheme colorScheme,
    required TextTheme textTheme,
  }) {
    return ThemeData.from(
      colorScheme: colorScheme,
      textTheme: textTheme.copyWith(
        subtitle1: textTheme.subtitle1?.copyWith(
          fontSize: 16.0,
          fontWeight: FontWeight.bold,
          color: colorScheme.onSurface.withAlpha(230),
        ),
        subtitle2: textTheme.subtitle2?.copyWith(
          fontSize: 14.0,
          fontWeight: FontWeight.normal,
          color: colorScheme.onSurface.withAlpha(180),
        ),
        bodyText1: textTheme.bodyText1?.copyWith(
          fontSize: 15.0,
        ),
        bodyText2: textTheme.bodyText2?.copyWith(
          fontSize: 14.0,
        ),
        caption: textTheme.caption?.copyWith(
          fontSize: 13.0,
          color: colorScheme.onSurface.withAlpha(100),
        ),
      ),
    ).copyWith(
      appBarTheme: const AppBarTheme(
        elevation: 0.0,
        centerTitle: true,
        toolbarHeight: AppDimens.appBarHeight,
        titleTextStyle: TextStyle(
          fontSize: 18.0,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  static ThemeData light() {
    return _common(
      colorScheme: ColorScheme(
        brightness: Brightness.light,
        primary: AppColors.blue,
        primaryVariant: AppColors.blueDark,
        secondary: AppColors.green,
        secondaryVariant: AppColors.greenDark,
        surface: Colors.white,
        background: Colors.grey.shade100,
        error: AppColors.orange,
        onPrimary: Colors.white,
        onSecondary: Colors.white,
        onSurface: Colors.black.withAlpha(230),
        onBackground: Colors.black.withAlpha(230),
        onError: Colors.white,
      ),
      textTheme: Typography.blackMountainView,
    );
  }

  static ThemeData dark() {
    return _common(
      colorScheme: ColorScheme(
        brightness: Brightness.dark,
        primary: AppColors.blueLight,
        primaryVariant: AppColors.blue,
        secondary: AppColors.greenLight,
        secondaryVariant: AppColors.green,
        surface: AppColors.grey.shade800,
        background: AppColors.grey.shade900,
        error: AppColors.orangeLight,
        onPrimary: Colors.black.withAlpha(230),
        onSecondary: Colors.black.withAlpha(230),
        onSurface: Colors.white.withAlpha(230),
        onBackground: Colors.white.withAlpha(230),
        onError: Colors.black.withAlpha(230),
      ),
      textTheme: Typography.whiteMountainView,
    );
  }
}
